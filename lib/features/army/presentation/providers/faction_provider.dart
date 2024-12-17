import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/faction.dart';

part 'faction_provider.g.dart';

@riverpod
class FactionList extends _$FactionList {
  @override
  Future<List<Faction>> build() async {
    return _loadFactions();
  }

  Future<List<Faction>> _loadFactions() async {
    try {
      final String content = await rootBundle.loadString('assets/data/factions.csv');
      final lines = content.split('\n');
      
      // Skip header line and empty lines
      return lines
          .where((line) => line.trim().isNotEmpty)
          .skip(1)
          .map((line) {
        final parts = line.split('|');
        if (parts.length < 3) {
          throw FormatException('Invalid faction data format: $line');
        }
        return Faction(
          id: parts[0].trim(),
          name: parts[1].trim(),
          link: parts[2].trim(),
        );
      }).toList();
    } catch (e) {
      print('Error loading factions: $e');
      rethrow;
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadFactions());
  }
}

@riverpod
class SelectedFaction extends _$SelectedFaction {
  @override
  Faction? build() => null;

  void select(Faction faction) {
    state = faction;
  }

  void clear() {
    state = null;
  }
}
