import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../army/domain/models/faction.dart';
import '../../../army/domain/models/unit.dart';
import '../../../army/presentation/providers/faction_provider.dart';
import '../../../army/presentation/providers/collection_provider.dart';
import '../../../army/presentation/providers/generator_provider.dart';
import '../../../army/presentation/widgets/add_datasheet_dialog.dart';
import '../../../army/presentation/widgets/add_unit_dialog.dart';
import '../../../army/presentation/widgets/generation_result_dialog.dart';
import '../../../army/presentation/pages/generated_armies_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  Future<void> _showEditQuantityDialog(BuildContext context, WidgetRef ref, Unit unit) async {
    final controller = TextEditingController(text: unit.quantity.toString());
    
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Requisition ${unit.datasheet.name}'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: const InputDecoration(
            labelText: 'Quantity',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel Order'),
          ),
          ElevatedButton(
            onPressed: () {
              final quantity = int.tryParse(controller.text);
              if (quantity != null && quantity > 0) {
                ref.read(miniatureCollectionProvider.notifier).updateUnitQuantity(unit.id, quantity);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Confirm Requisition'),
          ),
        ],
      ),
    );
  }

  Future<void> _showGenerateDialog(BuildContext context, WidgetRef ref) async {
    await showGenerationDialog(context, ref);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final factions = ref.watch(factionListProvider);
    final selectedFaction = ref.watch(selectedFactionProvider);
    final collection = ref.watch(miniatureCollectionProvider);
    final filteredCollection = ref.read(miniatureCollectionProvider.notifier).getFilteredUnits(selectedFaction?.id);
    final totalPoints = ref.read(miniatureCollectionProvider.notifier).getTotalPoints();

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.military_tech),
            SizedBox(width: 8),
            Text('Imperial Army Registry'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Battle Records',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const GeneratedArmiesPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.auto_awesome),
            tooltip: 'Deploy Forces',
            onPressed: () => _showGenerateDialog(context, ref),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle),
            tooltip: 'Requisition Units',
            onPressed: () async {
              final unit = await showDialog<Unit>(
                context: context,
                builder: (context) => UnitSelectionDialog(),
              );
              if (unit != null) {
                ref.read(miniatureCollectionProvider.notifier).addUnit(unit);
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showGenerateDialog(context, ref),
        icon: const Icon(Icons.military_tech),
        label: const Text('Deploy Forces'),
        tooltip: 'Generate a new army list',
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface.withOpacity(0.8),
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Imperial Armory Manifest',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border(
                  top: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1),
                  bottom: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: factions.when(
                      data: (factionList) {
                        if (factionList.isEmpty) {
                          return const Center(
                            child: Text('No factions available in the Imperium'),
                          );
                        }
                        return DropdownButton<Faction?>(
                          value: selectedFaction,
                          hint: const Text('Select Force'),
                          isExpanded: true,
                          dropdownColor: Theme.of(context).colorScheme.surface,
                          items: [
                            const DropdownMenuItem<Faction?>(
                              value: null,
                              child: Text('All Forces'),
                            ),
                            ...factionList.map((faction) => DropdownMenuItem(
                                  value: faction,
                                  child: Text(faction.name),
                                )),
                          ],
                          onChanged: (faction) {
                            ref.read(selectedFactionProvider.notifier).select(faction);
                          },
                        );
                      },
                      error: (error, stackTrace) => Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.error_outline,
                                size: 48, color: Theme.of(context).colorScheme.error),
                            const SizedBox(height: 16),
                            Text('Vox transmission error: $error'),
                          ],
                        ),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.secondary),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Force Strength: $totalPoints',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: collection.when(
                data: (units) {
                  if (filteredCollection.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.military_tech,
                            size: 64,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Requisition new units for the Emperor\'s glory',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: filteredCollection.length,
                    itemBuilder: (context, index) {
                      final unit = filteredCollection[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: ListTile(
                          leading: Icon(
                            Icons.shield,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          title: Text(
                            unit.datasheet.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${unit.quantity}x - ${unit.points} points${unit.notes != null ? '\nNotes: ${unit.notes}' : ''}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Theme.of(context).colorScheme.secondary),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'Total: ${unit.points * unit.quantity}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(Icons.edit_document),
                                tooltip: 'Modify Requisition',
                                onPressed: () => _showEditQuantityDialog(context, ref, unit),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_forever),
                                tooltip: 'Discharge Unit',
                                onPressed: () {
                                  ref
                                      .read(miniatureCollectionProvider.notifier)
                                      .removeUnit(unit.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stackTrace) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.error_outline,
                          size: 48, color: Theme.of(context).colorScheme.error),
                      const SizedBox(height: 16),
                      Text('Armory access denied: $error'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
