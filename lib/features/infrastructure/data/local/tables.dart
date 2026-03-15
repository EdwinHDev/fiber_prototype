import 'package:drift/drift.dart';

@DataClassName('PointEntity')
class Points extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get type => text()();
  TextColumn get description => text().nullable()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();

  /// Stores variable properties in JSON format.
  /// Examples: {"material_type": "concrete", "height": 12.5, "diameter": 0.3}
  /// Allows extensibility without modifying the relational schema.
  TextColumn get metadata => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('LineEntity')
class Lines extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get type => text()();
  TextColumn get description => text().nullable()();

  /// Hexadecimal color format (e.g., "#FF5733") for MapLibre rendering.
  TextColumn get colorHex => text().named('color_hex')();

  /// Stores variable properties in JSON format.
  /// Examples: {"fiber_count": "48_fiber", "capacity_gbps": 100}
  /// Allows extensibility without modifying the relational schema.
  TextColumn get metadata => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ComplementEntity')
class Complements extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

/// N:M intermediate table between Points and Complements.
/// Allows a point to have multiple complements (NAT Boxes, Anchors, etc.)
/// and a complement to be associated with multiple points.
@DataClassName('PointComplementEntity')
class PointComplements extends Table {
  TextColumn get pointId => text()
      .named('point_id')
      .references(Points, #id, onDelete: KeyAction.restrict)();
  TextColumn get complementId => text()
      .named('complement_id')
      .references(Complements, #id, onDelete: KeyAction.cascade)();
  IntColumn get quantity => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {pointId, complementId};
}

/// Critical routing table to build the LineString geometry of cables.
/// Defines the ordered sequence of points that make up a cable route.
/// The 'order' column is mandatory and determines the path from start to finish.
/// Example: Line "Main Fiber" connects Point A (order=1) -> Point B (order=2) -> Point C (order=3)
@DataClassName('LineRouteEntity')
class LineRoutes extends Table {
  TextColumn get lineId => text()
      .named('line_id')
      .references(Lines, #id, onDelete: KeyAction.cascade)();
  TextColumn get pointId => text()
      .named('point_id')
      .references(Points, #id, onDelete: KeyAction.restrict)();

  /// Sequential order of the point in the cable route (1, 2, 3, ...).
  /// CRITICAL: This value determines the LineString geometry in GeoJSON.
  IntColumn get order => integer()();

  @override
  Set<Column> get primaryKey => {lineId, pointId};
}
