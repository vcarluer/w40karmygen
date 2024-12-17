import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/datasheet.dart';

part 'army_provider.g.dart';

@riverpod
class ArmyList extends _$ArmyList {
  @override
  List<Datasheet> build() {
    return [];
  }

  void addDatasheet(Datasheet datasheet) {
    state = [...state, datasheet];
  }

  void removeDatasheet(String datasheetId) {
    state = state.where((datasheet) => datasheet.id != datasheetId).toList();
  }

  List<Datasheet> getFilteredDatasheets(String? factionId) {
    if (factionId == null) return state;
    return state.where((datasheet) => datasheet.factionId == factionId).toList();
  }

  void filterByFaction(String? factionId) {
    if (factionId == null) return;
    state = state.where((datasheet) => datasheet.factionId == factionId).toList();
  }
}
