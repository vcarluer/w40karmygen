// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'optimized_army.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OptimizedArmyImpl _$$OptimizedArmyImplFromJson(Map<String, dynamic> json) =>
    _$OptimizedArmyImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      pointsLimit: (json['pointsLimit'] as num).toInt(),
      armyList: json['armyList'] as String,
      strategy: json['strategy'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      faction: json['faction'] == null
          ? null
          : Faction.fromJson(json['faction'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OptimizedArmyImplToJson(_$OptimizedArmyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'pointsLimit': instance.pointsLimit,
      'armyList': instance.armyList,
      'strategy': instance.strategy,
      'createdAt': instance.createdAt.toIso8601String(),
      'faction': instance.faction,
    };
