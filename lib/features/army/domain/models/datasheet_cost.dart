import 'package:freezed_annotation/freezed_annotation.dart';

part 'datasheet_cost.freezed.dart';
part 'datasheet_cost.g.dart';

@freezed
class DatasheetCost with _$DatasheetCost {
  const factory DatasheetCost({
    required String datasheetId,
    required int line,
    required String description,
    required int cost,
  }) = _DatasheetCost;

  factory DatasheetCost.fromJson(Map<String, dynamic> json) =>
      _$DatasheetCostFromJson(json);
}
