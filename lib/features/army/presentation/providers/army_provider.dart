import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/unit.dart';

part 'army_provider.g.dart';

@riverpod
class ArmyList extends _$ArmyList {
  @override
  AsyncValue<List<Unit>> build() {
    return const AsyncValue.data([]);
  }

  Future<void> addUnit(Unit unit) async {
    state = const AsyncValue.loading();
    try {
      final currentUnits = state.value ?? [];
      state = AsyncValue.data([...currentUnits, unit]);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> removeUnit(String unitId) async {
    state = const AsyncValue.loading();
    try {
      final currentUnits = state.value ?? [];
      state = AsyncValue.data(
        currentUnits.where((unit) => unit.id != unitId).toList(),
      );
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateUnitQuantity(String unitId, int quantity) async {
    state = const AsyncValue.loading();
    try {
      final currentUnits = state.value ?? [];
      state = AsyncValue.data(
        currentUnits.map((unit) {
          if (unit.id == unitId) {
            return unit.copyWith(quantity: quantity);
          }
          return unit;
        }).toList(),
      );
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
