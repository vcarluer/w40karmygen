import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../domain/models/datasheet.dart';
import '../../domain/models/faction.dart';
import '../providers/faction_provider.dart';

class AddDatasheetDialog extends ConsumerStatefulWidget {
  const AddDatasheetDialog({super.key});

  @override
  ConsumerState<AddDatasheetDialog> createState() => _AddDatasheetDialogState();
}

class _AddDatasheetDialogState extends ConsumerState<AddDatasheetDialog> {
  List<Datasheet> _datasheets = [];
  List<Datasheet> _filteredDatasheets = [];
  bool _isLoading = true;
  String _searchQuery = '';
  Faction? _selectedFaction;

  @override
  void initState() {
    super.initState();
    _loadDatasheets();
  }

  Future<void> _loadDatasheets() async {
    try {
      final response = await http.get(Uri.parse('https://wahapedia.ru/wh40k10ed/Datasheets.csv'));
      if (response.statusCode == 200) {
        final lines = response.body.split('\n');
        // Skip header
        lines.removeAt(0);
        
        setState(() {
          _datasheets = lines.where((line) => line.trim().isNotEmpty).map((line) {
            final parts = line.split('|');
            return Datasheet(
              id: parts[0],
              name: parts[1],
              factionId: parts[2],
              sourceId: parts[3],
              legend: parts[4],
              role: parts[5],
              loadout: parts[6],
              transport: parts[7].isEmpty ? null : parts[7],
              virtual: parts[8] == 'true',
              leaderHead: parts[9].isEmpty ? null : parts[9],
              leaderFooter: parts[10].isEmpty ? null : parts[10],
              damagedW: parts[11].isEmpty ? null : parts[11],
              damagedDescription: parts[12].isEmpty ? null : parts[12],
              link: parts[13],
            );
          }).toList();
          _filteredDatasheets = _datasheets;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading datasheets: $e')),
        );
      }
    }
  }

  void _filterDatasheets() {
    setState(() {
      _filteredDatasheets = _datasheets.where((datasheet) {
        final matchesSearch = datasheet.name.toLowerCase().contains(_searchQuery.toLowerCase());
        final matchesFaction = _selectedFaction == null || datasheet.factionId == _selectedFaction?.id;
        return matchesSearch && matchesFaction;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final factions = ref.watch(factionListProvider);

    return Dialog(
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
              factions.when(
                data: (factionList) => DropdownButtonFormField<Faction>(
                  value: _selectedFaction,
                  decoration: const InputDecoration(
                    labelText: 'Filter by Faction',
                    border: OutlineInputBorder(),
                  ),
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
                    setState(() {
                      _selectedFaction = faction;
                      _filterDatasheets();
                    });
                  },
                ),
                error: (error, _) => Text('Error: $error'),
                loading: () => const CircularProgressIndicator(),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                    _filterDatasheets();
                  });
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: _filteredDatasheets.length,
                        itemBuilder: (context, index) {
                          final datasheet = _filteredDatasheets[index];
                          return Card(
                            child: ListTile(
                              title: Text(datasheet.name),
                              subtitle: Text('${datasheet.role} - ${datasheet.legend}'),
                              onTap: () => Navigator.of(context).pop(datasheet),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
