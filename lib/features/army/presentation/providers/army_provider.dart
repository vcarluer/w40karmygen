import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/unit.dart';
import 'repository_providers.dart';

part 'army_provider.g.dart';

@Riverpod(keepAlive: true)
class ArmyList extends AsyncNotifier<List<Unit>> {
  @override
  Future<List<Unit>> build() async {
    final repository = await ref.watch(armyListRepositoryProvider.future);
    return repository.loadArmyList();
  }

  Future<void> addUnit(Unit unit) async {
    final repository = await ref.read(armyListRepositoryProvider.future);
    
    final currentList = state.valueOrNull ?? [];
    final newList = [...currentList, unit];
    await repository.saveArmyList(newList);
    state = AsyncData(newList);
  }

  Future<void> removeUnit(String unitId) async {
    final repository = await ref.read(armyListRepositoryProvider.future);
    
    final currentList = state.valueOrNull ?? [];
    final newList = currentList.where((unit) => unit.id != unitId).toList();
    await repository.saveArmyList(newList);
    state = AsyncData(newList);
  }

  Future<void> updateUnitQuantity(String unitId, int quantity) async {
    final repository = await ref.read(armyListRepositoryProvider.future);
    
    final currentList = state.valueOrNull ?? [];
    final newList = currentList.map((unit) {
      if (unit.id == unitId) {
        return Unit(
          id: unit.id,
          datasheet: unit.datasheet,
          quantity: quantity,
          points: unit.points,
          notes: unit.notes,
        );
      }
      return unit;
    }).toList();
    await repository.saveArmyList(newList);
    state = AsyncData(newList);
  }

  List<Unit> getFilteredUnits(String? factionId) {
    final currentList = state.valueOrNull ?? [];
    if (factionId == null) return currentList;
    return currentList.where((unit) => unit.datasheet.factionId == factionId).toList();
  }

  int getTotalPoints() {
    final currentList = state.valueOrNull ?? [];
    return currentList.fold<int>(
      0,
      (sum, unit) => sum + ((unit.points) * (unit.quantity)),
    );
  }
}
