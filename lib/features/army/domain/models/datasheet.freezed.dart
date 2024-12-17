// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'datasheet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Datasheet _$DatasheetFromJson(Map<String, dynamic> json) {
  return _Datasheet.fromJson(json);
}

/// @nodoc
mixin _$Datasheet {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get factionId => throw _privateConstructorUsedError;
  String get sourceId => throw _privateConstructorUsedError;
  String get legend => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String get loadout => throw _privateConstructorUsedError;
  String? get transport => throw _privateConstructorUsedError;
  bool get virtual => throw _privateConstructorUsedError;
  String? get leaderHead => throw _privateConstructorUsedError;
  String? get leaderFooter => throw _privateConstructorUsedError;
  String? get damagedW => throw _privateConstructorUsedError;
  String? get damagedDescription => throw _privateConstructorUsedError;
  String get link => throw _privateConstructorUsedError;
  Faction? get faction => throw _privateConstructorUsedError;

  /// Serializes this Datasheet to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Datasheet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DatasheetCopyWith<Datasheet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DatasheetCopyWith<$Res> {
  factory $DatasheetCopyWith(Datasheet value, $Res Function(Datasheet) then) =
      _$DatasheetCopyWithImpl<$Res, Datasheet>;
  @useResult
  $Res call(
      {String id,
      String name,
      String factionId,
      String sourceId,
      String legend,
      String role,
      String loadout,
      String? transport,
      bool virtual,
      String? leaderHead,
      String? leaderFooter,
      String? damagedW,
      String? damagedDescription,
      String link,
      Faction? faction});

  $FactionCopyWith<$Res>? get faction;
}

/// @nodoc
class _$DatasheetCopyWithImpl<$Res, $Val extends Datasheet>
    implements $DatasheetCopyWith<$Res> {
  _$DatasheetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Datasheet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? factionId = null,
    Object? sourceId = null,
    Object? legend = null,
    Object? role = null,
    Object? loadout = null,
    Object? transport = freezed,
    Object? virtual = null,
    Object? leaderHead = freezed,
    Object? leaderFooter = freezed,
    Object? damagedW = freezed,
    Object? damagedDescription = freezed,
    Object? link = null,
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
      factionId: null == factionId
          ? _value.factionId
          : factionId // ignore: cast_nullable_to_non_nullable
              as String,
      sourceId: null == sourceId
          ? _value.sourceId
          : sourceId // ignore: cast_nullable_to_non_nullable
              as String,
      legend: null == legend
          ? _value.legend
          : legend // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      loadout: null == loadout
          ? _value.loadout
          : loadout // ignore: cast_nullable_to_non_nullable
              as String,
      transport: freezed == transport
          ? _value.transport
          : transport // ignore: cast_nullable_to_non_nullable
              as String?,
      virtual: null == virtual
          ? _value.virtual
          : virtual // ignore: cast_nullable_to_non_nullable
              as bool,
      leaderHead: freezed == leaderHead
          ? _value.leaderHead
          : leaderHead // ignore: cast_nullable_to_non_nullable
              as String?,
      leaderFooter: freezed == leaderFooter
          ? _value.leaderFooter
          : leaderFooter // ignore: cast_nullable_to_non_nullable
              as String?,
      damagedW: freezed == damagedW
          ? _value.damagedW
          : damagedW // ignore: cast_nullable_to_non_nullable
              as String?,
      damagedDescription: freezed == damagedDescription
          ? _value.damagedDescription
          : damagedDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      faction: freezed == faction
          ? _value.faction
          : faction // ignore: cast_nullable_to_non_nullable
              as Faction?,
    ) as $Val);
  }

  /// Create a copy of Datasheet
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
abstract class _$$DatasheetImplCopyWith<$Res>
    implements $DatasheetCopyWith<$Res> {
  factory _$$DatasheetImplCopyWith(
          _$DatasheetImpl value, $Res Function(_$DatasheetImpl) then) =
      __$$DatasheetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String factionId,
      String sourceId,
      String legend,
      String role,
      String loadout,
      String? transport,
      bool virtual,
      String? leaderHead,
      String? leaderFooter,
      String? damagedW,
      String? damagedDescription,
      String link,
      Faction? faction});

  @override
  $FactionCopyWith<$Res>? get faction;
}

