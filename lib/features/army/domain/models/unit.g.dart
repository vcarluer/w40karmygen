// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UnitImpl _$$UnitImplFromJson(Map<String, dynamic> json) => _$UnitImpl(
      id: json['id'] as String,
      datasheet: Datasheet.fromJson(json['datasheet'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      points: (json['points'] as num?)?.toInt() ?? 0,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$UnitImplToJson(_$UnitImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'datasheet': instance.datasheet,
      'quantity': instance.quantity,
      'points': instance.points,
      'notes': instance.notes,
    };
