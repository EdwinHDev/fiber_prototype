import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/local/app_database.dart';
import '../../data/local/daos/infrastructure_dao.dart';
import '../../data/repositories/infrastructure_repository_impl.dart';
import '../../domain/repositories/i_infrastructure_repository.dart';

part 'infrastructure_providers.g.dart';

// TODO: Replace with global AppDatabase provider when available
/// Temporary provider for AppDatabase instance.
/// This should be replaced with a global database provider.
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  throw UnimplementedError(
    'AppDatabase provider must be overridden with actual instance',
  );
}

/// Provider for InfrastructureDao.
/// Depends on the AppDatabase instance.
@Riverpod(keepAlive: true)
InfrastructureDao infrastructureDao(Ref ref) {
  final database = ref.watch(appDatabaseProvider);
  return InfrastructureDao(database);
}

/// Provider for the infrastructure repository.
/// This is the single source of truth for infrastructure data operations.
@Riverpod(keepAlive: true)
IInfrastructureRepository infrastructureRepository(Ref ref) {
  final dao = ref.watch(infrastructureDaoProvider);
  return InfrastructureRepositoryImpl(dao);
}

/// AsyncNotifier for infrastructure map data.
/// Provides reactive GeoJSON FeatureCollection for MapLibre rendering.
/// This is the single source of truth for the map visualization.
@riverpod
class InfrastructureMapData extends _$InfrastructureMapData {
  @override
  Future<Map<String, dynamic>> build() async {
    final repository = ref.watch(infrastructureRepositoryProvider);
    return repository.getInfrastructureGeoJson();
  }

  /// Refreshes the infrastructure data from the database.
  /// Call this after any CRUD operation to update the map.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(infrastructureRepositoryProvider);
      return repository.getInfrastructureGeoJson();
    });
  }

  /// Adds a new point with complements and refreshes the map.
  Future<void> addPoint({
    required String pointId,
    required String name,
    required String type,
    required String description,
    required double latitude,
    required double longitude,
    required String metadata,
    required Map<String, int> complementsWithQuantity,
  }) async {
    final repository = ref.read(infrastructureRepositoryProvider);
    await repository.addPoint(
      pointId: pointId,
      name: name,
      type: type,
      description: description,
      latitude: latitude,
      longitude: longitude,
      metadata: metadata,
      complementsWithQuantity: complementsWithQuantity,
    );
    await refresh();
  }

  /// Adds a new line with route and refreshes the map.
  Future<void> addLine({
    required String lineId,
    required String name,
    required String type,
    required String description,
    required String colorHex,
    required String metadata,
    required List<String> orderedPointIds,
  }) async {
    final repository = ref.read(infrastructureRepositoryProvider);
    await repository.addLine(
      lineId: lineId,
      name: name,
      type: type,
      description: description,
      colorHex: colorHex,
      metadata: metadata,
      orderedPointIds: orderedPointIds,
    );
    await refresh();
  }

  /// Safely deletes a point and refreshes the map.
  /// Throws an exception if the point has associated lines or complements.
  Future<void> deletePoint(String pointId) async {
    final repository = ref.read(infrastructureRepositoryProvider);
    await repository.deletePoint(pointId);
    await refresh();
  }

  /// Deletes a line and refreshes the map.
  Future<void> deleteLine(String lineId) async {
    final repository = ref.read(infrastructureRepositoryProvider);
    await repository.deleteLine(lineId);
    await refresh();
  }
}
