import '../app_database.dart';

/// Helper class to hold a complement with its quantity.
class ComplementWithQuantity {
  final ComplementEntity complement;
  final int quantity;

  const ComplementWithQuantity({
    required this.complement,
    required this.quantity,
  });

  @override
  String toString() =>
      'ComplementWithQuantity(complement: ${complement.id}, quantity: $quantity)';
}

/// Composite model for a Point with its associated Complements and quantities.
/// Used for querying and displaying complete point information.
class PointWithComplements {
  final PointEntity point;
  final List<ComplementWithQuantity> complements;

  const PointWithComplements({required this.point, required this.complements});

  @override
  String toString() =>
      'PointWithComplements(point: ${point.id}, complements: ${complements.length})';
}

/// Composite model for a Line with its ordered route of Points.
/// The points list is ordered according to the LineRoutes.order column.
class LineWithRoute {
  final LineEntity line;
  final List<PointEntity> orderedPoints;

  const LineWithRoute({required this.line, required this.orderedPoints});

  @override
  String toString() =>
      'LineWithRoute(line: ${line.id}, points: ${orderedPoints.length})';
}
