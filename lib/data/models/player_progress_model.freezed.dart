// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_progress_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlayerProgressData {
  List<int> get discoveredCharacterIds;
  Set<String> get discoveredRecipeKeys;
  Set<String> get uniqueFailedAttempts;
  int get hintsUsed;

  /// Create a copy of PlayerProgressData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PlayerProgressDataCopyWith<PlayerProgressData> get copyWith =>
      _$PlayerProgressDataCopyWithImpl<PlayerProgressData>(
          this as PlayerProgressData, _$identity);

  /// Serializes this PlayerProgressData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PlayerProgressData &&
            const DeepCollectionEquality()
                .equals(other.discoveredCharacterIds, discoveredCharacterIds) &&
            const DeepCollectionEquality()
                .equals(other.discoveredRecipeKeys, discoveredRecipeKeys) &&
            const DeepCollectionEquality()
                .equals(other.uniqueFailedAttempts, uniqueFailedAttempts) &&
            (identical(other.hintsUsed, hintsUsed) ||
                other.hintsUsed == hintsUsed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(discoveredCharacterIds),
      const DeepCollectionEquality().hash(discoveredRecipeKeys),
      const DeepCollectionEquality().hash(uniqueFailedAttempts),
      hintsUsed);

  @override
  String toString() {
    return 'PlayerProgressData(discoveredCharacterIds: $discoveredCharacterIds, discoveredRecipeKeys: $discoveredRecipeKeys, uniqueFailedAttempts: $uniqueFailedAttempts, hintsUsed: $hintsUsed)';
  }
}

/// @nodoc
abstract mixin class $PlayerProgressDataCopyWith<$Res> {
  factory $PlayerProgressDataCopyWith(
          PlayerProgressData value, $Res Function(PlayerProgressData) _then) =
      _$PlayerProgressDataCopyWithImpl;
  @useResult
  $Res call(
      {List<int> discoveredCharacterIds,
      Set<String> discoveredRecipeKeys,
      Set<String> uniqueFailedAttempts,
      int hintsUsed});
}

