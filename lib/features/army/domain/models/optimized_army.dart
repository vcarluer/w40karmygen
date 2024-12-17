import 'package:freezed_annotation/freezed_annotation.dart';
import 'faction.dart';

part 'optimized_army.freezed.dart';
part 'optimized_army.g.dart';

@freezed
class OptimizedArmy with _$OptimizedArmy {
  const factory OptimizedArmy({
    required String id,
    required String name,
    required String description,
    required int pointsLimit,
    required String armyList,
    required String strategy,
    required DateTime createdAt,
    Faction? faction,
  }) = _OptimizedArmy;

  factory OptimizedArmy.fromJson(Map<String, dynamic> json) =>
      _$OptimizedArmyFromJson(json);
}
