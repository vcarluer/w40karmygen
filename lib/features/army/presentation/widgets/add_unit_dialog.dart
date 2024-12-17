import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/datasheet.dart';
import '../../domain/models/datasheet_cost.dart';
import '../../domain/models/faction.dart';
import '../../domain/models/unit.dart';
import '../providers/faction_provider.dart';
import '../providers/dialog_faction_provider.dart';
import '../providers/datasheet_provider.dart';
import '../providers/datasheet_cost_provider.dart';

class UnitSelectionDialog extends ConsumerStatefulWidget {
  const UnitSelectionDialog({
    super.key,
  });

  @override
  ConsumerState<UnitSelectionDialog> createState() => _UnitSelectionDialogState();
}

class _UnitSelectionDialogState extends ConsumerState<UnitSelectionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _pointsController = TextEditingController();
  Datasheet? _selectedDatasheet;
  DatasheetCost? _selectedCost;
  int _quantity = 1;
  String _notes = '';

  @override
  void initState() {
    super.initState();
    // Initialize dialog faction with main page faction
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mainPageFaction = ref.read(selectedFactionProvider);
      ref.read(dialogSelectedFactionProvider.notifier).select(mainPageFaction);
    });
  }

  @override
  void dispose() {
    _pointsController.dispose();
    super.dispose();
  }

  void _selectFirstCostOption(List<DatasheetCost> costs) {
    if (costs.isNotEmpty) {
      setState(() {
        _selectedCost = costs.first;
        _pointsController.text = costs.first.cost.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final factions = ref.watch(factionListProvider);
    final selectedFaction = ref.watch(dialogSelectedFactionProvider);
    final datasheets = ref.watch(filteredDatasheetListProvider);
    final datasheetCosts = ref.watch(datasheetCostNotifierProvider);

    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Unit',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Faction dropdown
              factions.when(
                data: (factionList) => DropdownButtonFormField<Faction?>(
                  decoration: const InputDecoration(
                    labelText: 'Faction',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedFaction,
                  items: [
                    const DropdownMenuItem<Faction?>(
                      value: null,
                      child: Text('All Factions'),
                    ),
                    ...factionList.map((faction) => DropdownMenuItem<Faction?>(
                          value: faction,
                          child: Text(faction.name),
                        )),
                  ],
                  onChanged: (faction) {
                    // Update only the dialog's faction
                    ref.read(dialogSelectedFactionProvider.notifier).select(faction);
                    setState(() {
                      _selectedDatasheet = null;
                      _selectedCost = null;
                      _pointsController.clear();
                    });
                  },
                ),
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => Text('Error loading factions: $error'),
              ),
              const SizedBox(height: 16),
              // Datasheets list
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available Units',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Card(
                        child: ListView.builder(
                          itemCount: datasheets.length,
                          itemBuilder: (context, index) {
                            final datasheet = datasheets[index];
                            return ListTile(
                              title: Text(datasheet.name),
                              selected: _selectedDatasheet?.id == datasheet.id,
                              onTap: () {
                                setState(() {
                                  _selectedDatasheet = datasheet;
                                });
                                // Auto-select first cost option when datasheet is selected
                                if (datasheetCosts.value != null) {
                                  final costs = datasheetCosts.value!
                                      .where((cost) => cost.datasheetId == datasheet.id)
                                      .toList();
                                  _selectFirstCostOption(costs);
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_selectedDatasheet != null) ...[
                const SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Unit Details',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      // Cost options dropdown
                      datasheetCosts.when(
                        data: (costs) {
                          final datasheetCosts = costs
                              .where((cost) => cost.datasheetId == _selectedDatasheet!.id)
                              .toList();
                          return DropdownButtonFormField<DatasheetCost>(
                            decoration: const InputDecoration(
                              labelText: 'Unit Size',
                              border: OutlineInputBorder(),
                            ),
                            value: _selectedCost,
                            items: datasheetCosts.map((cost) => DropdownMenuItem<DatasheetCost>(
                                  value: cost,
                                  child: Text(cost.description),
                                )).toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a unit size';
                              }
                              return null;
                            },
                            onChanged: (cost) {
                              setState(() {
                                _selectedCost = cost;
                                if (cost != null) {
                                  _pointsController.text = cost.cost.toString();
                                } else {
                                  _pointsController.clear();
                                }
                              });
                            },
                          );
                        },
                        loading: () => const CircularProgressIndicator(),
                        error: (error, stack) => Text('Error loading costs: $error'),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Quantity',
                                border: OutlineInputBorder(),
                              ),
                              initialValue: _quantity.toString(),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a quantity';
                                }
                                final quantity = int.tryParse(value);
                                if (quantity == null || quantity < 1) {
                                  return 'Quantity must be at least 1';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _quantity = int.tryParse(value) ?? 1;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Points',
                                border: OutlineInputBorder(),
                              ),
                              controller: _pointsController,
                              enabled: false,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Notes (optional)',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                        onChanged: (value) {
                          setState(() {
                            _notes = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _selectedDatasheet == null || _selectedCost == null
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              final unit = Unit(
                                id: DateTime.now().toIso8601String(),
                                datasheet: _selectedDatasheet!,
                                quantity: _quantity,
                                points: int.parse(_pointsController.text),
                                notes: _notes.isEmpty ? null : _notes,
                              );
                              Navigator.of(context).pop(unit);
                            }
                          },
                    child: const Text('Add Unit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
