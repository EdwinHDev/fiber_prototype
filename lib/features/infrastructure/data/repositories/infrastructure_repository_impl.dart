import '../../domain/repositories/i_infrastructure_repository.dart';
import '../local/app_database.dart';
import '../local/daos/infrastructure_dao.dart';
import '../local/models/composite_models.dart';
import '../mappers/geojson_mappers.dart';

/// Implementation of the infrastructure repository.
/// Handles data operations using the InfrastructureDao and GeoJSON mappers.
class InfrastructureRepositoryImpl implements IInfrastructureRepository {
  final InfrastructureDao _dao;

  const InfrastructureRepositoryImpl(this._dao);

  @override
  Future<Map<String, dynamic>> getInfrastructureGeoJson() async {
    // Fetch all data in parallel using bulk methods (solves N+1 problem)
    final results = await Future.wait([
      _dao.getAllPointsWithComplements(),
      _dao.getAllLinesWithRoutes(),
    ]);

    final pointsWithComplements = results[0] as List<PointWithComplements>;
    final linesWithRoutes = results[1] as List<LineWithRoute>;

    // Convert to GeoJSON synchronously (data already in memory)
    final pointFeatures = pointsWithComplements
        .map((pointWithComplements) => pointWithComplements.toGeoJson())
        .toList();

    final lineFeatures = linesWithRoutes
        .map((lineWithRoute) => lineWithRoute.toGeoJson())
        .toList();

    // Combine all features
    final allFeatures = [...pointFeatures, ...lineFeatures];

    // Return RFC 7946 compliant FeatureCollection
    return {'type': 'FeatureCollection', 'features': allFeatures};
  }

  @override
  Future<void> addPoint({
    required String pointId,
    required String name,
    required String type,
    required String description,
    required double latitude,
    required double longitude,
    required String metadata,
    required List<String> complementIds,
  }) async {
    final point = PointEntity(
      id: pointId,
      name: name,
      type: type,
      description: description,
      latitude: latitude,
      longitude: longitude,
      metadata: metadata,
    );

    await _dao.insertPointWithComplements(
      point: point,
      complementIds: complementIds,
    );
  }

  @override
  Future<void> addLine({
    required String lineId,
    required String name,
    required String type,
    required String description,
    required String colorHex,
    required String metadata,
    required List<String> orderedPointIds,
  }) async {
    final line = LineEntity(
      id: lineId,
      name: name,
      type: type,
      description: description,
      colorHex: colorHex,
      metadata: metadata,
    );

    await _dao.insertLineWithRoute(
      line: line,
      orderedPointIds: orderedPointIds,
    );
  }

  @override
  Future<void> deletePoint(String pointId) async {
    await _dao.deletePointSafe(pointId);
  }

  @override
  Future<void> deleteLine(String lineId) async {
    await (_dao.delete(_dao.lines)..where((l) => l.id.equals(lineId))).go();
  }
}
