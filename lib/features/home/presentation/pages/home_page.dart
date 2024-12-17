import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../army/domain/models/faction.dart';
import '../../../army/presentation/providers/faction_provider.dart';
import '../../../army/presentation/widgets/add_datasheet_dialog.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final factions = ref.watch(factionListProvider);
    final selectedFaction = ref.watch(selectedFactionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('W40K Army Builder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await showDialog<bool>(
                context: context,
                builder: (context) => const AddDatasheetDialog(),
              );
              if (result == true) {
                // Handle datasheet added
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: factions.when(
              data: (factionList) => DropdownButton<Faction>(
                value: selectedFaction,
                hint: const Text('Select Faction'),
                isExpanded: true,
                items: [
                  const DropdownMenuItem<Faction>(
                    value: null,
                    child: Text('All Factions'),
                  ),
                  ...factionList.map((faction) => DropdownMenuItem(
                    value: faction,
                    child: Text(faction.name),
                  )),
                ],
                onChanged: (faction) {
                  ref.read(selectedFactionProvider.notifier).state = faction;
                },
              ),
              error: (error, _) => Text('Error: $error'),
              loading: () => const CircularProgressIndicator(),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text('Army list will be displayed here'),
            ),
          ),
        ],
      ),
    );
  }
}
