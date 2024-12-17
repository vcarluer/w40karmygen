// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'faction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Faction _$FactionFromJson(Map<String, dynamic> json) {
  return _Faction.fromJson(json);
}

/// @nodoc
mixin _$Faction {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get link => throw _privateConstructorUsedError;

  /// Serializes this Faction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Faction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FactionCopyWith<Faction> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FactionCopyWith<$Res> {
  factory $FactionCopyWith(Faction value, $Res Function(Faction) then) =
      _$FactionCopyWithImpl<$Res, Faction>;
  @useResult
  $Res call({String id, String name, String link});
}

/// @nodoc
class _$FactionCopyWithImpl<$Res, $Val extends Faction>
    implements $FactionCopyWith<$Res> {
  _$FactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Faction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? link = null,
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
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FactionImplCopyWith<$Res> implements $FactionCopyWith<$Res> {
  factory _$$FactionImplCopyWith(
          _$FactionImpl value, $Res Function(_$FactionImpl) then) =
      __$$FactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String link});
}

/// @nodoc
class __$$FactionImplCopyWithImpl<$Res>
    extends _$FactionCopyWithImpl<$Res, _$FactionImpl>
    implements _$$FactionImplCopyWith<$Res> {
  __$$FactionImplCopyWithImpl(
      _$FactionImpl _value, $Res Function(_$FactionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Faction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? link = null,
  }) {
    return _then(_$FactionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FactionImpl implements _Faction {
  const _$FactionImpl(
      {required this.id, required this.name, required this.link});

  factory _$FactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$FactionImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String link;

  @override
  String toString() {
    return 'Faction(id: $id, name: $name, link: $link)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.link, link) || other.link == link));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, link);

  /// Create a copy of Faction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FactionImplCopyWith<_$FactionImpl> get copyWith =>
      __$$FactionImplCopyWithImpl<_$FactionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FactionImplToJson(
      this,
    );
  }
}

abstract class _Faction implements Faction {
  const factory _Faction(
      {required final String id,
      required final String name,
      required final String link}) = _$FactionImpl;

  factory _Faction.fromJson(Map<String, dynamic> json) = _$FactionImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get link;

  /// Create a copy of Faction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FactionImplCopyWith<_$FactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
