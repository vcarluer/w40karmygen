import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/datasheet_repository.dart';
import '../../data/repositories/file_repository.dart';
import '../../domain/models/datasheet.dart';
import 'faction_provider.dart';

final datasheetRepositoryProvider = Provider((ref) {
  final fileRepo = FileRepository(dataPath: '/data');
  return DatasheetRepository(fileRepository: fileRepo);
});

final datasheetListProvider = FutureProvider<List<Datasheet>>((ref) async {
  final repository = ref.watch(datasheetRepositoryProvider);
  return repository.loadDatasheets();
});

final filteredDatasheetListProvider = Provider<List<Datasheet>>((ref) {
  final datasheets = ref.watch(datasheetListProvider);
  final selectedFaction = ref.watch(selectedFactionProvider);
  
  return datasheets.when(
    data: (list) => list.where((datasheet) => 
      selectedFaction == null || datasheet.factionId == selectedFaction?.id
    ).toList(),
    loading: () => [],
    error: (_, __) => [],
  );
});
