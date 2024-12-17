// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datasheet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DatasheetImpl _$$DatasheetImplFromJson(Map<String, dynamic> json) =>
    _$DatasheetImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      factionId: json['factionId'] as String,
      sourceId: json['sourceId'] as String,
      legend: json['legend'] as String,
      role: json['role'] as String,
      loadout: json['loadout'] as String,
      transport: json['transport'] as String?,
      virtual: json['virtual'] as bool? ?? false,
      leaderHead: json['leaderHead'] as String?,
      leaderFooter: json['leaderFooter'] as String?,
      damagedW: json['damagedW'] as String?,
      damagedDescription: json['damagedDescription'] as String?,
      link: json['link'] as String,
      faction: json['faction'] == null
          ? null
          : Faction.fromJson(json['faction'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DatasheetImplToJson(_$DatasheetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'factionId': instance.factionId,
      'sourceId': instance.sourceId,
      'legend': instance.legend,
      'role': instance.role,
      'loadout': instance.loadout,
      'transport': instance.transport,
      'virtual': instance.virtual,
      'leaderHead': instance.leaderHead,
      'leaderFooter': instance.leaderFooter,
      'damagedW': instance.damagedW,
      'damagedDescription': instance.damagedDescription,
      'link': instance.link,
      'faction': instance.faction,
    };
