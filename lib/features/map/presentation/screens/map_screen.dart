import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import '../../../infrastructure/presentation/providers/infrastructure_providers.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  MapLibreMapController? _mapController;
  bool _isSourceAdded = false;

  @override
  Widget build(BuildContext context) {
    final infrastructureData = ref.watch(infrastructureMapDataProvider);

    return Scaffold(
      body: Stack(
        children: [
          MapLibreMap(
            styleString: MapLibreStyles.demo,
            initialCameraPosition: const CameraPosition(
              target: LatLng(7.0, -65.0),
              zoom: 5.0,
            ),
            onMapCreated: _onMapCreated,
            onStyleLoadedCallback: _onStyleLoaded,
          ),
          if (infrastructureData.isLoading)
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
              ),
            ),
        ],
      ),
    );
  }

  void _onMapCreated(MapLibreMapController controller) {
    _mapController = controller;
  }

  void _onStyleLoaded() {
    ref.listen<AsyncValue<Map<String, dynamic>>>(
      infrastructureMapDataProvider,
      (previous, next) {
        next.when(
          data: (geoJsonData) => _updateMapData(geoJsonData),
          loading: () {},
          error: (error, stack) => _showError(error.toString()),
        );
      },
    );

    final currentData = ref.read(infrastructureMapDataProvider);
    if (currentData is AsyncData<Map<String, dynamic>>) {
      _updateMapData(currentData.value);
    }
  }

  Future<void> _updateMapData(Map<String, dynamic> geoJsonData) async {
    final controller = _mapController;
    if (controller == null) return;

    try {
      if (_isSourceAdded) {
        await controller.setGeoJsonSource('infrastructure-source', geoJsonData);
      } else {
        await controller.addGeoJsonSource('infrastructure-source', geoJsonData);

        await controller.addLineLayer(
          'infrastructure-source',
          'lines-layer',
          const LineLayerProperties(
            lineWidth: 3.0,
            lineColor: [Expressions.get, 'colorHex'],
          ),
          filter: [
            '==',
            ['\$type'],
            'LineString',
          ],
        );

        await controller.addCircleLayer(
          'infrastructure-source',
          'points-layer',
          const CircleLayerProperties(
            circleRadius: 5.0,
            circleColor: '#00FFFF',
            circleStrokeWidth: 1.5,
            circleStrokeColor: '#000000',
          ),
          filter: [
            '==',
            ['\$type'],
            'Point',
          ],
        );

        _isSourceAdded = true;
      }
    } catch (e) {
      _showError('Error updating map: $e');
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
