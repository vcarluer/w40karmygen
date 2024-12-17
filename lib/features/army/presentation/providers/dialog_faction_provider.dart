import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/faction.dart';

part 'dialog_faction_provider.g.dart';

@riverpod
class DialogSelectedFaction extends _$DialogSelectedFaction {
  @override
  Faction? build() => null;

  void select(Faction? faction) {
    state = faction;
  }

  void clear() {
    state = null;
  }
}
