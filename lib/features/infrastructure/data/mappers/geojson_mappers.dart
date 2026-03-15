import 'dart:convert';
import '../local/models/composite_models.dart';

/// Extension to convert PointWithComplements to GeoJSON Feature (RFC 7946).
extension PointGeoJsonMapper on PointWithComplements {
  /// Converts the point with its complements to a GeoJSON Feature.
  /// Returns a `Map<String, dynamic>` following RFC 7946 specification.
  Map<String, dynamic> toGeoJson() {
    // Parse metadata JSON safely
    Map<String, dynamic> metadataMap = {};
    try {
      metadataMap = jsonDecode(point.metadata) as Map<String, dynamic>;
    } catch (e) {
      // If metadata parsing fails, use empty map
      metadataMap = {};
    }

    return {
      'type': 'Feature',
      'geometry': {
        'type': 'Point',
        'coordinates': [
          point.longitude, // GeoJSON uses [lng, lat] order
          point.latitude,
        ],
      },
      'properties': {
        'id': point.id,
        'name': point.name,
        'type': point.type,
        'description': point.description,
        'complements': complements
            .map((c) => {'id': c.id, 'name': c.name})
            .toList(),
        ...metadataMap, // Spread metadata properties
      },
    };
  }
}

/// Extension to convert LineWithRoute to GeoJSON Feature (RFC 7946).
extension LineGeoJsonMapper on LineWithRoute {
  /// Converts the line with its ordered route to a GeoJSON Feature.
  /// Returns a `Map<String, dynamic>` following RFC 7946 specification.
  Map<String, dynamic> toGeoJson() {
    // Parse metadata JSON safely
    Map<String, dynamic> metadataMap = {};
    try {
      metadataMap = jsonDecode(line.metadata) as Map<String, dynamic>;
    } catch (e) {
      // If metadata parsing fails, use empty map
      metadataMap = {};
    }

    // Build LineString coordinates from ordered points
    final coordinates = orderedPoints
        .map(
          (point) => [
            point.longitude, // GeoJSON uses [lng, lat] order
            point.latitude,
          ],
        )
        .toList();

    return {
      'type': 'Feature',
      'geometry': {'type': 'LineString', 'coordinates': coordinates},
      'properties': {
        'id': line.id,
        'name': line.name,
        'type': line.type,
        'description': line.description,
        'colorHex': line.colorHex,
        'pointCount': orderedPoints.length,
        ...metadataMap, // Spread metadata properties
      },
    };
  }
}
