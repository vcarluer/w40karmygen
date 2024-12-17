// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generated_army.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GeneratedArmy _$GeneratedArmyFromJson(Map<String, dynamic> json) {
  return _GeneratedArmy.fromJson(json);
}

/// @nodoc
mixin _$GeneratedArmy {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get pointsLimit => throw _privateConstructorUsedError;
  String get armyList => throw _privateConstructorUsedError;
  String get strategy => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get requiredPurchases => throw _privateConstructorUsedError;
  double get totalPurchaseCost => throw _privateConstructorUsedError;
  Faction? get faction => throw _privateConstructorUsedError;

  /// Serializes this GeneratedArmy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GeneratedArmy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GeneratedArmyCopyWith<GeneratedArmy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeneratedArmyCopyWith<$Res> {
  factory $GeneratedArmyCopyWith(
          GeneratedArmy value, $Res Function(GeneratedArmy) then) =
      _$GeneratedArmyCopyWithImpl<$Res, GeneratedArmy>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      int pointsLimit,
      String armyList,
      String strategy,
      DateTime createdAt,
      String requiredPurchases,
      double totalPurchaseCost,
      Faction? faction});

  $FactionCopyWith<$Res>? get faction;
}

/// @nodoc
class _$GeneratedArmyCopyWithImpl<$Res, $Val extends GeneratedArmy>
    implements $GeneratedArmyCopyWith<$Res> {
  _$GeneratedArmyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GeneratedArmy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? pointsLimit = null,
    Object? armyList = null,
    Object? strategy = null,
    Object? createdAt = null,
    Object? requiredPurchases = null,
    Object? totalPurchaseCost = null,
    Object? faction = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      pointsLimit: null == pointsLimit
          ? _value.pointsLimit
          : pointsLimit // ignore: cast_nullable_to_non_nullable
              as int,
      armyList: null == armyList
          ? _value.armyList
          : armyList // ignore: cast_nullable_to_non_nullable
              as String,
      strategy: null == strategy
          ? _value.strategy
          : strategy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      requiredPurchases: null == requiredPurchases
          ? _value.requiredPurchases
          : requiredPurchases // ignore: cast_nullable_to_non_nullable
              as String,
      totalPurchaseCost: null == totalPurchaseCost
          ? _value.totalPurchaseCost
          : totalPurchaseCost // ignore: cast_nullable_to_non_nullable
              as double,
      faction: freezed == faction
          ? _value.faction
          : faction // ignore: cast_nullable_to_non_nullable
              as Faction?,
    ) as $Val);
  }

  /// Create a copy of GeneratedArmy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FactionCopyWith<$Res>? get faction {
    if (_value.faction == null) {
      return null;
    }

    return $FactionCopyWith<$Res>(_value.faction!, (value) {
      return _then(_value.copyWith(faction: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GeneratedArmyImplCopyWith<$Res>
    implements $GeneratedArmyCopyWith<$Res> {
  factory _$$GeneratedArmyImplCopyWith(
          _$GeneratedArmyImpl value, $Res Function(_$GeneratedArmyImpl) then) =
      __$$GeneratedArmyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      int pointsLimit,
      String armyList,
      String strategy,
      DateTime createdAt,
      String requiredPurchases,
      double totalPurchaseCost,
      Faction? faction});

  @override
  $FactionCopyWith<$Res>? get faction;
}

/// @nodoc
class __$$GeneratedArmyImplCopyWithImpl<$Res>
    extends _$GeneratedArmyCopyWithImpl<$Res, _$GeneratedArmyImpl>
    implements _$$GeneratedArmyImplCopyWith<$Res> {
  __$$GeneratedArmyImplCopyWithImpl(
      _$GeneratedArmyImpl _value, $Res Function(_$GeneratedArmyImpl) _then)
      : super(_value, _then);

  /// Create a copy of GeneratedArmy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? pointsLimit = null,
    Object? armyList = null,
    Object? strategy = null,
    Object? createdAt = null,
    Object? requiredPurchases = null,
    Object? totalPurchaseCost = null,
    Object? faction = freezed,
  }) {
    return _then(_$GeneratedArmyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      pointsLimit: null == pointsLimit
          ? _value.pointsLimit
          : pointsLimit // ignore: cast_nullable_to_non_nullable
              as int,
      armyList: null == armyList
          ? _value.armyList
          : armyList // ignore: cast_nullable_to_non_nullable
              as String,
      strategy: null == strategy
          ? _value.strategy
          : strategy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      requiredPurchases: null == requiredPurchases
          ? _value.requiredPurchases
          : requiredPurchases // ignore: cast_nullable_to_non_nullable
              as String,
      totalPurchaseCost: null == totalPurchaseCost
          ? _value.totalPurchaseCost
          : totalPurchaseCost // ignore: cast_nullable_to_non_nullable
              as double,
      faction: freezed == faction
          ? _value.faction
          : faction // ignore: cast_nullable_to_non_nullable
              as Faction?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeneratedArmyImpl implements _GeneratedArmy {
  const _$GeneratedArmyImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.pointsLimit,
      required this.armyList,
      required this.strategy,
      required this.createdAt,
      required this.requiredPurchases,
      required this.totalPurchaseCost,
      this.faction});

  factory _$GeneratedArmyImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeneratedArmyImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final int pointsLimit;
  @override
  final String armyList;
  @override
  final String strategy;
  @override
  final DateTime createdAt;
  @override
  final String requiredPurchases;
  @override
  final double totalPurchaseCost;
  @override
  final Faction? faction;

  @override
  String toString() {
    return 'GeneratedArmy(id: $id, name: $name, description: $description, pointsLimit: $pointsLimit, armyList: $armyList, strategy: $strategy, createdAt: $createdAt, requiredPurchases: $requiredPurchases, totalPurchaseCost: $totalPurchaseCost, faction: $faction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeneratedArmyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.pointsLimit, pointsLimit) ||
                other.pointsLimit == pointsLimit) &&
            (identical(other.armyList, armyList) ||
                other.armyList == armyList) &&
            (identical(other.strategy, strategy) ||
                other.strategy == strategy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.requiredPurchases, requiredPurchases) ||
                other.requiredPurchases == requiredPurchases) &&
            (identical(other.totalPurchaseCost, totalPurchaseCost) ||
                other.totalPurchaseCost == totalPurchaseCost) &&
            (identical(other.faction, faction) || other.faction == faction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      pointsLimit,
      armyList,
      strategy,
      createdAt,
      requiredPurchases,
      totalPurchaseCost,
      faction);

  /// Create a copy of GeneratedArmy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GeneratedArmyImplCopyWith<_$GeneratedArmyImpl> get copyWith =>
      __$$GeneratedArmyImplCopyWithImpl<_$GeneratedArmyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeneratedArmyImplToJson(
      this,
    );
  }
}

abstract class _GeneratedArmy implements GeneratedArmy {
  const factory _GeneratedArmy(
      {required final String id,
      required final String name,
      required final String description,
      required final int pointsLimit,
      required final String armyList,
      required final String strategy,
      required final DateTime createdAt,
      required final String requiredPurchases,
      required final double totalPurchaseCost,
      final Faction? faction}) = _$GeneratedArmyImpl;

  factory _GeneratedArmy.fromJson(Map<String, dynamic> json) =
      _$GeneratedArmyImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  int get pointsLimit;
  @override
  String get armyList;
  @override
  String get strategy;
  @override
  DateTime get createdAt;
  @override
  String get requiredPurchases;
  @override
  double get totalPurchaseCost;
  @override
  Faction? get faction;

  /// Create a copy of GeneratedArmy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GeneratedArmyImplCopyWith<_$GeneratedArmyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
