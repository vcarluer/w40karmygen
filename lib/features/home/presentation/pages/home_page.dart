import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:w40k_army_opti/features/army/domain/models/datasheet.dart';
import 'package:w40k_army_opti/features/army/presentation/providers/army_provider.dart';
import 'package:w40k_army_opti/features/army/presentation/providers/faction_provider.dart';
import 'package:w40k_army_opti/features/army/presentation/widgets/add_datasheet_dialog.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final armyList = ref.watch(armyListProvider);
    final factionsAsync = ref.watch(factionListProvider);
    final selectedFaction = ref.watch(selectedFactionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('W40K Army Optimizer'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: factionsAsync.when(
              data: (factions) => DropdownButtonFormField(
                value: selectedFaction,
                decoration: const InputDecoration(
                  labelText: 'Select Faction',
                  border: OutlineInputBorder(),
                ),
                items: [
                  const DropdownMenuItem(
                    value: null,
                    child: Text('All Factions'),
                  ),
                  ...factions.map((faction) => DropdownMenuItem(
                    value: faction,
                    child: Text(faction.name),
                  )),
                ],
                onChanged: (value) {
                  if (value != null) {
                    ref.read(selectedFactionProvider.notifier).select(value);
                  } else {
                    ref.read(selectedFactionProvider.notifier).clear();
                  }
                },
              ),
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: armyList.length,
              itemBuilder: (context, index) {
                final datasheet = armyList[index];
                return ListTile(
                  title: Text(datasheet.name),
                  subtitle: Text('${datasheet.role} - ${datasheet.legend}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      if (datasheet.id != null) {
                        ref.read(armyListProvider.notifier).removeDatasheet(datasheet.id);
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Datasheet? newDatasheet = await showDialog<Datasheet>(
            context: context,
            builder: (context) => const AddDatasheetDialog(),
          );
          
          if (newDatasheet != null) {
            ref.read(armyListProvider.notifier).addDatasheet(newDatasheet);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
