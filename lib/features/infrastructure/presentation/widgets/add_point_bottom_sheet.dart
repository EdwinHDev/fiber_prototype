import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import '../../data/local/app_database.dart';
import '../../data/local/daos/infrastructure_dao.dart';
import '../providers/infrastructure_providers.dart';

class AddPointBottomSheet extends ConsumerStatefulWidget {
  final double latitude;
  final double longitude;

  const AddPointBottomSheet({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  ConsumerState<AddPointBottomSheet> createState() =>
      _AddPointBottomSheetState();
}

class _AddPointBottomSheetState extends ConsumerState<AddPointBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _fieldNotesController = TextEditingController();

  String _selectedType = 'Poste';
  String _selectedStatus = 'Nuevo';
  String _selectedColor = '#FFFFFF';
  bool _electricalRisk = false;

  final Map<String, int> _selectedComplements = {};
  ComplementEntity? _complementToAdd;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _fieldNotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final database = ref.watch(appDatabaseProvider);
    final dao = InfrastructureDao(database);

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.cyan.shade50,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.cyan),
                const SizedBox(width: 12),
                const Text(
                  'Nuevo Punto',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildFixedFields(),
                  const SizedBox(height: 24),
                  _buildVariableFields(),
                  const SizedBox(height: 24),
                  _buildComplementsSection(dao),
                  const SizedBox(height: 24),
                  _buildSaveButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFixedFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Campos Fijos',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Nombre',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.label),
          ),
          validator: (value) =>
              value?.isEmpty ?? true ? 'Campo requerido' : null,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            labelText: 'Descripción',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.description),
          ),
          maxLines: 2,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Campo requerido' : null,
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: _selectedType,
          decoration: const InputDecoration(
            labelText: 'Tipo',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.category),
          ),
          items: ['Poste', 'Torre', 'Caja', 'Empalme']
              .map((type) => DropdownMenuItem(value: type, child: Text(type)))
              .toList(),
          onChanged: (value) => setState(() => _selectedType = value!),
        ),
      ],
    );
  }

  Widget _buildVariableFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Campos Variables (Metadata)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: _selectedStatus,
          decoration: const InputDecoration(
            labelText: 'Estado',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.info),
          ),
          items: ['Nuevo', 'Bueno', 'Deteriorado']
              .map(
                (status) =>
                    DropdownMenuItem(value: status, child: Text(status)),
              )
              .toList(),
          onChanged: (value) => setState(() => _selectedStatus = value!),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: _selectedColor,
          decoration: const InputDecoration(
            labelText: 'Color',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.palette),
          ),
          items:
              [
                    {'name': 'Blanco', 'hex': '#FFFFFF'},
                    {'name': 'Gris', 'hex': '#808080'},
                    {'name': 'Negro', 'hex': '#000000'},
                    {'name': 'Rojo', 'hex': '#FF0000'},
                    {'name': 'Azul', 'hex': '#0000FF'},
                  ]
                  .map(
                    (color) => DropdownMenuItem(
                      value: color['hex'],
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Color(
                                int.parse(
                                      color['hex']!.substring(1),
                                      radix: 16,
                                    ) +
                                    0xFF000000,
                              ),
                              border: Border.all(color: Colors.grey),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(color['name']!),
                        ],
                      ),
                    ),
                  )
                  .toList(),
          onChanged: (value) => setState(() => _selectedColor = value!),
        ),
        const SizedBox(height: 12),
        SwitchListTile(
          title: const Text('Riesgo Eléctrico'),
          subtitle: const Text('Indica si el punto tiene riesgo eléctrico'),
          value: _electricalRisk,
          onChanged: (value) => setState(() => _electricalRisk = value),
          secondary: const Icon(Icons.warning_amber),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _fieldNotesController,
          decoration: const InputDecoration(
            labelText: 'Notas de Campo',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.note),
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildComplementsSection(InfrastructureDao dao) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Complementos',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        FutureBuilder<List<ComplementEntity>>(
          future: dao.getAllComplements(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final complements = snapshot.data!;

            if (complements.isEmpty) {
              return const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'No hay complementos disponibles. Agrega complementos primero.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              );
            }

            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<ComplementEntity>(
                        initialValue: _complementToAdd,
                        decoration: const InputDecoration(
                          labelText: 'Seleccionar Complemento',
                          border: OutlineInputBorder(),
                        ),
                        items: complements
                            .where(
                              (c) => !_selectedComplements.containsKey(c.id),
                            )
                            .map(
                              (complement) => DropdownMenuItem(
                                value: complement,
                                child: Text(complement.name),
                              ),
                            )
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _complementToAdd = value),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: _complementToAdd == null
                          ? null
                          : () {
                              setState(() {
                                _selectedComplements[_complementToAdd!.id] = 1;
                                _complementToAdd = null;
                              });
                            },
                      icon: const Icon(Icons.add),
                      label: const Text('Añadir'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (_selectedComplements.isNotEmpty)
                  Card(
                    child: Column(
                      children: _selectedComplements.entries.map((entry) {
                        final complement = complements.firstWhere(
                          (c) => c.id == entry.key,
                        );
                        return ListTile(
                          leading: const Icon(
                            Icons.extension,
                            color: Colors.cyan,
                          ),
                          title: Text(complement.name),
                          subtitle: Text('Cantidad: ${entry.value}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () =>
                                    _decrementComplement(entry.key),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () =>
                                    _incrementComplement(entry.key),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => _removeComplement(entry.key),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  void _incrementComplement(String complementId) {
    setState(() {
      _selectedComplements[complementId] =
          (_selectedComplements[complementId] ?? 0) + 1;
    });
  }

  void _decrementComplement(String complementId) {
    final currentQuantity = _selectedComplements[complementId] ?? 0;
    if (currentQuantity > 1) {
      setState(() {
        _selectedComplements[complementId] = currentQuantity - 1;
      });
    }
  }

  void _removeComplement(String complementId) {
    final currentQuantity = _selectedComplements[complementId] ?? 0;

    if (currentQuantity > 1) {
      showDialog<int>(
        context: context,
        builder: (context) => _QuantityRemovalDialog(
          complementName: 'Complemento',
          currentQuantity: currentQuantity,
        ),
      ).then((quantityToRemove) {
        if (quantityToRemove != null) {
          setState(() {
            final newQuantity = currentQuantity - quantityToRemove;
            if (newQuantity <= 0) {
              _selectedComplements.remove(complementId);
            } else {
              _selectedComplements[complementId] = newQuantity;
            }
          });
        }
      });
    } else {
      setState(() {
        _selectedComplements.remove(complementId);
      });
    }
  }

  Widget _buildSaveButton() {
    return ElevatedButton.icon(
      onPressed: _savePoint,
      icon: const Icon(Icons.save),
      label: const Text('Guardar Punto'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<void> _savePoint() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final metadata = jsonEncode({
        'status': _selectedStatus,
        'color': _selectedColor,
        'electrical_risk': _electricalRisk,
        'field_notes': _fieldNotesController.text,
      });

      final pointId = const Uuid().v4();

      await ref
          .read(infrastructureMapDataProvider.notifier)
          .addPoint(
            pointId: pointId,
            name: _nameController.text,
            type: _selectedType,
            description: _descriptionController.text,
            latitude: widget.latitude,
            longitude: widget.longitude,
            metadata: metadata,
            complementsWithQuantity: _selectedComplements,
          );

      if (mounted) {
        Navigator.pop(context);
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
}

class _QuantityRemovalDialog extends StatefulWidget {
  final String complementName;
  final int currentQuantity;

  const _QuantityRemovalDialog({
    required this.complementName,
    required this.currentQuantity,
  });

  @override
  State<_QuantityRemovalDialog> createState() => _QuantityRemovalDialogState();
}

class _QuantityRemovalDialogState extends State<_QuantityRemovalDialog> {
  late int _quantityToRemove;

  @override
  void initState() {
    super.initState();
    _quantityToRemove = 1;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Eliminar Complementos'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Tienes ${widget.currentQuantity} unidades. ¿Cuántas deseas eliminar?',
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: _quantityToRemove > 1
                    ? () => setState(() => _quantityToRemove--)
                    : null,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$_quantityToRemove',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: _quantityToRemove < widget.currentQuantity
                    ? () => setState(() => _quantityToRemove++)
                    : null,
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, _quantityToRemove),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('Eliminar'),
        ),
      ],
    );
  }
}
