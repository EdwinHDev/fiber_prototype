import 'dart:convert';
import '../local/models/composite_models.dart';

/// Reserved property keys that cannot be overridden by metadata.
const _pointReservedKeys = {'id', 'name', 'type', 'description', 'complements'};

/// Extension to convert PointWithComplements to GeoJSON Feature (RFC 7946).
extension PointGeoJsonMapper on PointWithComplements {
  /// Converts the point with its complements to a GeoJSON Feature.
  /// Returns a `Map<String, dynamic>` following RFC 7946 specification.
  /// Metadata keys that collide with reserved properties are filtered out.
  Map<String, dynamic> toGeoJson() {
    // Parse metadata JSON safely
    Map<String, dynamic> metadataMap = {};
    try {
      metadataMap = jsonDecode(point.metadata) as Map<String, dynamic>;
    } catch (e) {
      // If metadata parsing fails, use empty map
      metadataMap = {};
    }

    // Sanitize metadata by removing reserved keys
    final sanitizedMetadata = Map<String, dynamic>.fromEntries(
      metadataMap.entries.where(
        (entry) => !_pointReservedKeys.contains(entry.key),
      ),
    );

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
        ...sanitizedMetadata, // Spread sanitized metadata properties
      },
    };
  }
}

/// Reserved property keys that cannot be overridden by metadata.
const _lineReservedKeys = {
  'id',
  'name',
  'type',
  'description',
  'colorHex',
  'pointCount',
};

/// Extension to convert LineWithRoute to GeoJSON Feature (RFC 7946).
extension LineGeoJsonMapper on LineWithRoute {
  /// Converts the line with its ordered route to a GeoJSON Feature.
  /// Returns a `Map<String, dynamic>` following RFC 7946 specification.
  /// Metadata keys that collide with reserved properties are filtered out.
  Map<String, dynamic> toGeoJson() {
    // Parse metadata JSON safely
    Map<String, dynamic> metadataMap = {};
    try {
      metadataMap = jsonDecode(line.metadata) as Map<String, dynamic>;
    } catch (e) {
      // If metadata parsing fails, use empty map
      metadataMap = {};
    }

    // Sanitize metadata by removing reserved keys
    final sanitizedMetadata = Map<String, dynamic>.fromEntries(
      metadataMap.entries.where(
        (entry) => !_lineReservedKeys.contains(entry.key),
      ),
    );

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
        ...sanitizedMetadata, // Spread sanitized metadata properties
      },
    };
  }
}
