import 'package:freezed_annotation/freezed_annotation.dart';
import 'faction.dart';

part 'datasheet.freezed.dart';
part 'datasheet.g.dart';

@freezed
class Datasheet with _$Datasheet {
  const factory Datasheet({
    required String id,
    required String name,
    required String factionId,
    required String sourceId,
    required String legend,
    required String role,
    required String loadout,
    String? transport,
    @Default(false) bool virtual,
    String? leaderHead,
    String? leaderFooter,
    String? damagedW,
    String? damagedDescription,
    required String link,
    Faction? faction,
  }) = _Datasheet;

  factory Datasheet.fromJson(Map<String, dynamic> json) => _$DatasheetFromJson(json);
}
