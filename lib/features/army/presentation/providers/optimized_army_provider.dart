import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/optimized_army.dart';
import '../../domain/models/faction.dart';

part 'optimized_army_provider.g.dart';

@riverpod
class OptimizedArmies extends _$OptimizedArmies {
  final _uuid = const Uuid();

  @override
  List<OptimizedArmy> build() {
    return [];
  }

  void addOptimizedArmy({
    required String name,
    required String description,
    required int pointsLimit,
    required String armyList,
    required String strategy,
    Faction? faction,
  }) {
    final optimizedArmy = OptimizedArmy(
      id: _uuid.v4(),
      name: name,
      description: description,
      pointsLimit: pointsLimit,
      armyList: armyList,
      strategy: strategy,
      createdAt: DateTime.now(),
      faction: faction,
    );

    state = [...state, optimizedArmy];
  }

  void removeOptimizedArmy(String id) {
    state = state.where((army) => army.id != id).toList();
  }
}
