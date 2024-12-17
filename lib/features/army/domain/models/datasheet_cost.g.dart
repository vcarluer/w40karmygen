// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datasheet_cost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DatasheetCostImpl _$$DatasheetCostImplFromJson(Map<String, dynamic> json) =>
    _$DatasheetCostImpl(
      datasheetId: json['datasheetId'] as String,
      line: (json['line'] as num).toInt(),
      description: json['description'] as String,
      cost: (json['cost'] as num).toInt(),
    );

Map<String, dynamic> _$$DatasheetCostImplToJson(_$DatasheetCostImpl instance) =>
    <String, dynamic>{
      'datasheetId': instance.datasheetId,
      'line': instance.line,
      'description': instance.description,
      'cost': instance.cost,
    };
