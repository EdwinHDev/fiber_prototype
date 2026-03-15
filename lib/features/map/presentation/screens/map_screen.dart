import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import '../../../infrastructure/presentation/providers/infrastructure_providers.dart';
import '../../../infrastructure/presentation/widgets/add_point_bottom_sheet.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  MapLibreMapController? _mapController;
  bool _isSourceAdded = false;
  bool _isStyleLoaded = false; // Bandera de seguridad arquitectónica

  @override
  Widget build(BuildContext context) {
    final infrastructureData = ref.watch(infrastructureMapDataProvider);

    // REGLA ESTRICTA DE RIVERPOD: ref.listen SIEMPRE dentro de build()
    ref.listen<AsyncValue<Map<String, dynamic>>>(
      infrastructureMapDataProvider,
      (previous, next) {
        if (_isStyleLoaded) {
          next.when(
            data: (geoJsonData) => _updateMapData(geoJsonData),
            loading: () {},
            error: (error, stack) => _showError(error.toString()),
          );
        }
      },
    );

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            MapLibreMap(
              // 1. Tile hiper-limpio de alto contraste (Carto Positron)
              styleString:
                  'https://basemaps.cartocdn.com/gl/positron-gl-style/style.json',

              // 2. Bloquear rotación accidental al hacer zoom
              rotateGesturesEnabled: false,

              // 3. Ocultar la brújula (ya que siempre mirará al Norte)
              compassEnabled: false,

              // Configuraciones base
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMenu,
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddMenu() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final size = renderBox.size;

    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        size.width - 200,
        size.height - 200,
        20,
        20,
      ),
      items: [
        const PopupMenuItem<String>(
          value: 'point',
          child: Row(
            children: [
              Icon(Icons.location_on, color: Colors.cyan),
              SizedBox(width: 12),
              Text('Agregar Punto'),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'line',
          child: Row(
            children: [
              Icon(Icons.timeline, color: Colors.orange),
              SizedBox(width: 12),
              Text('Agregar Línea'),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value == 'point') {
        _showAddPointBottomSheet();
      } else if (value == 'line') {
        // TODO: Implement add line functionality
        _showError('Funcionalidad de agregar línea próximamente');
      }
    });
  }

  void _showAddPointBottomSheet() {
    final controller = _mapController;
    if (controller == null) {
      _showError('Mapa no inicializado');
      return;
    }

    final cameraPosition = controller.cameraPosition;
    if (cameraPosition == null) {
      _showError('No se pudo obtener la posición de la cámara');
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddPointBottomSheet(
        latitude: cameraPosition.target.latitude,
        longitude: cameraPosition.target.longitude,
      ),
    );
  }

  void _onMapCreated(MapLibreMapController controller) {
    _mapController = controller;
  }

  void _onStyleLoaded() {
    _isStyleLoaded = true;
    // Si la data ya cargó antes que el mapa, la inyectamos manualmente la primera vez
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

        // Capa de los Cables
        await controller.addLineLayer(
          'infrastructure-source',
          'lines-layer',
          const LineLayerProperties(
            lineWidth: 3.0,
            lineColor: ['get', 'colorHex'], // Sintaxis correcta MapLibre
          ),
          filter: [
            '==',
            ['geometry-type'],
            'LineString',
          ], // Sintaxis moderna
        );

        // Capa de los Postes
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
            ['geometry-type'],
            'Point',
          ], // Sintaxis moderna
        );

        _isSourceAdded = true;
      }
    } catch (e) {
      _showError('Error renderizando mapa: $e');
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
