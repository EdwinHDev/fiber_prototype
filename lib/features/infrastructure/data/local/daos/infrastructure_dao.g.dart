// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'infrastructure_dao.dart';

// ignore_for_file: type=lint
mixin _$InfrastructureDaoMixin on DatabaseAccessor<AppDatabase> {
  $PointsTable get points => attachedDatabase.points;
  $LinesTable get lines => attachedDatabase.lines;
  $ComplementsTable get complements => attachedDatabase.complements;
  $PointComplementsTable get pointComplements =>
      attachedDatabase.pointComplements;
  $LineRoutesTable get lineRoutes => attachedDatabase.lineRoutes;
  InfrastructureDaoManager get managers => InfrastructureDaoManager(this);
}

class InfrastructureDaoManager {
  final _$InfrastructureDaoMixin _db;
  InfrastructureDaoManager(this._db);
  $$PointsTableTableManager get points =>
      $$PointsTableTableManager(_db.attachedDatabase, _db.points);
  $$LinesTableTableManager get lines =>
      $$LinesTableTableManager(_db.attachedDatabase, _db.lines);
  $$ComplementsTableTableManager get complements =>
      $$ComplementsTableTableManager(_db.attachedDatabase, _db.complements);
  $$PointComplementsTableTableManager get pointComplements =>
      $$PointComplementsTableTableManager(
        _db.attachedDatabase,
        _db.pointComplements,
      );
  $$LineRoutesTableTableManager get lineRoutes =>
      $$LineRoutesTableTableManager(_db.attachedDatabase, _db.lineRoutes);
}
