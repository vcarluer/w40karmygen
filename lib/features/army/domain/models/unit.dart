import 'package:freezed_annotation/freezed_annotation.dart';
import 'datasheet.dart';

part 'unit.freezed.dart';
part 'unit.g.dart';

@freezed
class Unit with _$Unit {
  const factory Unit({
    required String id,
    required Datasheet datasheet,
    @Default(1) int quantity,
    @Default(0) int points,
    String? notes,
  }) = _Unit;

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);
}
