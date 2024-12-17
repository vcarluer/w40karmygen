import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/optimized_army.dart';
import '../../domain/models/faction.dart';

part 'optimized_army_provider.g.dart';

const String _storageKey = 'optimized_armies';

@riverpod
class OptimizedArmies extends _$OptimizedArmies {
  final _uuid = const Uuid();

  @override
  List<OptimizedArmy> build() {
    _loadArmies();
    return [];
  }

  Future<void> _loadArmies() async {
    final prefs = await SharedPreferences.getInstance();
    final armiesJson = prefs.getStringList(_storageKey);
    
    if (armiesJson != null) {
      final armies = armiesJson
          .map((json) => OptimizedArmy.fromJson(jsonDecode(json)))
          .toList();
      state = armies;
    }
  }

  Future<void> _saveArmies(List<OptimizedArmy> armies) async {
    final prefs = await SharedPreferences.getInstance();
    final armiesJson = armies
        .map((army) => jsonEncode(army.toJson()))
        .toList();
    await prefs.setStringList(_storageKey, armiesJson);
  }

  Future<void> addOptimizedArmy({
    required String name,
    required String description,
    required int pointsLimit,
    required String armyList,
    required String strategy,
    Faction? faction,
  }) async {
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

    final newState = [...state, optimizedArmy];
    state = newState;
    await _saveArmies(newState);
  }

  Future<void> removeOptimizedArmy(String id) async {
    final newState = state.where((army) => army.id != id).toList();
    state = newState;
    await _saveArmies(newState);
  }
}
