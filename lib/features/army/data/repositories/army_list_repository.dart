import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/unit.dart';

class ArmyListRepository {
  static const String _key = 'army_list';
  final SharedPreferences _prefs;

  ArmyListRepository(this._prefs);

  Future<void> saveArmyList(List<Unit> units) async {
    final jsonList = units.map((unit) => unit.toJson()).toList();
    await _prefs.setString(_key, jsonEncode(jsonList));
  }

  Future<List<Unit>> loadArmyList() async {
    final jsonString = _prefs.getString(_key);
    if (jsonString == null) return [];

    try {
      final jsonList = jsonDecode(jsonString) as List;
      return jsonList.map((json) => Unit.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      // If there's an error parsing the data, return an empty list
      return [];
    }
  }

  Future<void> clearArmyList() async {
    await _prefs.remove(_key);
  }
}
