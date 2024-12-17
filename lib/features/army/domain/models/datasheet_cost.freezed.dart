// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'datasheet_cost.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DatasheetCost _$DatasheetCostFromJson(Map<String, dynamic> json) {
  return _DatasheetCost.fromJson(json);
}

/// @nodoc
mixin _$DatasheetCost {
  String get datasheetId => throw _privateConstructorUsedError;
  int get line => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get cost => throw _privateConstructorUsedError;

  /// Serializes this DatasheetCost to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DatasheetCost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DatasheetCostCopyWith<DatasheetCost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DatasheetCostCopyWith<$Res> {
  factory $DatasheetCostCopyWith(
          DatasheetCost value, $Res Function(DatasheetCost) then) =
      _$DatasheetCostCopyWithImpl<$Res, DatasheetCost>;
  @useResult
  $Res call({String datasheetId, int line, String description, int cost});
}

/// @nodoc
class _$DatasheetCostCopyWithImpl<$Res, $Val extends DatasheetCost>
    implements $DatasheetCostCopyWith<$Res> {
  _$DatasheetCostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DatasheetCost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? datasheetId = null,
    Object? line = null,
    Object? description = null,
    Object? cost = null,
  }) {
    return _then(_value.copyWith(
      datasheetId: null == datasheetId
          ? _value.datasheetId
          : datasheetId // ignore: cast_nullable_to_non_nullable
              as String,
      line: null == line
          ? _value.line
          : line // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DatasheetCostImplCopyWith<$Res>
    implements $DatasheetCostCopyWith<$Res> {
  factory _$$DatasheetCostImplCopyWith(
          _$DatasheetCostImpl value, $Res Function(_$DatasheetCostImpl) then) =
      __$$DatasheetCostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String datasheetId, int line, String description, int cost});
}

/// @nodoc
class __$$DatasheetCostImplCopyWithImpl<$Res>
    extends _$DatasheetCostCopyWithImpl<$Res, _$DatasheetCostImpl>
    implements _$$DatasheetCostImplCopyWith<$Res> {
  __$$DatasheetCostImplCopyWithImpl(
      _$DatasheetCostImpl _value, $Res Function(_$DatasheetCostImpl) _then)
      : super(_value, _then);

  /// Create a copy of DatasheetCost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? datasheetId = null,
    Object? line = null,
    Object? description = null,
    Object? cost = null,
  }) {
    return _then(_$DatasheetCostImpl(
      datasheetId: null == datasheetId
          ? _value.datasheetId
          : datasheetId // ignore: cast_nullable_to_non_nullable
              as String,
      line: null == line
          ? _value.line
          : line // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DatasheetCostImpl implements _DatasheetCost {
  const _$DatasheetCostImpl(
      {required this.datasheetId,
      required this.line,
      required this.description,
      required this.cost});

  factory _$DatasheetCostImpl.fromJson(Map<String, dynamic> json) =>
      _$$DatasheetCostImplFromJson(json);

  @override
  final String datasheetId;
  @override
  final int line;
  @override
  final String description;
  @override
  final int cost;

  @override
  String toString() {
    return 'DatasheetCost(datasheetId: $datasheetId, line: $line, description: $description, cost: $cost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatasheetCostImpl &&
            (identical(other.datasheetId, datasheetId) ||
                other.datasheetId == datasheetId) &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.cost, cost) || other.cost == cost));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, datasheetId, line, description, cost);

  /// Create a copy of DatasheetCost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DatasheetCostImplCopyWith<_$DatasheetCostImpl> get copyWith =>
      __$$DatasheetCostImplCopyWithImpl<_$DatasheetCostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DatasheetCostImplToJson(
      this,
    );
  }
}

abstract class _DatasheetCost implements DatasheetCost {
  const factory _DatasheetCost(
      {required final String datasheetId,
      required final int line,
      required final String description,
      required final int cost}) = _$DatasheetCostImpl;

  factory _DatasheetCost.fromJson(Map<String, dynamic> json) =
      _$DatasheetCostImpl.fromJson;

  @override
  String get datasheetId;
  @override
  int get line;
  @override
  String get description;
  @override
  int get cost;

  /// Create a copy of DatasheetCost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DatasheetCostImplCopyWith<_$DatasheetCostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
