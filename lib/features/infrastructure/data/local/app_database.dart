import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import 'tables.dart';

part 'app_database.g.dart';

/// Main database for Fiber Prototype.
/// Manages all Cix Telecom infrastructure using Drift (SQLite).
///
/// Included tables:
/// - Points: Geographic points (GeoJSON Point)
/// - Lines: Fiber optic lines (GeoJSON LineString inferred from LineRoutes)
/// - Complements: Modular elements (NAT Boxes, Anchors)
/// - PointComplements: N:M relationship between Points and Complements
/// - LineRoutes: Routing table that defines the sequence of points for each line
@DriftDatabase(
  tables: [Points, Lines, Complements, PointComplements, LineRoutes],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // Future migrations will be implemented here
    },
  );
}

/// Configures the SQLite connection using sqlite3_flutter_libs for native compatibility.
/// The database file is stored in the application's documents directory.
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'fiber_prototype.db'));

    // Android-specific configuration: loads the native sqlite3 library
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // iOS configuration: sets the temporary directory for sqlite3
    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
