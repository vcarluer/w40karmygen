import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/generated_army.dart';
import '../../domain/models/faction.dart';

part 'generated_army_provider.g.dart';

const String _storageKey = 'generated_armies';

@Riverpod(keepAlive: true)
class GeneratedArmies extends _$GeneratedArmies {
  final _uuid = const Uuid();

  @override
  List<GeneratedArmy> build() {
    _loadArmies();
    return [];
  }

  Future<void> _loadArmies() async {
    final prefs = await SharedPreferences.getInstance();
    final armiesJson = prefs.getStringList(_storageKey);
    
    if (armiesJson != null) {
      final armies = armiesJson
          .map((json) => GeneratedArmy.fromJson(jsonDecode(json)))
          .toList();
      state = armies;
    }
  }

  Future<void> _saveArmies(List<GeneratedArmy> armies) async {
    final prefs = await SharedPreferences.getInstance();
    final armiesJson = armies
        .map((army) => jsonEncode(army.toJson()))
        .toList();
    await prefs.setStringList(_storageKey, armiesJson);
  }

  Future<void> addGeneratedArmy({
    required String name,
    required String description,
    required int pointsLimit,
    required String armyList,
    required String strategy,
    required String requiredPurchases,
    required double totalPurchaseCost,
    Faction? faction,
  }) async {
    final generatedArmy = GeneratedArmy(
      id: _uuid.v4(),
      name: name,
      description: description,
      pointsLimit: pointsLimit,
      armyList: armyList,
      strategy: strategy,
      createdAt: DateTime.now(),
      faction: faction,
      requiredPurchases: requiredPurchases,
      totalPurchaseCost: totalPurchaseCost,
    );

    final newState = [...state, generatedArmy];
    state = newState;
    await _saveArmies(newState);
  }

  Future<void> removeGeneratedArmy(String id) async {
    final newState = state.where((army) => army.id != id).toList();
    state = newState;
    await _saveArmies(newState);
  }
}
