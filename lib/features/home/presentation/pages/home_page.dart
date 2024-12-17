import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../army/domain/models/faction.dart';
import '../../../army/domain/models/unit.dart';
import '../../../army/presentation/providers/faction_provider.dart';
import '../../../army/presentation/providers/army_provider.dart';
import '../../../army/presentation/widgets/add_datasheet_dialog.dart';
import '../../../army/presentation/widgets/add_unit_dialog.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  Future<void> _showEditQuantityDialog(BuildContext context, WidgetRef ref, Unit unit) async {
    final controller = TextEditingController(text: unit.quantity.toString());
    
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit ${unit.datasheet.name} Quantity'),
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
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final quantity = int.tryParse(controller.text);
              if (quantity != null && quantity > 0) {
                ref.read(armyListProvider.notifier).updateUnitQuantity(unit.id, quantity);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final factions = ref.watch(factionListProvider);
    final selectedFaction = ref.watch(selectedFactionProvider);
    final army = ref.watch(armyListProvider);
    final filteredArmy = ref.read(armyListProvider.notifier).getFilteredUnits(selectedFaction?.id);
    final totalPoints = ref.read(armyListProvider.notifier).getTotalPoints();

    return Scaffold(
      appBar: AppBar(
        title: const Text('W40K Army Builder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final unit = await showDialog<Unit>(
                context: context,
                builder: (context) => UnitSelectionDialog(),
              );
              if (unit != null) {
                ref.read(armyListProvider.notifier).addUnit(unit);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: factions.when(
                    data: (factionList) {
                      if (factionList.isEmpty) {
                        return const Center(
                          child: Text('No factions available'),
                        );
                      }
                      return DropdownButton<Faction?>(
                        value: selectedFaction,
                        hint: const Text('Select Faction'),
                        isExpanded: true,
                        items: [
                          const DropdownMenuItem<Faction?>(
                            value: null,
                            child: Text('All Factions'),
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
                          const Icon(Icons.error_outline,
                              size: 48, color: Colors.red),
                          const SizedBox(height: 16),
                          Text('Error loading factions: $error'),
                        ],
                      ),
                    ),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'Total Points: $totalPoints',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredArmy.isEmpty
                ? const Center(
                    child: Text('Add units to your army using the + button'),
                  )
                : ListView.builder(
                    itemCount: filteredArmy.length,
                    itemBuilder: (context, index) {
                      final unit = filteredArmy[index];
                      return ListTile(
                        title: Text(unit.datasheet.name),
                        subtitle: Text(
                            '${unit.quantity}x - ${unit.points} points${unit.notes != null ? ' - ${unit.notes}' : ''}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Total: ${unit.points * unit.quantity} points',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _showEditQuantityDialog(context, ref, unit),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                ref
                                    .read(armyListProvider.notifier)
                                    .removeUnit(unit.id);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
