import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/unit.dart';

part 'army_provider.g.dart';

@riverpod
class ArmyList extends _$ArmyList {
  @override
  List<Unit> build() {
    return [];
  }

  void addUnit(Unit unit) {
    state = [...state, unit];
  }

  void removeUnit(String unitId) {
    state = state.where((unit) => unit.id != unitId).toList();
  }

  List<Unit> getFilteredUnits(String? factionId) {
    if (factionId == null) return state;
    return state
        .where((unit) => unit.datasheet.factionId == factionId)
        .toList();
  }

  int getTotalPoints() {
    return state.fold<int>(
      0,
      (sum, unit) => sum + ((unit.points) * (unit.quantity)),
    );
  }
}