/// @nodoc
class _$PlayerProgressDataCopyWithImpl<$Res>
    implements $PlayerProgressDataCopyWith<$Res> {
  _$PlayerProgressDataCopyWithImpl(this._self, this._then);

  final PlayerProgressData _self;
  final $Res Function(PlayerProgressData) _then;

  /// Create a copy of PlayerProgressData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? discoveredCharacterIds = null,
    Object? discoveredRecipeKeys = null,
    Object? uniqueFailedAttempts = null,
    Object? hintsUsed = null,
  }) {
    return _then(_self.copyWith(
      discoveredCharacterIds: null == discoveredCharacterIds
          ? _self.discoveredCharacterIds
          : discoveredCharacterIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      discoveredRecipeKeys: null == discoveredRecipeKeys
          ? _self.discoveredRecipeKeys
          : discoveredRecipeKeys // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      uniqueFailedAttempts: null == uniqueFailedAttempts
          ? _self.uniqueFailedAttempts
          : uniqueFailedAttempts // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      hintsUsed: null == hintsUsed
          ? _self.hintsUsed
          : hintsUsed // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [PlayerProgressData].
extension PlayerProgressDataPatterns on PlayerProgressData {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PlayerProgressData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PlayerProgressData() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PlayerProgressData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlayerProgressData():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_PlayerProgressData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlayerProgressData() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            List<int> discoveredCharacterIds,
            Set<String> discoveredRecipeKeys,
            Set<String> uniqueFailedAttempts,
            int hintsUsed)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PlayerProgressData() when $default != null:
        return $default(
            _that.discoveredCharacterIds,
            _that.discoveredRecipeKeys,
            _that.uniqueFailedAttempts,
            _that.hintsUsed);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            List<int> discoveredCharacterIds,
            Set<String> discoveredRecipeKeys,
            Set<String> uniqueFailedAttempts,
            int hintsUsed)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlayerProgressData():
        return $default(
            _that.discoveredCharacterIds,
            _that.discoveredRecipeKeys,
            _that.uniqueFailedAttempts,
            _that.hintsUsed);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            List<int> discoveredCharacterIds,
            Set<String> discoveredRecipeKeys,
            Set<String> uniqueFailedAttempts,
            int hintsUsed)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlayerProgressData() when $default != null:
        return $default(
            _that.discoveredCharacterIds,
            _that.discoveredRecipeKeys,
            _that.uniqueFailedAttempts,
            _that.hintsUsed);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PlayerProgressData implements PlayerProgressData {
  const _PlayerProgressData(
      {required final List<int> discoveredCharacterIds,
      required final Set<String> discoveredRecipeKeys,
      final Set<String> uniqueFailedAttempts = const {},
      this.hintsUsed = 0})
      : _discoveredCharacterIds = discoveredCharacterIds,
        _discoveredRecipeKeys = discoveredRecipeKeys,
        _uniqueFailedAttempts = uniqueFailedAttempts;
  factory _PlayerProgressData.fromJson(Map<String, dynamic> json) =>
      _$PlayerProgressDataFromJson(json);

  final List<int> _discoveredCharacterIds;
  @override
  List<int> get discoveredCharacterIds {
    if (_discoveredCharacterIds is EqualUnmodifiableListView)
      return _discoveredCharacterIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_discoveredCharacterIds);
  }

  final Set<String> _discoveredRecipeKeys;
  @override
  Set<String> get discoveredRecipeKeys {
    if (_discoveredRecipeKeys is EqualUnmodifiableSetView)
      return _discoveredRecipeKeys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_discoveredRecipeKeys);
  }

  final Set<String> _uniqueFailedAttempts;
  @override
  @JsonKey()
  Set<String> get uniqueFailedAttempts {
    if (_uniqueFailedAttempts is EqualUnmodifiableSetView)
      return _uniqueFailedAttempts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_uniqueFailedAttempts);
  }

  @override
  @JsonKey()
  final int hintsUsed;

  /// Create a copy of PlayerProgressData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PlayerProgressDataCopyWith<_PlayerProgressData> get copyWith =>
      __$PlayerProgressDataCopyWithImpl<_PlayerProgressData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PlayerProgressDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PlayerProgressData &&
            const DeepCollectionEquality().equals(
                other._discoveredCharacterIds, _discoveredCharacterIds) &&
            const DeepCollectionEquality()
                .equals(other._discoveredRecipeKeys, _discoveredRecipeKeys) &&
            const DeepCollectionEquality()
                .equals(other._uniqueFailedAttempts, _uniqueFailedAttempts) &&
            (identical(other.hintsUsed, hintsUsed) ||
                other.hintsUsed == hintsUsed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_discoveredCharacterIds),
      const DeepCollectionEquality().hash(_discoveredRecipeKeys),
      const DeepCollectionEquality().hash(_uniqueFailedAttempts),
      hintsUsed);

  @override
  String toString() {
    return 'PlayerProgressData(discoveredCharacterIds: $discoveredCharacterIds, discoveredRecipeKeys: $discoveredRecipeKeys, uniqueFailedAttempts: $uniqueFailedAttempts, hintsUsed: $hintsUsed)';
  }
}

/// @nodoc
abstract mixin class _$PlayerProgressDataCopyWith<$Res>
    implements $PlayerProgressDataCopyWith<$Res> {
  factory _$PlayerProgressDataCopyWith(
          _PlayerProgressData value, $Res Function(_PlayerProgressData) _then) =
      __$PlayerProgressDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<int> discoveredCharacterIds,
      Set<String> discoveredRecipeKeys,
      Set<String> uniqueFailedAttempts,
      int hintsUsed});
}

/// @nodoc
class __$PlayerProgressDataCopyWithImpl<$Res>
    implements _$PlayerProgressDataCopyWith<$Res> {
  __$PlayerProgressDataCopyWithImpl(this._self, this._then);

  final _PlayerProgressData _self;
  final $Res Function(_PlayerProgressData) _then;

  /// Create a copy of PlayerProgressData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? discoveredCharacterIds = null,
    Object? discoveredRecipeKeys = null,
    Object? uniqueFailedAttempts = null,
    Object? hintsUsed = null,
  }) {
    return _then(_PlayerProgressData(
      discoveredCharacterIds: null == discoveredCharacterIds
          ? _self._discoveredCharacterIds
          : discoveredCharacterIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      discoveredRecipeKeys: null == discoveredRecipeKeys
          ? _self._discoveredRecipeKeys
          : discoveredRecipeKeys // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      uniqueFailedAttempts: null == uniqueFailedAttempts
          ? _self._uniqueFailedAttempts
          : uniqueFailedAttempts // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      hintsUsed: null == hintsUsed
          ? _self.hintsUsed
          : hintsUsed // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
