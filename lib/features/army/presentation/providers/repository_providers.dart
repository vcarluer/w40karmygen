import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/file_repository.dart';
import '../../data/repositories/faction_repository.dart';
import '../../data/repositories/datasheet_repository.dart';

part 'repository_providers.g.dart';

@riverpod
FileRepository fileRepository(FileRepositoryRef ref) {
  // Use the correct asset path format for Flutter
  return FileRepository(dataPath: 'assets/data');
}

@riverpod
FactionRepository factionRepository(FactionRepositoryRef ref) {
  final fileRepo = ref.watch(fileRepositoryProvider);
  return FactionRepository(fileRepository: fileRepo);
}

@riverpod
DatasheetRepository datasheetRepository(DatasheetRepositoryRef ref) {
  final fileRepo = ref.watch(fileRepositoryProvider);
  return DatasheetRepository(fileRepository: fileRepo);
}
