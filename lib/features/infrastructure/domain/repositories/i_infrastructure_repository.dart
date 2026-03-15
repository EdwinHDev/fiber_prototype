/// Repository interface for infrastructure data operations.
/// Defines the contract for managing Points (Postes) and Lines (Cables).
abstract class IInfrastructureRepository {
  /// Retrieves all infrastructure data as a GeoJSON FeatureCollection.
  /// Returns a RFC 7946 compliant FeatureCollection containing all Points and Lines.
  Future<Map<String, dynamic>> getInfrastructureGeoJson();

  /// Adds a new point with its associated complements.
  /// 
  /// Parameters:
  /// - [pointId]: Unique identifier for the point
  /// - [name]: Point name
  /// - [type]: Point type
  /// - [description]: Point description
  /// - [latitude]: Geographic latitude
  /// - [longitude]: Geographic longitude
  /// - [metadata]: JSON string with additional metadata
  /// - [complementIds]: List of complement IDs to associate with the point
  Future<void> addPoint({
    required String pointId,
    required String name,
    required String type,
    required String description,
    required double latitude,
    required double longitude,
    required String metadata,
    required List<String> complementIds,
  });

  /// Adds a new line with its ordered route of points.
  /// 
  /// Parameters:
  /// - [lineId]: Unique identifier for the line
  /// - [name]: Line name
  /// - [type]: Line type
  /// - [description]: Line description
  /// - [colorHex]: Hex color code for visualization
  /// - [metadata]: JSON string with additional metadata
  /// - [orderedPointIds]: List of point IDs defining the line route (minimum 2)
  Future<void> addLine({
    required String lineId,
    required String name,
    required String type,
    required String description,
    required String colorHex,
    required String metadata,
    required List<String> orderedPointIds,
  });

  /// Safely deletes a point if it has no associated lines or complements.
  /// Throws an exception if the point is still referenced.
  Future<void> deletePoint(String pointId);

  /// Deletes a line and its associated route.
  Future<void> deleteLine(String lineId);
}
