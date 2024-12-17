import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/faction_repository.dart';
import '../../data/repositories/file_repository.dart';
import '../../domain/models/faction.dart';

final factionRepositoryProvider = Provider((ref) {
  final fileRepo = FileRepository(dataPath: '/data');
  return FactionRepository(fileRepository: fileRepo);
});

final factionListProvider = FutureProvider<List<Faction>>((ref) async {
  final repository = ref.watch(factionRepositoryProvider);
  return repository.loadFactions();
});

final selectedFactionProvider = StateProvider<Faction?>((ref) => null);
