import '../../domain/repositories/i_infrastructure_repository.dart';
import '../local/app_database.dart';
import '../local/daos/infrastructure_dao.dart';
import '../mappers/geojson_mappers.dart';

/// Implementation of the infrastructure repository.
/// Handles data operations using the InfrastructureDao and GeoJSON mappers.
class InfrastructureRepositoryImpl implements IInfrastructureRepository {
  final InfrastructureDao _dao;

  const InfrastructureRepositoryImpl(this._dao);

  @override
  Future<Map<String, dynamic>> getInfrastructureGeoJson() async {
    // Fetch all points and lines in parallel for optimal performance
    final results = await Future.wait([
      _dao.getAllPoints(),
      _dao.getAllLines(),
    ]);

    final points = results[0] as List<PointEntity>;
    final lines = results[1] as List<LineEntity>;

    // Transform points to PointWithComplements and convert to GeoJSON
    final pointFeatures = await Future.wait(
      points.map((point) async {
        final pointDetails = await _dao.getPointDetails(point.id);
        if (pointDetails == null) return null;
        return pointDetails.toGeoJson();
      }),
    );

    // Transform lines to LineWithRoute and convert to GeoJSON
    final lineFeatures = await Future.wait(
      lines.map((line) async {
        final lineDetails = await _dao.getLineDetails(line.id);
        if (lineDetails == null) return null;
        return lineDetails.toGeoJson();
      }),
    );

    // Filter out null values and combine all features
    final allFeatures = [
      ...pointFeatures.whereType<Map<String, dynamic>>(),
      ...lineFeatures.whereType<Map<String, dynamic>>(),
    ];

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
