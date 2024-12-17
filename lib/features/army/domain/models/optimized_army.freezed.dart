// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'optimized_army.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OptimizedArmy _$OptimizedArmyFromJson(Map<String, dynamic> json) {
  return _OptimizedArmy.fromJson(json);
}

/// @nodoc
mixin _$OptimizedArmy {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get pointsLimit => throw _privateConstructorUsedError;
  String get armyList => throw _privateConstructorUsedError;
  String get strategy => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  Faction? get faction => throw _privateConstructorUsedError;

  /// Serializes this OptimizedArmy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OptimizedArmy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OptimizedArmyCopyWith<OptimizedArmy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OptimizedArmyCopyWith<$Res> {
  factory $OptimizedArmyCopyWith(
          OptimizedArmy value, $Res Function(OptimizedArmy) then) =
      _$OptimizedArmyCopyWithImpl<$Res, OptimizedArmy>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      int pointsLimit,
      String armyList,
      String strategy,
      DateTime createdAt,
      Faction? faction});

  $FactionCopyWith<$Res>? get faction;
}

/// @nodoc
class _$OptimizedArmyCopyWithImpl<$Res, $Val extends OptimizedArmy>
    implements $OptimizedArmyCopyWith<$Res> {
  _$OptimizedArmyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OptimizedArmy
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
      faction: freezed == faction
          ? _value.faction
          : faction // ignore: cast_nullable_to_non_nullable
              as Faction?,
    ) as $Val);
  }

  /// Create a copy of OptimizedArmy
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
abstract class _$$OptimizedArmyImplCopyWith<$Res>
    implements $OptimizedArmyCopyWith<$Res> {
  factory _$$OptimizedArmyImplCopyWith(
          _$OptimizedArmyImpl value, $Res Function(_$OptimizedArmyImpl) then) =
      __$$OptimizedArmyImplCopyWithImpl<$Res>;
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
      Faction? faction});

  @override
  $FactionCopyWith<$Res>? get faction;
}

/// @nodoc
class __$$OptimizedArmyImplCopyWithImpl<$Res>
    extends _$OptimizedArmyCopyWithImpl<$Res, _$OptimizedArmyImpl>
    implements _$$OptimizedArmyImplCopyWith<$Res> {
  __$$OptimizedArmyImplCopyWithImpl(
      _$OptimizedArmyImpl _value, $Res Function(_$OptimizedArmyImpl) _then)
      : super(_value, _then);

  /// Create a copy of OptimizedArmy
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
    Object? faction = freezed,
  }) {
    return _then(_$OptimizedArmyImpl(
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
      faction: freezed == faction
          ? _value.faction
          : faction // ignore: cast_nullable_to_non_nullable
              as Faction?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OptimizedArmyImpl implements _OptimizedArmy {
  const _$OptimizedArmyImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.pointsLimit,
      required this.armyList,
      required this.strategy,
      required this.createdAt,
      this.faction});

  factory _$OptimizedArmyImpl.fromJson(Map<String, dynamic> json) =>
      _$$OptimizedArmyImplFromJson(json);

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
  final Faction? faction;

  @override
  String toString() {
    return 'OptimizedArmy(id: $id, name: $name, description: $description, pointsLimit: $pointsLimit, armyList: $armyList, strategy: $strategy, createdAt: $createdAt, faction: $faction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OptimizedArmyImpl &&
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
            (identical(other.faction, faction) || other.faction == faction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description,
      pointsLimit, armyList, strategy, createdAt, faction);

  /// Create a copy of OptimizedArmy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OptimizedArmyImplCopyWith<_$OptimizedArmyImpl> get copyWith =>
      __$$OptimizedArmyImplCopyWithImpl<_$OptimizedArmyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OptimizedArmyImplToJson(
      this,
    );
  }
}

abstract class _OptimizedArmy implements OptimizedArmy {
  const factory _OptimizedArmy(
      {required final String id,
      required final String name,
      required final String description,
      required final int pointsLimit,
      required final String armyList,
      required final String strategy,
      required final DateTime createdAt,
      final Faction? faction}) = _$OptimizedArmyImpl;

  factory _OptimizedArmy.fromJson(Map<String, dynamic> json) =
      _$OptimizedArmyImpl.fromJson;

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
  Faction? get faction;

  /// Create a copy of OptimizedArmy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OptimizedArmyImplCopyWith<_$OptimizedArmyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
