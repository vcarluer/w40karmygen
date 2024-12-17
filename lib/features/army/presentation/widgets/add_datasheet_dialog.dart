import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;
  String? _error;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    _loadDatasheets();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadDatasheets() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      debugPrint('Loading datasheets from assets...');
      final String csvData = await rootBundle.loadString('assets/data/datasheets.csv');
      debugPrint('CSV data loaded, length: ${csvData.length}');
      
      final lines = csvData.split('\n');
      debugPrint('Number of lines: ${lines.length}');
      
      if (lines.isEmpty) {
        throw Exception('CSV file is empty');
      }

      // Print header for debugging
      debugPrint('Header: ${lines[0]}');
      
      // Skip header
      lines.removeAt(0);
      
      final parsedDatasheets = lines.where((line) => line.trim().isNotEmpty).map((line) {
        try {
          final parts = line.split('|');
          if (parts.length < 14) {
            debugPrint('Invalid line format: $line');
            throw Exception('Invalid line format');
          }
          
          return Datasheet(
            id: parts[0],
            name: parts[1],
            factionId: parts[2],
            sourceId: parts[3],
            legend: parts[4],
            role: parts[5],
            loadout: parts[6],
            transport: parts[7] == 'null' ? null : parts[7],
            virtual: parts[8] == 'true',
            leaderHead: parts[9] == 'null' ? null : parts[9],
            leaderFooter: parts[10] == 'null' ? null : parts[10],
            damagedW: parts[11] == 'null' ? null : parts[11],
            damagedDescription: parts[12] == 'null' ? null : parts[12],
            link: parts[13],
          );
        } catch (e) {
          debugPrint('Error parsing line: $e');
          return null;
        }
      }).whereType<Datasheet>().toList();

      setState(() {
        _datasheets = parsedDatasheets;
        _filteredDatasheets = parsedDatasheets;
        _isLoading = false;
      });

      debugPrint('Loaded ${_datasheets.length} datasheets');
    } catch (e) {
      debugPrint('Error loading datasheets: $e');
      setState(() {
        _isLoading = false;
        _error = 'Error loading datasheets: $e';
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
                      _filterDatasheets();
                    });
                  },
                ),
                const SizedBox(height: 16),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      _error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _datasheets.isEmpty
                          ? const Center(child: Text('No datasheets available'))
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
      ),
    );
  }
}