/// @nodoc
class __$$DatasheetImplCopyWithImpl<$Res>
    extends _$DatasheetCopyWithImpl<$Res, _$DatasheetImpl>
    implements _$$DatasheetImplCopyWith<$Res> {
  __$$DatasheetImplCopyWithImpl(
      _$DatasheetImpl _value, $Res Function(_$DatasheetImpl) _then)
      : super(_value, _then);

  /// Create a copy of Datasheet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? factionId = null,
    Object? sourceId = null,
    Object? legend = null,
    Object? role = null,
    Object? loadout = null,
    Object? transport = freezed,
    Object? virtual = null,
    Object? leaderHead = freezed,
    Object? leaderFooter = freezed,
    Object? damagedW = freezed,
    Object? damagedDescription = freezed,
    Object? link = null,
    Object? faction = freezed,
  }) {
    return _then(_$DatasheetImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      factionId: null == factionId
          ? _value.factionId
          : factionId // ignore: cast_nullable_to_non_nullable
              as String,
      sourceId: null == sourceId
          ? _value.sourceId
          : sourceId // ignore: cast_nullable_to_non_nullable
              as String,
      legend: null == legend
          ? _value.legend
          : legend // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      loadout: null == loadout
          ? _value.loadout
          : loadout // ignore: cast_nullable_to_non_nullable
              as String,
      transport: freezed == transport
          ? _value.transport
          : transport // ignore: cast_nullable_to_non_nullable
              as String?,
      virtual: null == virtual
          ? _value.virtual
          : virtual // ignore: cast_nullable_to_non_nullable
              as bool,
      leaderHead: freezed == leaderHead
          ? _value.leaderHead
          : leaderHead // ignore: cast_nullable_to_non_nullable
              as String?,
      leaderFooter: freezed == leaderFooter
          ? _value.leaderFooter
          : leaderFooter // ignore: cast_nullable_to_non_nullable
              as String?,
      damagedW: freezed == damagedW
          ? _value.damagedW
          : damagedW // ignore: cast_nullable_to_non_nullable
              as String?,
      damagedDescription: freezed == damagedDescription
          ? _value.damagedDescription
          : damagedDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      faction: freezed == faction
          ? _value.faction
          : faction // ignore: cast_nullable_to_non_nullable
              as Faction?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DatasheetImpl implements _Datasheet {
  const _$DatasheetImpl(
      {required this.id,
      required this.name,
      required this.factionId,
      required this.sourceId,
      required this.legend,
      required this.role,
      required this.loadout,
      this.transport,
      this.virtual = false,
      this.leaderHead,
      this.leaderFooter,
      this.damagedW,
      this.damagedDescription,
      required this.link,
      this.faction});

  factory _$DatasheetImpl.fromJson(Map<String, dynamic> json) =>
      _$$DatasheetImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String factionId;
  @override
  final String sourceId;
  @override
  final String legend;
  @override
  final String role;
  @override
  final String loadout;
  @override
  final String? transport;
  @override
  @JsonKey()
  final bool virtual;
  @override
  final String? leaderHead;
  @override
  final String? leaderFooter;
  @override
  final String? damagedW;
  @override
  final String? damagedDescription;
  @override
  final String link;
  @override
  final Faction? faction;

  @override
  String toString() {
    return 'Datasheet(id: $id, name: $name, factionId: $factionId, sourceId: $sourceId, legend: $legend, role: $role, loadout: $loadout, transport: $transport, virtual: $virtual, leaderHead: $leaderHead, leaderFooter: $leaderFooter, damagedW: $damagedW, damagedDescription: $damagedDescription, link: $link, faction: $faction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatasheetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.factionId, factionId) ||
                other.factionId == factionId) &&
            (identical(other.sourceId, sourceId) ||
                other.sourceId == sourceId) &&
            (identical(other.legend, legend) || other.legend == legend) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.loadout, loadout) || other.loadout == loadout) &&
            (identical(other.transport, transport) ||
                other.transport == transport) &&
            (identical(other.virtual, virtual) || other.virtual == virtual) &&
            (identical(other.leaderHead, leaderHead) ||
                other.leaderHead == leaderHead) &&
            (identical(other.leaderFooter, leaderFooter) ||
                other.leaderFooter == leaderFooter) &&
            (identical(other.damagedW, damagedW) ||
                other.damagedW == damagedW) &&
            (identical(other.damagedDescription, damagedDescription) ||
                other.damagedDescription == damagedDescription) &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.faction, faction) || other.faction == faction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      factionId,
      sourceId,
      legend,
      role,
      loadout,
      transport,
      virtual,
      leaderHead,
      leaderFooter,
      damagedW,
      damagedDescription,
      link,
      faction);

  /// Create a copy of Datasheet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DatasheetImplCopyWith<_$DatasheetImpl> get copyWith =>
      __$$DatasheetImplCopyWithImpl<_$DatasheetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DatasheetImplToJson(
      this,
    );
  }
}

abstract class _Datasheet implements Datasheet {
  const factory _Datasheet(
      {required final String id,
      required final String name,
      required final String factionId,
      required final String sourceId,
      required final String legend,
      required final String role,
      required final String loadout,
      final String? transport,
      final bool virtual,
      final String? leaderHead,
      final String? leaderFooter,
      final String? damagedW,
      final String? damagedDescription,
      required final String link,
      final Faction? faction}) = _$DatasheetImpl;

  factory _Datasheet.fromJson(Map<String, dynamic> json) =
      _$DatasheetImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get factionId;
  @override
  String get sourceId;
  @override
  String get legend;
  @override
  String get role;
  @override
  String get loadout;
  @override
  String? get transport;
  @override
  bool get virtual;
  @override
  String? get leaderHead;
  @override
  String? get leaderFooter;
  @override
  String? get damagedW;
  @override
  String? get damagedDescription;
  @override
  String get link;
  @override
  Faction? get faction;

  /// Create a copy of Datasheet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DatasheetImplCopyWith<_$DatasheetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
