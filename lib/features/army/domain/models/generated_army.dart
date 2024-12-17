import 'package:freezed_annotation/freezed_annotation.dart';
import 'faction.dart';

part 'generated_army.freezed.dart';
part 'generated_army.g.dart';

@freezed
class GeneratedArmy with _$GeneratedArmy {
  const factory GeneratedArmy({
    required String id,
    required String name,
    required String description,
    required int pointsLimit,
    required String armyList,
    required String strategy,
    required DateTime createdAt,
    required String requiredPurchases,
    required double totalPurchaseCost,
    Faction? faction,
  }) = _GeneratedArmy;

  factory GeneratedArmy.fromJson(Map<String, dynamic> json) =>
      _$GeneratedArmyFromJson(json);
}
