// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faction_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$factionListHash() => r'8b86ab58872ec12a38b945bb79a4d1612f32d544';

/// See also [FactionList].
@ProviderFor(FactionList)
final factionListProvider =
    AutoDisposeAsyncNotifierProvider<FactionList, List<Faction>>.internal(
  FactionList.new,
  name: r'factionListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$factionListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FactionList = AutoDisposeAsyncNotifier<List<Faction>>;
String _$selectedFactionHash() => r'd6872aa721b3f2d96597dae206dd9708bd469fb0';

/// See also [SelectedFaction].
@ProviderFor(SelectedFaction)
final selectedFactionProvider =
    AutoDisposeNotifierProvider<SelectedFaction, Faction?>.internal(
  SelectedFaction.new,
  name: r'selectedFactionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedFactionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedFaction = AutoDisposeNotifier<Faction?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
