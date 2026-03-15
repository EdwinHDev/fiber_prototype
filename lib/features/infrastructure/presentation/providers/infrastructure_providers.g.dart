// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'infrastructure_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Temporary provider for AppDatabase instance.
/// This should be replaced with a global database provider.

@ProviderFor(appDatabase)
const appDatabaseProvider = AppDatabaseProvider._();

/// Temporary provider for AppDatabase instance.
/// This should be replaced with a global database provider.

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  /// Temporary provider for AppDatabase instance.
  /// This should be replaced with a global database provider.
  const AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'ea95459b990c39de50b01689e0267be9fba32d97';

/// Provider for InfrastructureDao.
/// Depends on the AppDatabase instance.

@ProviderFor(infrastructureDao)
const infrastructureDaoProvider = InfrastructureDaoProvider._();

/// Provider for InfrastructureDao.
/// Depends on the AppDatabase instance.

final class InfrastructureDaoProvider
    extends
        $FunctionalProvider<
          InfrastructureDao,
          InfrastructureDao,
          InfrastructureDao
        >
    with $Provider<InfrastructureDao> {
  /// Provider for InfrastructureDao.
  /// Depends on the AppDatabase instance.
  const InfrastructureDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'infrastructureDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$infrastructureDaoHash();

  @$internal
  @override
  $ProviderElement<InfrastructureDao> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  InfrastructureDao create(Ref ref) {
    return infrastructureDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InfrastructureDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InfrastructureDao>(value),
    );
  }
}

String _$infrastructureDaoHash() => r'44fc2a85b76c6a000d324e653dd845f7ac7c36bb';

/// Provider for the infrastructure repository.
/// This is the single source of truth for infrastructure data operations.

@ProviderFor(infrastructureRepository)
const infrastructureRepositoryProvider = InfrastructureRepositoryProvider._();

/// Provider for the infrastructure repository.
/// This is the single source of truth for infrastructure data operations.

final class InfrastructureRepositoryProvider
    extends
        $FunctionalProvider<
          IInfrastructureRepository,
          IInfrastructureRepository,
          IInfrastructureRepository
        >
    with $Provider<IInfrastructureRepository> {
  /// Provider for the infrastructure repository.
  /// This is the single source of truth for infrastructure data operations.
  const InfrastructureRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'infrastructureRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$infrastructureRepositoryHash();

  @$internal
  @override
  $ProviderElement<IInfrastructureRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IInfrastructureRepository create(Ref ref) {
    return infrastructureRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IInfrastructureRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IInfrastructureRepository>(value),
    );
  }
}

String _$infrastructureRepositoryHash() =>
    r'34f33d06b48d96bafdf9c73261b3f24fa62eabe2';

/// AsyncNotifier for infrastructure map data.
/// Provides reactive GeoJSON FeatureCollection for MapLibre rendering.
/// This is the single source of truth for the map visualization.

@ProviderFor(InfrastructureMapData)
const infrastructureMapDataProvider = InfrastructureMapDataProvider._();

/// AsyncNotifier for infrastructure map data.
/// Provides reactive GeoJSON FeatureCollection for MapLibre rendering.
/// This is the single source of truth for the map visualization.
final class InfrastructureMapDataProvider
    extends
        $AsyncNotifierProvider<InfrastructureMapData, Map<String, dynamic>> {
  /// AsyncNotifier for infrastructure map data.
  /// Provides reactive GeoJSON FeatureCollection for MapLibre rendering.
  /// This is the single source of truth for the map visualization.
  const InfrastructureMapDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'infrastructureMapDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$infrastructureMapDataHash();

  @$internal
  @override
  InfrastructureMapData create() => InfrastructureMapData();
}

String _$infrastructureMapDataHash() =>
    r'96ceca86fd316e2964105bdcd935e5060f190248';

/// AsyncNotifier for infrastructure map data.
/// Provides reactive GeoJSON FeatureCollection for MapLibre rendering.
/// This is the single source of truth for the map visualization.

abstract class _$InfrastructureMapData
    extends $AsyncNotifier<Map<String, dynamic>> {
  FutureOr<Map<String, dynamic>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<Map<String, dynamic>>, Map<String, dynamic>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, dynamic>>,
                Map<String, dynamic>
              >,
              AsyncValue<Map<String, dynamic>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
