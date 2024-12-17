import 'package:freezed_annotation/freezed_annotation.dart';

part 'faction.freezed.dart';
part 'faction.g.dart';

@freezed
class Faction with _$Faction {
  const factory Faction({
    required String id,
    required String name,
    required String link,
  }) = _Faction;

  factory Faction.fromJson(Map<String, dynamic> json) => _$FactionFromJson(json);
}
