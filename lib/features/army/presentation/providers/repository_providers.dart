import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/repositories/collection_repository.dart';
import '../../data/repositories/datasheet_cost_repository.dart';
import '../../data/repositories/datasheet_repository.dart';
import '../../data/repositories/faction_repository.dart';
import '../../data/repositories/file_repository.dart';

part 'repository_providers.g.dart';

@riverpod
FileRepository fileRepository(FileRepositoryRef ref) {
  return FileRepository(dataPath: 'assets/data');
}

@riverpod
FactionRepository factionRepository(FactionRepositoryRef ref) {
  return FactionRepository(fileRepository: ref.watch(fileRepositoryProvider));
}

@riverpod
DatasheetRepository datasheetRepository(DatasheetRepositoryRef ref) {
  return DatasheetRepository(fileRepository: ref.watch(fileRepositoryProvider));
}

@riverpod
DatasheetCostRepository datasheetCostRepository(DatasheetCostRepositoryRef ref) {
  return DatasheetCostRepository(fileRepository: ref.watch(fileRepositoryProvider));
}

@riverpod
Future<CollectionRepository> collectionRepository(CollectionRepositoryRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  return CollectionRepository(prefs);
}
