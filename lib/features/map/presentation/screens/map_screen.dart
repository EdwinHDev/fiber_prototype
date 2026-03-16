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
  bool _isStyleLoaded = false;
  bool _isSelectingLocation = false;
  Map<String, dynamic>? _pendingPointData;

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
            // 1. Mapa en tamaño completo (NUNCA cambia de tamaño)
            Positioned.fill(
              child: MapLibreMap(
                styleString:
                    'https://basemaps.cartocdn.com/gl/positron-gl-style/style.json',
                rotateGesturesEnabled: false,
                compassEnabled: false,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(7.0, -65.0),
                  zoom: 5.0,
                ),
                onMapCreated: _onMapCreated,
                onStyleLoadedCallback: _onStyleLoaded,
              ),
            ),

            // 2. Indicador de carga
            if (infrastructureData.isLoading)
              const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
                ),
              ),

            // 3. Mira central (solo en modo selección)
            if (_isSelectingLocation)
              IgnorePointer(
                child: Center(
                  child: Icon(
                    Icons.filter_center_focus_outlined,
                    size: 48,
                    color: Colors.red.shade700,
                    shadows: const [Shadow(blurRadius: 4, color: Colors.white)],
                  ),
                ),
              ),

            // 4. Barra inferior de confirmación (solo en modo selección)
            if (_isSelectingLocation)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _cancelLocationSelection,
                          icon: const Icon(Icons.close),
                          label: const Text('Cancelar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _confirmLocationSelection,
                          icon: const Icon(Icons.check),
                          label: const Text('Confirmar Ubicación'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // 5. FAB de agregar (solo en modo normal)
            if (!_isSelectingLocation)
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton(
                  onPressed: _showAddMenu,
                  backgroundColor: Colors.cyan,
                  child: const Icon(Icons.add),
                ),
              ),
          ],
        ),
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

  Future<void> _showAddPointBottomSheet() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddPointBottomSheet(),
    );

    if (result != null && mounted) {
      setState(() {
        _isSelectingLocation = true;
        _pendingPointData = result;
      });
    }
  }

  void _cancelLocationSelection() {
    setState(() {
      _isSelectingLocation = false;
      _pendingPointData = null;
    });
  }

  Future<void> _confirmLocationSelection() async {
    final controller = _mapController;
    final pointData = _pendingPointData;

    if (controller == null || pointData == null) {
      _showError('Error: datos no disponibles');
      return;
    }

    final cameraPosition = controller.cameraPosition;
    if (cameraPosition == null) {
      _showError('No se pudo obtener la posición de la cámara');
      return;
    }

    try {
      final pointId = DateTime.now().millisecondsSinceEpoch.toString();

      await ref
          .read(infrastructureMapDataProvider.notifier)
          .addPoint(
            pointId: pointId,
            name: pointData['name'] as String,
            type: pointData['type'] as String,
            description: pointData['description'] as String,
            latitude: cameraPosition.target.latitude,
            longitude: cameraPosition.target.longitude,
            metadata: pointData['metadata'] as String,
            complementsWithQuantity:
                pointData['complementsWithQuantity'] as Map<String, int>,
          );

      setState(() {
        _isSelectingLocation = false;
        _pendingPointData = null;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Punto guardado exitosamente'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al guardar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _onMapCreated(MapLibreMapController controller) {
    _mapController = controller;
  }

  void _onStyleLoaded() async {
    // Parche de seguridad para el Race Condition nativo de MapLibre
    await Future.delayed(const Duration(milliseconds: 250));

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
            lineColor: ['get', 'colorHex'],
          ),
          filter: ['==', r'$type', 'LineString'],
        );

        // Capa de los Postes
        await controller.addCircleLayer(
          'infrastructure-source',
          'points-layer',
          const CircleLayerProperties(
            circleRadius: 6.0,
            circleColor: ['get', 'color'],
            circleStrokeWidth: 2.0,
            circleStrokeColor: '#FFFFFF',
          ),
          filter: ['==', r'$type', 'Point'],
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
