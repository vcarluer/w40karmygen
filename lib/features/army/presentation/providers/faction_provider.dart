import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/faction.dart';
import 'repository_providers.dart';

part 'faction_provider.g.dart';

@riverpod
class FactionList extends _$FactionList {
  @override
  Future<List<Faction>> build() async {
    try {
      final repository = ref.watch(factionRepositoryProvider);
      final factions = await repository.loadFactions();
      return factions;
    } catch (e, stack) {
      // Log the error for debugging
      print('Error loading factions: $e\n$stack');
      throw Exception('Failed to load factions: $e');
    }
  }
}

@riverpod
class SelectedFaction extends _$SelectedFaction {
  @override
  Faction? build() => null;

  void select(Faction? faction) {
    state = faction;
  }

  void clear() {
    state = null;
  }
}
