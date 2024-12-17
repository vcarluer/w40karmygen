// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datasheet_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$datasheetListHash() => r'74d5fbef4447e01ed2b0d6bcf1540a7132fc9651';

/// See also [DatasheetList].
@ProviderFor(DatasheetList)
final datasheetListProvider =
    AutoDisposeAsyncNotifierProvider<DatasheetList, List<Datasheet>>.internal(
  DatasheetList.new,
  name: r'datasheetListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$datasheetListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DatasheetList = AutoDisposeAsyncNotifier<List<Datasheet>>;
String _$filteredDatasheetListHash() =>
    r'6b92e7c2dbff77466e1abdc1f09378a541158e0d';

/// See also [FilteredDatasheetList].
@ProviderFor(FilteredDatasheetList)
final filteredDatasheetListProvider = AutoDisposeNotifierProvider<
    FilteredDatasheetList, List<Datasheet>>.internal(
  FilteredDatasheetList.new,
  name: r'filteredDatasheetListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredDatasheetListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FilteredDatasheetList = AutoDisposeNotifier<List<Datasheet>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
