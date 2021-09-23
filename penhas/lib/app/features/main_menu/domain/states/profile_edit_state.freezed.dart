// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'profile_edit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$ProfileEditStateTearOff {
  const _$ProfileEditStateTearOff();

// ignore: unused_element
  _Initial initial() {
    return const _Initial();
  }

// ignore: unused_element
  _Loaded loaded(UserProfileEntity profile, bool securityModeFeatureEnabled) {
    return _Loaded(
      profile,
      securityModeFeatureEnabled,
    );
  }

// ignore: unused_element
  _ErrorDetails error(String message) {
    return _ErrorDetails(
      message,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ProfileEditState = _$ProfileEditStateTearOff();

/// @nodoc
mixin _$ProfileEditState {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required
        TResult loaded(
            UserProfileEntity profile, bool securityModeFeatureEnabled),
    @required TResult error(String message),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loaded(UserProfileEntity profile, bool securityModeFeatureEnabled),
    TResult error(String message),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(_Initial value),
    @required TResult loaded(_Loaded value),
    @required TResult error(_ErrorDetails value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult loaded(_Loaded value),
    TResult error(_ErrorDetails value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $ProfileEditStateCopyWith<$Res> {
  factory $ProfileEditStateCopyWith(
          ProfileEditState value, $Res Function(ProfileEditState) then) =
      _$ProfileEditStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$ProfileEditStateCopyWithImpl<$Res>
    implements $ProfileEditStateCopyWith<$Res> {
  _$ProfileEditStateCopyWithImpl(this._value, this._then);

  final ProfileEditState _value;
  // ignore: unused_field
  final $Res Function(ProfileEditState) _then;
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$ProfileEditStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;
}

/// @nodoc
class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'ProfileEditState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required
        TResult loaded(
            UserProfileEntity profile, bool securityModeFeatureEnabled),
    @required TResult error(String message),
  }) {
    assert(initial != null);
    assert(loaded != null);
    assert(error != null);
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loaded(UserProfileEntity profile, bool securityModeFeatureEnabled),
    TResult error(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(_Initial value),
    @required TResult loaded(_Loaded value),
    @required TResult error(_ErrorDetails value),
  }) {
    assert(initial != null);
    assert(loaded != null);
    assert(error != null);
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult loaded(_Loaded value),
    TResult error(_ErrorDetails value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ProfileEditState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$LoadedCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) then) =
      __$LoadedCopyWithImpl<$Res>;
  $Res call({UserProfileEntity profile, bool securityModeFeatureEnabled});
}

/// @nodoc
class __$LoadedCopyWithImpl<$Res> extends _$ProfileEditStateCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(_Loaded _value, $Res Function(_Loaded) _then)
      : super(_value, (v) => _then(v as _Loaded));

  @override
  _Loaded get _value => super._value as _Loaded;

  @override
  $Res call({
    Object profile = freezed,
    Object securityModeFeatureEnabled = freezed,
  }) {
    return _then(_Loaded(
      profile == freezed ? _value.profile : profile as UserProfileEntity,
      securityModeFeatureEnabled == freezed
          ? _value.securityModeFeatureEnabled
          : securityModeFeatureEnabled as bool,
    ));
  }
}

/// @nodoc
class _$_Loaded implements _Loaded {
  const _$_Loaded(this.profile, this.securityModeFeatureEnabled)
      : assert(profile != null),
        assert(securityModeFeatureEnabled != null);

  @override
  final UserProfileEntity profile;
  @override
  final bool securityModeFeatureEnabled;

  @override
  String toString() {
    return 'ProfileEditState.loaded(profile: $profile, securityModeFeatureEnabled: $securityModeFeatureEnabled)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Loaded &&
            (identical(other.profile, profile) ||
                const DeepCollectionEquality()
                    .equals(other.profile, profile)) &&
            (identical(other.securityModeFeatureEnabled,
                    securityModeFeatureEnabled) ||
                const DeepCollectionEquality().equals(
                    other.securityModeFeatureEnabled,
                    securityModeFeatureEnabled)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(profile) ^
      const DeepCollectionEquality().hash(securityModeFeatureEnabled);

  @JsonKey(ignore: true)
  @override
  _$LoadedCopyWith<_Loaded> get copyWith =>
      __$LoadedCopyWithImpl<_Loaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required
        TResult loaded(
            UserProfileEntity profile, bool securityModeFeatureEnabled),
    @required TResult error(String message),
  }) {
    assert(initial != null);
    assert(loaded != null);
    assert(error != null);
    return loaded(profile, securityModeFeatureEnabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loaded(UserProfileEntity profile, bool securityModeFeatureEnabled),
    TResult error(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loaded != null) {
      return loaded(profile, securityModeFeatureEnabled);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(_Initial value),
    @required TResult loaded(_Loaded value),
    @required TResult error(_ErrorDetails value),
  }) {
    assert(initial != null);
    assert(loaded != null);
    assert(error != null);
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult loaded(_Loaded value),
    TResult error(_ErrorDetails value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements ProfileEditState {
  const factory _Loaded(
      UserProfileEntity profile, bool securityModeFeatureEnabled) = _$_Loaded;

  UserProfileEntity get profile;
  bool get securityModeFeatureEnabled;
  @JsonKey(ignore: true)
  _$LoadedCopyWith<_Loaded> get copyWith;
}

/// @nodoc
abstract class _$ErrorDetailsCopyWith<$Res> {
  factory _$ErrorDetailsCopyWith(
          _ErrorDetails value, $Res Function(_ErrorDetails) then) =
      __$ErrorDetailsCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$ErrorDetailsCopyWithImpl<$Res>
    extends _$ProfileEditStateCopyWithImpl<$Res>
    implements _$ErrorDetailsCopyWith<$Res> {
  __$ErrorDetailsCopyWithImpl(
      _ErrorDetails _value, $Res Function(_ErrorDetails) _then)
      : super(_value, (v) => _then(v as _ErrorDetails));

  @override
  _ErrorDetails get _value => super._value as _ErrorDetails;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(_ErrorDetails(
      message == freezed ? _value.message : message as String,
    ));
  }
}

/// @nodoc
class _$_ErrorDetails implements _ErrorDetails {
  const _$_ErrorDetails(this.message) : assert(message != null);

  @override
  final String message;

  @override
  String toString() {
    return 'ProfileEditState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ErrorDetails &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  _$ErrorDetailsCopyWith<_ErrorDetails> get copyWith =>
      __$ErrorDetailsCopyWithImpl<_ErrorDetails>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required
        TResult loaded(
            UserProfileEntity profile, bool securityModeFeatureEnabled),
    @required TResult error(String message),
  }) {
    assert(initial != null);
    assert(loaded != null);
    assert(error != null);
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loaded(UserProfileEntity profile, bool securityModeFeatureEnabled),
    TResult error(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(_Initial value),
    @required TResult loaded(_Loaded value),
    @required TResult error(_ErrorDetails value),
  }) {
    assert(initial != null);
    assert(loaded != null);
    assert(error != null);
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult loaded(_Loaded value),
    TResult error(_ErrorDetails value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ErrorDetails implements ProfileEditState {
  const factory _ErrorDetails(String message) = _$_ErrorDetails;

  String get message;
  @JsonKey(ignore: true)
  _$ErrorDetailsCopyWith<_ErrorDetails> get copyWith;
}
