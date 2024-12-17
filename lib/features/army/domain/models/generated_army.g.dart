// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generated_army.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GeneratedArmyImpl _$$GeneratedArmyImplFromJson(Map<String, dynamic> json) =>
    _$GeneratedArmyImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      pointsLimit: (json['pointsLimit'] as num).toInt(),
      armyList: json['armyList'] as String,
      strategy: json['strategy'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      requiredPurchases: json['requiredPurchases'] as String,
      totalPurchaseCost: (json['totalPurchaseCost'] as num).toDouble(),
      faction: json['faction'] == null
          ? null
          : Faction.fromJson(json['faction'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GeneratedArmyImplToJson(_$GeneratedArmyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'pointsLimit': instance.pointsLimit,
      'armyList': instance.armyList,
      'strategy': instance.strategy,
      'createdAt': instance.createdAt.toIso8601String(),
      'requiredPurchases': instance.requiredPurchases,
      'totalPurchaseCost': instance.totalPurchaseCost,
      'faction': instance.faction,
    };
