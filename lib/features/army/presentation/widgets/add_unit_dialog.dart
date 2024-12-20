import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/models/datasheet.dart';
import '../../domain/models/datasheet_cost.dart';
import '../../domain/models/faction.dart';
import '../../domain/models/unit.dart';
import '../providers/faction_provider.dart';
import '../providers/dialog_faction_provider.dart';
import '../providers/datasheet_provider.dart';
import '../providers/datasheet_cost_provider.dart';
import '../../data/services/openrouter_service.dart';
import 'package:w40k_army_opti/core/config/env.dart';

final openRouterServiceProvider = Provider((ref) => OpenRouterService(
      apiKey: Env.openRouterApiKey,
    ));

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
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  Datasheet? _selectedDatasheet;
  DatasheetCost? _selectedCost;
  int _quantity = 1;
  String _notes = '';
  bool _isRecognizing = false;
  String? _recognizedFigurineName;
  String _searchQuery = '';

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
    _scrollController.dispose();
    _searchController.dispose();
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

  void _scrollToSelectedUnit(List<Datasheet> datasheets) {
    if (_selectedDatasheet != null) {
      final index = datasheets.indexWhere((d) => d.id == _selectedDatasheet!.id);
      if (index != -1) {
        final itemHeight = 56.0; // Approximate height of a ListTile
        final listHeight = _scrollController.position.viewportDimension;
        final scrollTo = (index * itemHeight) - (listHeight / 2) + (itemHeight / 2);
        
        _scrollController.animateTo(
          scrollTo.clamp(0, _scrollController.position.maxScrollExtent),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  List<Datasheet> _filterDatasheets(List<Datasheet> datasheets) {
    if (_searchQuery.isEmpty) {
      return datasheets;
    }
    final query = _searchQuery.toLowerCase();
    return datasheets.where((datasheet) => 
      datasheet.name.toLowerCase().contains(query)
    ).toList();
  }

  Datasheet? _findMatchingDatasheet(String unitName, List<Datasheet> datasheets) {
    // Convert names to lowercase for case-insensitive comparison
    final searchName = unitName.toLowerCase();
    
    // Try exact match first
    final exactMatch = datasheets.firstWhere(
      (datasheet) => datasheet.name.toLowerCase() == searchName,
      orElse: () => datasheets[0], // Return first datasheet as fallback
    );
    if (exactMatch.name.toLowerCase() == searchName) {
      return exactMatch;
    }

    // Try contains match
    final containsMatch = datasheets.firstWhere(
      (datasheet) => datasheet.name.toLowerCase().contains(searchName) || 
                     searchName.contains(datasheet.name.toLowerCase()),
      orElse: () => datasheets[0], // Return first datasheet as fallback
    );
    if (containsMatch.name.toLowerCase().contains(searchName) || 
        searchName.contains(containsMatch.name.toLowerCase())) {
      return containsMatch;
    }

    // Try word match
    final searchWords = searchName.split(' ');
    for (final datasheet in datasheets) {
      final datasheetWords = datasheet.name.toLowerCase().split(' ');
      if (searchWords.any((word) => datasheetWords.contains(word))) {
        return datasheet;
      }
    }

    return null;
  }

  Future<void> _pickAndRecognizeImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _isRecognizing = true;
          _recognizedFigurineName = null;
        });

        final bytes = await image.readAsBytes();
        final openRouterService = ref.read(openRouterServiceProvider);
        final result = await openRouterService.recognizeUnit(bytes);

        // Find the datasheet with the matching unit name
        final datasheets = ref.read(filteredDatasheetListProvider);
        final matchingDatasheet = _findMatchingDatasheet(result.unitName, datasheets);

        if (matchingDatasheet != null) {
          setState(() {
            _selectedDatasheet = matchingDatasheet;
            _recognizedFigurineName = result.figurineName;
            _isRecognizing = false;
          });

          // Auto-select first cost option
          final costs = ref.read(datasheetCostNotifierProvider).value!
              .where((cost) => cost.datasheetId == matchingDatasheet.id)
              .toList();
          _selectFirstCostOption(costs);

          // Scroll to the selected unit after a short delay to ensure the list is built
          Future.delayed(const Duration(milliseconds: 100), () {
            _scrollToSelectedUnit(datasheets);
          });
        } else {
          throw Exception('No matching unit found for: ${result.unitName}');
        }
      }
    } catch (e) {
      setState(() {
        _isRecognizing = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error recognizing unit: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final factions = ref.watch(factionListProvider);
    final selectedFaction = ref.watch(dialogSelectedFactionProvider);
    final datasheets = ref.watch(filteredDatasheetListProvider);
    final filteredDatasheets = _filterDatasheets(datasheets);
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
                    'Add to Collection',
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
                      _recognizedFigurineName = null;
                    });
                  },
                ),
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => Text('Error loading factions: $error'),
              ),
              const SizedBox(height: 16),
              // Photo import button
              Center(
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: _isRecognizing ? null : _pickAndRecognizeImage,
                      icon: _isRecognizing
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Icon(Icons.photo_camera),
                      label: Text(_isRecognizing ? 'Recognizing...' : 'Import Photo'),
                    ),
                    if (_recognizedFigurineName != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Recognized Figurine: $_recognizedFigurineName',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Datasheets list
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available Miniatures',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    // Search field
                    TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Card(
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: filteredDatasheets.length,
                          itemBuilder: (context, index) {
                            final datasheet = filteredDatasheets[index];
                            return ListTile(
                              title: Text(datasheet.name),
                              selected: _selectedDatasheet?.id == datasheet.id,
                              onTap: () {
                                setState(() {
                                  _selectedDatasheet = datasheet;
                                  _recognizedFigurineName = null;
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
                    if (_selectedDatasheet != null) ...[
                      const SizedBox(height: 8),
                      Card(
                        child: ListTile(
                          title: Text(
                            'Selected Unit: ${_selectedDatasheet!.name}',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
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
                        'Miniature Details',
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
                                labelText: 'Quantity in Collection',
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
                                labelText: 'Points Value',
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
                    child: const Text('Add to Collection'),
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
