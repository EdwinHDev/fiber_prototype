import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables.dart';
import '../models/composite_models.dart';

part 'infrastructure_dao.g.dart';

@DriftAccessor(
  tables: [Points, Lines, Complements, PointComplements, LineRoutes],
)
class InfrastructureDao extends DatabaseAccessor<AppDatabase>
    with _$InfrastructureDaoMixin {
  InfrastructureDao(super.db);

  /// Inserts a point with its associated complements in a transaction.
  Future<void> insertPointWithComplements({
    required PointEntity point,
    required List<String> complementIds,
  }) async {
    await transaction(() async {
      await into(points).insert(point);

      if (complementIds.isNotEmpty) {
        await batch((batch) {
          for (final complementId in complementIds) {
            batch.insert(
              pointComplements,
              PointComplementEntity(
                pointId: point.id,
                complementId: complementId,
              ),
            );
          }
        });
      }
    });
  }

  /// Inserts a line with its ordered route of points in a transaction.
  /// Validates that at least 2 points are provided.
  Future<void> insertLineWithRoute({
    required LineEntity line,
    required List<String> orderedPointIds,
  }) async {
    if (orderedPointIds.length < 2) {
      throw Exception(
        'Una línea requiere al menos 2 puntos. Recibidos: ${orderedPointIds.length}',
      );
    }

    await transaction(() async {
      await into(lines).insert(line);

      await batch((batch) {
        for (int i = 0; i < orderedPointIds.length; i++) {
          batch.insert(
            lineRoutes,
            LineRouteEntity(
              lineId: line.id,
              pointId: orderedPointIds[i],
              order: i + 1, // 1-indexed order
            ),
          );
        }
      });
    });
  }

  /// Retrieves a point with all its associated complements.
  Future<PointWithComplements?> getPointDetails(String pointId) async {
    final query = select(points).join([
      leftOuterJoin(
        pointComplements,
        pointComplements.pointId.equalsExp(points.id),
      ),
      leftOuterJoin(
        complements,
        complements.id.equalsExp(pointComplements.complementId),
      ),
    ])..where(points.id.equals(pointId));

    final results = await query.get();

    if (results.isEmpty) return null;

    final point = results.first.readTable(points);
    final complementsList = results
        .map((row) => row.readTableOrNull(complements))
        .where((c) => c != null)
        .cast<ComplementEntity>()
        .toList();

    return PointWithComplements(point: point, complements: complementsList);
  }

  /// Retrieves a line with its ordered route of points.
  Future<LineWithRoute?> getLineDetails(String lineId) async {
    final query =
        select(lines).join([
            innerJoin(lineRoutes, lineRoutes.lineId.equalsExp(lines.id)),
            innerJoin(points, points.id.equalsExp(lineRoutes.pointId)),
          ])
          ..where(lines.id.equals(lineId))
          ..orderBy([OrderingTerm.asc(lineRoutes.order)]);

    final results = await query.get();

    if (results.isEmpty) return null;

    final line = results.first.readTable(lines);
    final orderedPointsList = results
        .map((row) => row.readTable(points))
        .toList();

    return LineWithRoute(line: line, orderedPoints: orderedPointsList);
  }

  /// Safely deletes a point only if it has no associated lines or complements.
  /// Throws an exception if the point is still referenced.
  /// Uses COUNT() aggregation for optimal performance.
  Future<void> deletePointSafe(String pointId) async {
    await transaction(() async {
      // Check for associated line routes using COUNT() aggregation
      final lineRoutesCount =
          await (selectOnly(lineRoutes)
                ..addColumns([lineRoutes.lineId.count()])
                ..where(lineRoutes.pointId.equals(pointId)))
              .getSingle()
              .then((row) => row.read(lineRoutes.lineId.count()) ?? 0);

      // Check for associated complements using COUNT() aggregation
      final pointComplementsCount =
          await (selectOnly(pointComplements)
                ..addColumns([pointComplements.pointId.count()])
                ..where(pointComplements.pointId.equals(pointId)))
              .getSingle()
              .then((row) => row.read(pointComplements.pointId.count()) ?? 0);

      if (lineRoutesCount > 0 || pointComplementsCount > 0) {
        throw Exception(
          'No se puede eliminar: el poste tiene cables o complementos asociados.',
        );
      }

      // Safe to delete
      await (delete(points)..where((p) => p.id.equals(pointId))).go();
    });
  }

  /// Retrieves all points.
  Future<List<PointEntity>> getAllPoints() => select(points).get();

  /// Retrieves all lines.
  Future<List<LineEntity>> getAllLines() => select(lines).get();

  /// Retrieves all complements.
  Future<List<ComplementEntity>> getAllComplements() =>
      select(complements).get();

  /// Retrieves all points with their complements in a single query.
  /// Solves N+1 problem by using JOIN and in-memory grouping.
  Future<List<PointWithComplements>> getAllPointsWithComplements() async {
    final query = select(points).join([
      leftOuterJoin(
        pointComplements,
        pointComplements.pointId.equalsExp(points.id),
      ),
      leftOuterJoin(
        complements,
        complements.id.equalsExp(pointComplements.complementId),
      ),
    ]);

    final results = await query.get();

    // Group results in memory by point ID
    final Map<String, PointWithComplements> pointsMap = {};

    for (final row in results) {
      final point = row.readTable(points);
      final complement = row.readTableOrNull(complements);

      if (!pointsMap.containsKey(point.id)) {
        pointsMap[point.id] = PointWithComplements(
          point: point,
          complements: [],
        );
      }

      if (complement != null) {
        pointsMap[point.id]!.complements.add(complement);
      }
    }

    return pointsMap.values.toList();
  }

  /// Retrieves all lines with their ordered routes in a single query.
  /// Solves N+1 problem by using JOIN and in-memory grouping.
  Future<List<LineWithRoute>> getAllLinesWithRoutes() async {
    final query = select(lines).join([
      innerJoin(lineRoutes, lineRoutes.lineId.equalsExp(lines.id)),
      innerJoin(points, points.id.equalsExp(lineRoutes.pointId)),
    ])..orderBy([OrderingTerm.asc(lineRoutes.order)]);

    final results = await query.get();

    // Group results in memory by line ID
    final Map<String, LineWithRoute> linesMap = {};

    for (final row in results) {
      final line = row.readTable(lines);
      final point = row.readTable(points);

      if (!linesMap.containsKey(line.id)) {
        linesMap[line.id] = LineWithRoute(line: line, orderedPoints: []);
      }

      linesMap[line.id]!.orderedPoints.add(point);
    }

    return linesMap.values.toList();
  }
}
