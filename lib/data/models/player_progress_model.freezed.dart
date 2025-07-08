// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_progress_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PlayerProgressData _$PlayerProgressDataFromJson(Map<String, dynamic> json) {
  return _PlayerProgressData.fromJson(json);
}

/// @nodoc
mixin _$PlayerProgressData {
  Set<int> get discoveredCharacterIds => throw _privateConstructorUsedError;
  Set<String> get discoveredRecipeKeys => throw _privateConstructorUsedError;

  /// Serializes this PlayerProgressData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlayerProgressData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerProgressDataCopyWith<PlayerProgressData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerProgressDataCopyWith<$Res> {
  factory $PlayerProgressDataCopyWith(
          PlayerProgressData value, $Res Function(PlayerProgressData) then) =
      _$PlayerProgressDataCopyWithImpl<$Res, PlayerProgressData>;
  @useResult
  $Res call(
      {Set<int> discoveredCharacterIds, Set<String> discoveredRecipeKeys});
}

/// @nodoc
class _$PlayerProgressDataCopyWithImpl<$Res, $Val extends PlayerProgressData>
    implements $PlayerProgressDataCopyWith<$Res> {
  _$PlayerProgressDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayerProgressData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? discoveredCharacterIds = null,
    Object? discoveredRecipeKeys = null,
  }) {
    return _then(_value.copyWith(
      discoveredCharacterIds: null == discoveredCharacterIds
          ? _value.discoveredCharacterIds
          : discoveredCharacterIds // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      discoveredRecipeKeys: null == discoveredRecipeKeys
          ? _value.discoveredRecipeKeys
          : discoveredRecipeKeys // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerProgressDataImplCopyWith<$Res>
    implements $PlayerProgressDataCopyWith<$Res> {
  factory _$$PlayerProgressDataImplCopyWith(_$PlayerProgressDataImpl value,
          $Res Function(_$PlayerProgressDataImpl) then) =
      __$$PlayerProgressDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Set<int> discoveredCharacterIds, Set<String> discoveredRecipeKeys});
}

/// @nodoc
class __$$PlayerProgressDataImplCopyWithImpl<$Res>
    extends _$PlayerProgressDataCopyWithImpl<$Res, _$PlayerProgressDataImpl>
    implements _$$PlayerProgressDataImplCopyWith<$Res> {
  __$$PlayerProgressDataImplCopyWithImpl(_$PlayerProgressDataImpl _value,
      $Res Function(_$PlayerProgressDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlayerProgressData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? discoveredCharacterIds = null,
    Object? discoveredRecipeKeys = null,
  }) {
    return _then(_$PlayerProgressDataImpl(
      discoveredCharacterIds: null == discoveredCharacterIds
          ? _value._discoveredCharacterIds
          : discoveredCharacterIds // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      discoveredRecipeKeys: null == discoveredRecipeKeys
          ? _value._discoveredRecipeKeys
          : discoveredRecipeKeys // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerProgressDataImpl implements _PlayerProgressData {
  const _$PlayerProgressDataImpl(
      {required final Set<int> discoveredCharacterIds,
      required final Set<String> discoveredRecipeKeys})
      : _discoveredCharacterIds = discoveredCharacterIds,
        _discoveredRecipeKeys = discoveredRecipeKeys;

  factory _$PlayerProgressDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerProgressDataImplFromJson(json);

  final Set<int> _discoveredCharacterIds;
  @override
  Set<int> get discoveredCharacterIds {
    if (_discoveredCharacterIds is EqualUnmodifiableSetView)
      return _discoveredCharacterIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_discoveredCharacterIds);
  }

  final Set<String> _discoveredRecipeKeys;
  @override
  Set<String> get discoveredRecipeKeys {
    if (_discoveredRecipeKeys is EqualUnmodifiableSetView)
      return _discoveredRecipeKeys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_discoveredRecipeKeys);
  }

  @override
  String toString() {
    return 'PlayerProgressData(discoveredCharacterIds: $discoveredCharacterIds, discoveredRecipeKeys: $discoveredRecipeKeys)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerProgressDataImpl &&
            const DeepCollectionEquality().equals(
                other._discoveredCharacterIds, _discoveredCharacterIds) &&
            const DeepCollectionEquality()
                .equals(other._discoveredRecipeKeys, _discoveredRecipeKeys));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_discoveredCharacterIds),
      const DeepCollectionEquality().hash(_discoveredRecipeKeys));

  /// Create a copy of PlayerProgressData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerProgressDataImplCopyWith<_$PlayerProgressDataImpl> get copyWith =>
      __$$PlayerProgressDataImplCopyWithImpl<_$PlayerProgressDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerProgressDataImplToJson(
      this,
    );
  }
}

abstract class _PlayerProgressData implements PlayerProgressData {
  const factory _PlayerProgressData(
          {required final Set<int> discoveredCharacterIds,
          required final Set<String> discoveredRecipeKeys}) =
      _$PlayerProgressDataImpl;

  factory _PlayerProgressData.fromJson(Map<String, dynamic> json) =
      _$PlayerProgressDataImpl.fromJson;

  @override
  Set<int> get discoveredCharacterIds;
  @override
  Set<String> get discoveredRecipeKeys;

  /// Create a copy of PlayerProgressData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerProgressDataImplCopyWith<_$PlayerProgressDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
