import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/datasheet.dart';
import 'dialog_faction_provider.dart';
import 'repository_providers.dart';

part 'datasheet_provider.g.dart';

@riverpod
class DatasheetList extends _$DatasheetList {
  @override
  Future<List<Datasheet>> build() async {
    try {
      final repository = ref.watch(datasheetRepositoryProvider);
      final datasheets = await repository.loadDatasheets();
      return datasheets;
    } catch (e, stack) {
      print('Error loading datasheets: $e\n$stack');
      throw Exception('Failed to load datasheets: $e');
    }
  }
}

@riverpod
class FilteredDatasheetList extends _$FilteredDatasheetList {
  @override
  List<Datasheet> build() {
    final datasheets = ref.watch(datasheetListProvider);
    final selectedFaction = ref.watch(dialogSelectedFactionProvider);

    return datasheets.when(
      data: (list) {
        if (selectedFaction == null) {
          return list;
        }
        return list.where((datasheet) => datasheet.factionId == selectedFaction.id).toList();
      },
      loading: () => [],
      error: (_, __) => [],
    );
  }
}
