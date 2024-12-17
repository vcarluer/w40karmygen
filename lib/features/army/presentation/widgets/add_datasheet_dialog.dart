import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/datasheet.dart';
import '../../domain/models/faction.dart';
import '../providers/datasheet_provider.dart';
import '../providers/faction_provider.dart';

class AddDatasheetDialog extends ConsumerStatefulWidget {
  const AddDatasheetDialog({super.key});

  @override
  ConsumerState<AddDatasheetDialog> createState() => _AddDatasheetDialogState();
}

class _AddDatasheetDialogState extends ConsumerState<AddDatasheetDialog> {
  String _searchQuery = '';
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final datasheets = ref.watch(datasheetListProvider);
    final selectedFaction = ref.watch(selectedFactionProvider);

    return Dialog(
      child: Material(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Add Datasheet',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: datasheets.when(
                    data: (list) {
                      final filteredList = list.where((datasheet) {
                        final matchesSearch = datasheet.name
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase());
                        final matchesFaction = selectedFaction == null ||
                            datasheet.factionId == selectedFaction.id;
                        return matchesSearch && matchesFaction;
                      }).toList();

                      return filteredList.isEmpty
                          ? const Center(child: Text('No datasheets found'))
                          : ListView.builder(
                              itemCount: filteredList.length,
                              itemBuilder: (context, index) {
                                final datasheet = filteredList[index];
                                return Card(
                                  child: ListTile(
                                    title: Text(datasheet.name),
                                    subtitle: Text(
                                        '${datasheet.role} - ${datasheet.legend}'),
                                    onTap: () =>
                                        Navigator.of(context).pop(datasheet),
                                  ),
                                );
                              },
                            );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, _) => Center(
                      child: Text('Error loading datasheets: $error'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
