// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$UserProfileStateTearOff {
  const _$UserProfileStateTearOff();

  _Initial initial() {
    return const _Initial();
  }

  _Loaded loaded(UserDetailEntity person) {
    return _Loaded(
      person,
    );
  }

  _ErrorDetails error(String message) {
    return _ErrorDetails(
      message,
    );
  }
}

/// @nodoc
const $UserProfileState = _$UserProfileStateTearOff();

/// @nodoc
mixin _$UserProfileState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(UserDetailEntity person) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(UserDetailEntity person)? loaded,
    TResult Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(UserDetailEntity person)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ErrorDetails value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ErrorDetails value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ErrorDetails value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileStateCopyWith<$Res> {
  factory $UserProfileStateCopyWith(
          UserProfileState value, $Res Function(UserProfileState) then) =
      _$UserProfileStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$UserProfileStateCopyWithImpl<$Res>
    implements $UserProfileStateCopyWith<$Res> {
  _$UserProfileStateCopyWithImpl(this._value, this._then);

  final UserProfileState _value;
  // ignore: unused_field
  final $Res Function(UserProfileState) _then;
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$UserProfileStateCopyWithImpl<$Res>
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
    return 'UserProfileState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(UserDetailEntity person) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(UserDetailEntity person)? loaded,
    TResult Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(UserDetailEntity person)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ErrorDetails value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ErrorDetails value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ErrorDetails value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements UserProfileState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$LoadedCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) then) =
      __$LoadedCopyWithImpl<$Res>;
  $Res call({UserDetailEntity person});
}

/// @nodoc
class __$LoadedCopyWithImpl<$Res> extends _$UserProfileStateCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(_Loaded _value, $Res Function(_Loaded) _then)
      : super(_value, (v) => _then(v as _Loaded));

  @override
  _Loaded get _value => super._value as _Loaded;

  @override
  $Res call({
    Object? person = freezed,
  }) {
    return _then(_Loaded(
      person == freezed
          ? _value.person
          : person // ignore: cast_nullable_to_non_nullable
              as UserDetailEntity,
    ));
  }
}

/// @nodoc

class _$_Loaded implements _Loaded {
  const _$_Loaded(this.person);

  @override
  final UserDetailEntity person;

  @override
  String toString() {
    return 'UserProfileState.loaded(person: $person)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Loaded &&
            const DeepCollectionEquality().equals(other.person, person));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(person));

  @JsonKey(ignore: true)
  @override
  _$LoadedCopyWith<_Loaded> get copyWith =>
      __$LoadedCopyWithImpl<_Loaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(UserDetailEntity person) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(person);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(UserDetailEntity person)? loaded,
    TResult Function(String message)? error,
  }) {
    return loaded?.call(person);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(UserDetailEntity person)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(person);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ErrorDetails value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ErrorDetails value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ErrorDetails value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements UserProfileState {
  const factory _Loaded(UserDetailEntity person) = _$_Loaded;

  UserDetailEntity get person;
  @JsonKey(ignore: true)
  _$LoadedCopyWith<_Loaded> get copyWith => throw _privateConstructorUsedError;
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
    extends _$UserProfileStateCopyWithImpl<$Res>
    implements _$ErrorDetailsCopyWith<$Res> {
  __$ErrorDetailsCopyWithImpl(
      _ErrorDetails _value, $Res Function(_ErrorDetails) _then)
      : super(_value, (v) => _then(v as _ErrorDetails));

  @override
  _ErrorDetails get _value => super._value as _ErrorDetails;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_ErrorDetails(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ErrorDetails implements _ErrorDetails {
  const _$_ErrorDetails(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'UserProfileState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ErrorDetails &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$ErrorDetailsCopyWith<_ErrorDetails> get copyWith =>
      __$ErrorDetailsCopyWithImpl<_ErrorDetails>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(UserDetailEntity person) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(UserDetailEntity person)? loaded,
    TResult Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(UserDetailEntity person)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ErrorDetails value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ErrorDetails value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ErrorDetails value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ErrorDetails implements UserProfileState {
  const factory _ErrorDetails(String message) = _$_ErrorDetails;

  String get message;
  @JsonKey(ignore: true)
  _$ErrorDetailsCopyWith<_ErrorDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$UserMenuStateTearOff {
  const _$UserMenuStateTearOff();

  _MenuStateHidden hidden() {
    return const _MenuStateHidden();
  }

  _MenuStateVisible visible() {
    return const _MenuStateVisible();
  }
}

/// @nodoc
const $UserMenuState = _$UserMenuStateTearOff();

/// @nodoc
mixin _$UserMenuState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() hidden,
    required TResult Function() visible,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? hidden,
    TResult Function()? visible,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? hidden,
    TResult Function()? visible,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MenuStateHidden value) hidden,
    required TResult Function(_MenuStateVisible value) visible,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_MenuStateHidden value)? hidden,
    TResult Function(_MenuStateVisible value)? visible,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MenuStateHidden value)? hidden,
    TResult Function(_MenuStateVisible value)? visible,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserMenuStateCopyWith<$Res> {
  factory $UserMenuStateCopyWith(
          UserMenuState value, $Res Function(UserMenuState) then) =
      _$UserMenuStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$UserMenuStateCopyWithImpl<$Res>
    implements $UserMenuStateCopyWith<$Res> {
  _$UserMenuStateCopyWithImpl(this._value, this._then);

  final UserMenuState _value;
  // ignore: unused_field
  final $Res Function(UserMenuState) _then;
}

/// @nodoc
abstract class _$MenuStateHiddenCopyWith<$Res> {
  factory _$MenuStateHiddenCopyWith(
          _MenuStateHidden value, $Res Function(_MenuStateHidden) then) =
      __$MenuStateHiddenCopyWithImpl<$Res>;
}

/// @nodoc
class __$MenuStateHiddenCopyWithImpl<$Res>
    extends _$UserMenuStateCopyWithImpl<$Res>
    implements _$MenuStateHiddenCopyWith<$Res> {
  __$MenuStateHiddenCopyWithImpl(
      _MenuStateHidden _value, $Res Function(_MenuStateHidden) _then)
      : super(_value, (v) => _then(v as _MenuStateHidden));

  @override
  _MenuStateHidden get _value => super._value as _MenuStateHidden;
}

/// @nodoc

class _$_MenuStateHidden implements _MenuStateHidden {
  const _$_MenuStateHidden();

  @override
  String toString() {
    return 'UserMenuState.hidden()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _MenuStateHidden);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() hidden,
    required TResult Function() visible,
  }) {
    return hidden();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? hidden,
    TResult Function()? visible,
  }) {
    return hidden?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? hidden,
    TResult Function()? visible,
    required TResult orElse(),
  }) {
    if (hidden != null) {
      return hidden();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MenuStateHidden value) hidden,
    required TResult Function(_MenuStateVisible value) visible,
  }) {
    return hidden(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_MenuStateHidden value)? hidden,
    TResult Function(_MenuStateVisible value)? visible,
  }) {
    return hidden?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MenuStateHidden value)? hidden,
    TResult Function(_MenuStateVisible value)? visible,
    required TResult orElse(),
  }) {
    if (hidden != null) {
      return hidden(this);
    }
    return orElse();
  }
}

abstract class _MenuStateHidden implements UserMenuState {
  const factory _MenuStateHidden() = _$_MenuStateHidden;
}

/// @nodoc
abstract class _$MenuStateVisibleCopyWith<$Res> {
  factory _$MenuStateVisibleCopyWith(
          _MenuStateVisible value, $Res Function(_MenuStateVisible) then) =
      __$MenuStateVisibleCopyWithImpl<$Res>;
}

/// @nodoc
class __$MenuStateVisibleCopyWithImpl<$Res>
    extends _$UserMenuStateCopyWithImpl<$Res>
    implements _$MenuStateVisibleCopyWith<$Res> {
  __$MenuStateVisibleCopyWithImpl(
      _MenuStateVisible _value, $Res Function(_MenuStateVisible) _then)
      : super(_value, (v) => _then(v as _MenuStateVisible));

  @override
  _MenuStateVisible get _value => super._value as _MenuStateVisible;
}

/// @nodoc

class _$_MenuStateVisible implements _MenuStateVisible {
  const _$_MenuStateVisible();

  @override
  String toString() {
    return 'UserMenuState.visible()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _MenuStateVisible);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() hidden,
    required TResult Function() visible,
  }) {
    return visible();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? hidden,
    TResult Function()? visible,
  }) {
    return visible?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? hidden,
    TResult Function()? visible,
    required TResult orElse(),
  }) {
    if (visible != null) {
      return visible();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MenuStateHidden value) hidden,
    required TResult Function(_MenuStateVisible value) visible,
  }) {
    return visible(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_MenuStateHidden value)? hidden,
    TResult Function(_MenuStateVisible value)? visible,
  }) {
    return visible?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MenuStateHidden value)? hidden,
    TResult Function(_MenuStateVisible value)? visible,
    required TResult orElse(),
  }) {
    if (visible != null) {
      return visible(this);
    }
    return orElse();
  }
}

abstract class _MenuStateVisible implements UserMenuState {
  const factory _MenuStateVisible() = _$_MenuStateVisible;
}

/// @nodoc
class _$UserProfileReactionTearOff {
  const _$UserProfileReactionTearOff();

  _ReactionShowSnackBar showSnackBar(String message) {
    return _ReactionShowSnackBar(
      message,
    );
  }

  _ReactionShowProfileOptions showProfileOptions() {
    return _ReactionShowProfileOptions();
  }

  _ReactionAskReportReasonDialog askReportReasonDialog(
      [String? reason = null]) {
    return _ReactionAskReportReasonDialog(
      reason,
    );
  }

  _ReactionShowBlockConfirmationDialog showBlockConfirmationDialog(
      String message) {
    return _ReactionShowBlockConfirmationDialog(
      message,
    );
  }

  _ReactionShowProgressDialog showProgressDialog() {
    return _ReactionShowProgressDialog();
  }

  _ReactionDismissProgressDialog dismissProgressDialog() {
    return _ReactionDismissProgressDialog();
  }
}

/// @nodoc
const $UserProfileReaction = _$UserProfileReactionTearOff();

/// @nodoc
mixin _$UserProfileReaction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) showSnackBar,
    required TResult Function() showProfileOptions,
    required TResult Function(String? reason) askReportReasonDialog,
    required TResult Function(String message) showBlockConfirmationDialog,
    required TResult Function() showProgressDialog,
    required TResult Function() dismissProgressDialog,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message)? showSnackBar,
    TResult Function()? showProfileOptions,
    TResult Function(String? reason)? askReportReasonDialog,
    TResult Function(String message)? showBlockConfirmationDialog,
    TResult Function()? showProgressDialog,
    TResult Function()? dismissProgressDialog,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? showSnackBar,
    TResult Function()? showProfileOptions,
    TResult Function(String? reason)? askReportReasonDialog,
    TResult Function(String message)? showBlockConfirmationDialog,
    TResult Function()? showProgressDialog,
    TResult Function()? dismissProgressDialog,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ReactionShowSnackBar value) showSnackBar,
    required TResult Function(_ReactionShowProfileOptions value)
        showProfileOptions,
    required TResult Function(_ReactionAskReportReasonDialog value)
        askReportReasonDialog,
    required TResult Function(_ReactionShowBlockConfirmationDialog value)
        showBlockConfirmationDialog,
    required TResult Function(_ReactionShowProgressDialog value)
        showProgressDialog,
    required TResult Function(_ReactionDismissProgressDialog value)
        dismissProgressDialog,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ReactionShowSnackBar value)? showSnackBar,
    TResult Function(_ReactionShowProfileOptions value)? showProfileOptions,
    TResult Function(_ReactionAskReportReasonDialog value)?
        askReportReasonDialog,
    TResult Function(_ReactionShowBlockConfirmationDialog value)?
        showBlockConfirmationDialog,
    TResult Function(_ReactionShowProgressDialog value)? showProgressDialog,
    TResult Function(_ReactionDismissProgressDialog value)?
        dismissProgressDialog,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ReactionShowSnackBar value)? showSnackBar,
    TResult Function(_ReactionShowProfileOptions value)? showProfileOptions,
    TResult Function(_ReactionAskReportReasonDialog value)?
        askReportReasonDialog,
    TResult Function(_ReactionShowBlockConfirmationDialog value)?
        showBlockConfirmationDialog,
    TResult Function(_ReactionShowProgressDialog value)? showProgressDialog,
    TResult Function(_ReactionDismissProgressDialog value)?
        dismissProgressDialog,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileReactionCopyWith<$Res> {
  factory $UserProfileReactionCopyWith(
          UserProfileReaction value, $Res Function(UserProfileReaction) then) =
      _$UserProfileReactionCopyWithImpl<$Res>;
}

/// @nodoc
class _$UserProfileReactionCopyWithImpl<$Res>
    implements $UserProfileReactionCopyWith<$Res> {
  _$UserProfileReactionCopyWithImpl(this._value, this._then);

  final UserProfileReaction _value;
  // ignore: unused_field
  final $Res Function(UserProfileReaction) _then;
}

/// @nodoc
abstract class _$ReactionShowSnackBarCopyWith<$Res> {
  factory _$ReactionShowSnackBarCopyWith(_ReactionShowSnackBar value,
          $Res Function(_ReactionShowSnackBar) then) =
      __$ReactionShowSnackBarCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$ReactionShowSnackBarCopyWithImpl<$Res>
    extends _$UserProfileReactionCopyWithImpl<$Res>
    implements _$ReactionShowSnackBarCopyWith<$Res> {
  __$ReactionShowSnackBarCopyWithImpl(
      _ReactionShowSnackBar _value, $Res Function(_ReactionShowSnackBar) _then)
      : super(_value, (v) => _then(v as _ReactionShowSnackBar));

  @override
  _ReactionShowSnackBar get _value => super._value as _ReactionShowSnackBar;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_ReactionShowSnackBar(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ReactionShowSnackBar implements _ReactionShowSnackBar {
  _$_ReactionShowSnackBar(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'UserProfileReaction.showSnackBar(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReactionShowSnackBar &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$ReactionShowSnackBarCopyWith<_ReactionShowSnackBar> get copyWith =>
      __$ReactionShowSnackBarCopyWithImpl<_ReactionShowSnackBar>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) showSnackBar,
    required TResult Function() showProfileOptions,
    required TResult Function(String? reason) askReportReasonDialog,
    required TResult Function(String message) showBlockConfirmationDialog,
    required TResult Function() showProgressDialog,
    required TResult Function() dismissProgressDialog,
  }) {
    return showSnackBar(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message)? showSnackBar,
    TResult Function()? showProfileOptions,
    TResult Function(String? reason)? askReportReasonDialog,
    TResult Function(String message)? showBlockConfirmationDialog,
    TResult Function()? showProgressDialog,
    TResult Function()? dismissProgressDialog,
  }) {
    return showSnackBar?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? showSnackBar,
    TResult Function()? showProfileOptions,
    TResult Function(String? reason)? askReportReasonDialog,
    TResult Function(String message)? showBlockConfirmationDialog,
    TResult Function()? showProgressDialog,
    TResult Function()? dismissProgressDialog,
    required TResult orElse(),
  }) {
    if (showSnackBar != null) {
      return showSnackBar(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ReactionShowSnackBar value) showSnackBar,
    required TResult Function(_ReactionShowProfileOptions value)
        showProfileOptions,
    required TResult Function(_ReactionAskReportReasonDialog value)
        askReportReasonDialog,
    required TResult Function(_ReactionShowBlockConfirmationDialog value)
        showBlockConfirmationDialog,
    required TResult Function(_ReactionShowProgressDialog value)
        showProgressDialog,
    required TResult Function(_ReactionDismissProgressDialog value)
        dismissProgressDialog,
  }) {
    return showSnackBar(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ReactionShowSnackBar value)? showSnackBar,
    TResult Function(_ReactionShowProfileOptions value)? showProfileOptions,
    TResult Function(_ReactionAskReportReasonDialog value)?
        askReportReasonDialog,
    TResult Function(_ReactionShowBlockConfirmationDialog value)?
        showBlockConfirmationDialog,
    TResult Function(_ReactionShowProgressDialog value)? showProgressDialog,
    TResult Function(_ReactionDismissProgressDialog value)?
        dismissProgressDialog,
  }) {
    return showSnackBar?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ReactionShowSnackBar value)? showSnackBar,
    TResult Function(_ReactionShowProfileOptions value)? showProfileOptions,
    TResult Function(_ReactionAskReportReasonDialog value)?
        askReportReasonDialog,
    TResult Function(_ReactionShowBlockConfirmationDialog value)?
        showBlockConfirmationDialog,
    TResult Function(_ReactionShowProgressDialog value)? showProgressDialog,
    TResult Function(_ReactionDismissProgressDialog value)?
        dismissProgressDialog,
    required TResult orElse(),
  }) {
    if (showSnackBar != null) {
      return showSnackBar(this);
    }
    return orElse();
  }
}

abstract class _ReactionShowSnackBar implements UserProfileReaction {
  factory _ReactionShowSnackBar(String message) = _$_ReactionShowSnackBar;

  String get message;
  @JsonKey(ignore: true)
  _$ReactionShowSnackBarCopyWith<_ReactionShowSnackBar> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ReactionShowProfileOptionsCopyWith<$Res> {
  factory _$ReactionShowProfileOptionsCopyWith(
          _ReactionShowProfileOptions value,
          $Res Function(_ReactionShowProfileOptions) then) =
      __$ReactionShowProfileOptionsCopyWithImpl<$Res>;
}

/// @nodoc
class __$ReactionShowProfileOptionsCopyWithImpl<$Res>
    extends _$UserProfileReactionCopyWithImpl<$Res>
    implements _$ReactionShowProfileOptionsCopyWith<$Res> {
  __$ReactionShowProfileOptionsCopyWithImpl(_ReactionShowProfileOptions _value,
      $Res Function(_ReactionShowProfileOptions) _then)
      : super(_value, (v) => _then(v as _ReactionShowProfileOptions));

  @override
  _ReactionShowProfileOptions get _value =>
      super._value as _ReactionShowProfileOptions;
}

/// @nodoc

class _$_ReactionShowProfileOptions implements _ReactionShowProfileOptions {
  _$_ReactionShowProfileOptions();

  @override
  String toString() {
    return 'UserProfileReaction.showProfileOptions()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReactionShowProfileOptions);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) showSnackBar,
    required TResult Function() showProfileOptions,
    required TResult Function(String? reason) askReportReasonDialog,
    required TResult Function(String message) showBlockConfirmationDialog,
    required TResult Function() showProgressDialog,
    required TResult Function() dismissProgressDialog,
  }) {
    return showProfileOptions();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message)? showSnackBar,
    TResult Function()? showProfileOptions,
    TResult Function(String? reason)? askReportReasonDialog,
    TResult Function(String message)? showBlockConfirmationDialog,
    TResult Function()? showProgressDialog,
    TResult Function()? dismissProgressDialog,
  }) {
    return showProfileOptions?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? showSnackBar,
    TResult Function()? showProfileOptions,
    TResult Function(String? reason)? askReportReasonDialog,
    TResult Function(String message)? showBlockConfirmationDialog,
    TResult Function()? showProgressDialog,
    TResult Function()? dismissProgressDialog,
    required TResult orElse(),
  }) {
    if (showProfileOptions != null) {
      return showProfileOptions();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ReactionShowSnackBar value) showSnackBar,
    required TResult Function(_ReactionShowProfileOptions value)
        showProfileOptions,
    required TResult Function(_ReactionAskReportReasonDialog value)
        askReportReasonDialog,
    required TResult Function(_ReactionShowBlockConfirmationDialog value)
        showBlockConfirmationDialog,
    required TResult Function(_ReactionShowProgressDialog value)
        showProgressDialog,
    required TResult Function(_ReactionDismissProgressDialog value)
        dismissProgressDialog,
  }) {
    return showProfileOptions(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ReactionShowSnackBar value)? showSnackBar,
    TResult Function(_ReactionShowProfileOptions value)? showProfileOptions,
    TResult Function(_ReactionAskReportReasonDialog value)?
        askReportReasonDialog,
    TResult Function(_ReactionShowBlockConfirmationDialog value)?
        showBlockConfirmationDialog,
    TResult Function(_ReactionShowProgressDialog value)? showProgressDialog,
    TResult Function(_ReactionDismissProgressDialog value)?
        dismissProgressDialog,
  }) {
    return showProfileOptions?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ReactionShowSnackBar value)? showSnackBar,
    TResult Function(_ReactionShowProfileOptions value)? showProfileOptions,
    TResult Function(_ReactionAskReportReasonDialog value)?
        askReportReasonDialog,
    TResult Function(_ReactionShowBlockConfirmationDialog value)?
        showBlockConfirmationDialog,
    TResult Function(_ReactionShowProgressDialog value)? showProgressDialog,
    TResult Function(_ReactionDismissProgressDialog value)?
        dismissProgressDialog,
    required TResult orElse(),
  }) {
    if (showProfileOptions != null) {
      return showProfileOptions(this);
    }
    return orElse();
  }
}

abstract class _ReactionShowProfileOptions implements UserProfileReaction {
  factory _ReactionShowProfileOptions() = _$_ReactionShowProfileOptions;
}

/// @nodoc
abstract class _$ReactionAskReportReasonDialogCopyWith<$Res> {
  factory _$ReactionAskReportReasonDialogCopyWith(
          _ReactionAskReportReasonDialog value,
          $Res Function(_ReactionAskReportReasonDialog) then) =
      __$ReactionAskReportReasonDialogCopyWithImpl<$Res>;
  $Res call({String? reason});
}

/// @nodoc
class __$ReactionAskReportReasonDialogCopyWithImpl<$Res>
    extends _$UserProfileReactionCopyWithImpl<$Res>
    implements _$ReactionAskReportReasonDialogCopyWith<$Res> {
  __$ReactionAskReportReasonDialogCopyWithImpl(
      _ReactionAskReportReasonDialog _value,
      $Res Function(_ReactionAskReportReasonDialog) _then)
      : super(_value, (v) => _then(v as _ReactionAskReportReasonDialog));

  @override
  _ReactionAskReportReasonDialog get _value =>
      super._value as _ReactionAskReportReasonDialog;

  @override
  $Res call({
    Object? reason = freezed,
  }) {
    return _then(_ReactionAskReportReasonDialog(
      reason == freezed
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_ReactionAskReportReasonDialog
    implements _ReactionAskReportReasonDialog {
  _$_ReactionAskReportReasonDialog([this.reason = null]);

  @JsonKey()
  @override
  final String? reason;

  @override
  String toString() {
    return 'UserProfileReaction.askReportReasonDialog(reason: $reason)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReactionAskReportReasonDialog &&
            const DeepCollectionEquality().equals(other.reason, reason));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(reason));

  @JsonKey(ignore: true)
  @override
  _$ReactionAskReportReasonDialogCopyWith<_ReactionAskReportReasonDialog>
      get copyWith => __$ReactionAskReportReasonDialogCopyWithImpl<
          _ReactionAskReportReasonDialog>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) showSnackBar,
    required TResult Function() showProfileOptions,
    required TResult Function(String? reason) askReportReasonDialog,
    required TResult Function(String message) showBlockConfirmationDialog,
    required TResult Function() showProgressDialog,
    required TResult Function() dismissProgressDialog,
  }) {
    return askReportReasonDialog(reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message)? showSnackBar,
    TResult Function()? showProfileOptions,
    TResult Function(String? reason)? askReportReasonDialog,
    TResult Function(String message)? showBlockConfirmationDialog,
    TResult Function()? showProgressDialog,
    TResult Function()? dismissProgressDialog,
  }) {
    return askReportReasonDialog?.call(reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? showSnackBar,
    TResult Function()? showProfileOptions,
    TResult Function(String? reason)? askReportReasonDialog,
    TResult Function(String message)? showBlockConfirmationDialog,
    TResult Function()? showProgressDialog,
    TResult Function()? dismissProgressDialog,
    required TResult orElse(),
  }) {
    if (askReportReasonDialog != null) {
      return askReportReasonDialog(reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ReactionShowSnackBar value) showSnackBar,
    required TResult Function(_ReactionShowProfileOptions value)
        showProfileOptions,
    required TResult Function(_ReactionAskReportReasonDialog value)
        askReportReasonDialog,
    required TResult Function(_ReactionShowBlockConfirmationDialog value)
        showBlockConfirmationDialog,
    required TResult Function(_ReactionShowProgressDialog value)
        showProgressDialog,
    required TResult Function(_ReactionDismissProgressDialog value)
        dismissProgressDialog,
  }) {
    return askReportReasonDialog(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ReactionShowSnackBar value)? showSnackBar,
    TResult Function(_ReactionShowProfileOptions value)? showProfileOptions,
    TResult Function(_ReactionAskReportReasonDialog value)?
        askReportReasonDialog,
    TResult Function(_ReactionShowBlockConfirmationDialog value)?
        showBlockConfirmationDialog,
    TResult Function(_ReactionShowProgressDialog value)? showProgressDialog,
    TResult Function(_ReactionDismissProgressDialog value)?
        dismissProgressDialog,
  }) {
    return askReportReasonDialog?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ReactionShowSnackBar value)? showSnackBar,
    TResult Function(_ReactionShowProfileOptions value)? showProfileOptions,
    TResult Function(_ReactionAskReportReasonDialog value)?
        askReportReasonDialog,
    TResult Function(_ReactionShowBlockConfirmationDialog value)?
        showBlockConfirmationDialog,
    TResult Function(_ReactionShowProgressDialog value)? showProgressDialog,
    TResult Function(_ReactionDismissProgressDialog value)?
        dismissProgressDialog,
    required TResult orElse(),
  }) {
    if (askReportReasonDialog != null) {
      return askReportReasonDialog(this);
    }
    return orElse();
  }
}

abstract class _ReactionAskReportReasonDialog implements UserProfileReaction {
  factory _ReactionAskReportReasonDialog([String? reason]) =
      _$_ReactionAskReportReasonDialog;

  String? get reason;
  @JsonKey(ignore: true)
  _$ReactionAskReportReasonDialogCopyWith<_ReactionAskReportReasonDialog>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ReactionShowBlockConfirmationDialogCopyWith<$Res> {
  factory _$ReactionShowBlockConfirmationDialogCopyWith(
          _ReactionShowBlockConfirmationDialog value,
          $Res Function(_ReactionShowBlockConfirmationDialog) then) =
      __$ReactionShowBlockConfirmationDialogCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$ReactionShowBlockConfirmationDialogCopyWithImpl<$Res>
    extends _$UserProfileReactionCopyWithImpl<$Res>
    implements _$ReactionShowBlockConfirmationDialogCopyWith<$Res> {
  __$ReactionShowBlockConfirmationDialogCopyWithImpl(
      _ReactionShowBlockConfirmationDialog _value,
      $Res Function(_ReactionShowBlockConfirmationDialog) _then)
      : super(_value, (v) => _then(v as _ReactionShowBlockConfirmationDialog));

  @override
  _ReactionShowBlockConfirmationDialog get _value =>
      super._value as _ReactionShowBlockConfirmationDialog;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_ReactionShowBlockConfirmationDialog(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ReactionShowBlockConfirmationDialog
    implements _ReactionShowBlockConfirmationDialog {
  _$_ReactionShowBlockConfirmationDialog(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'UserProfileReaction.showBlockConfirmationDialog(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReactionShowBlockConfirmationDialog &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$ReactionShowBlockConfirmationDialogCopyWith<
          _ReactionShowBlockConfirmationDialog>
      get copyWith => __$ReactionShowBlockConfirmationDialogCopyWithImpl<
          _ReactionShowBlockConfirmationDialog>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) showSnackBar,
    required TResult Function() showProfileOptions,
    required TResult Function(String? reason) askReportReasonDialog,
    required TResult Function(String message) showBlockConfirmationDialog,
    required TResult Function() showProgressDialog,
    required TResult Function() dismissProgressDialog,
  }) {
    return showBlockConfirmationDialog(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message)? showSnackBar,
    TResult Function()? showProfileOptions,
    TResult Function(String? reason)? askReportReasonDialog,
    TResult Function(String message)? showBlockConfirmationDialog,
    TResult Function()? showProgressDialog,
    TResult Function()? dismissProgressDialog,
  }) {
    return showBlockConfirmationDialog?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? showSnackBar,
    TResult Function()? showProfileOptions,
    TResult Function(String? reason)? askReportReasonDialog,
    TResult Function(String message)? showBlockConfirmationDialog,
    TResult Function()? showProgressDialog,
    TResult Function()? dismissProgressDialog,
    required TResult orElse(),
  }) {
    if (showBlockConfirmationDialog != null) {
      return showBlockConfirmationDialog(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ReactionShowSnackBar value) showSnackBar,
    required TResult Function(_ReactionShowProfileOptions value)
        showProfileOptions,
    required TResult Function(_ReactionAskReportReasonDialog value)
        askReportReasonDialog,
    required TResult Function(_ReactionShowBlockConfirmationDialog value)
        showBlockConfirmationDialog,
    required TResult Function(_ReactionShowProgressDialog value)
        showProgressDialog,
    required TResult Function(_ReactionDismissProgressDialog value)
        dismissProgressDialog,
  }) {
    return showBlockConfirmationDialog(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ReactionShowSnackBar value)? showSnackBar,
    TResult Function(_ReactionShowProfileOptions value)? showProfileOptions,
    TResult Function(_ReactionAskReportReasonDialog value)?
        askReportReasonDialog,
    TResult Function(_ReactionShowBlockConfirmationDialog value)?
        showBlockConfirmationDialog,
    TResult Function(_ReactionShowProgressDialog value)? showProgressDialog,
    TResult Function(_ReactionDismissProgressDialog value)?
        dismissProgressDialog,
  }) {
    return showBlockConfirmationDialog?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ReactionShowSnackBar value)? showSnackBar,
    TResult Function(_ReactionShowProfileOptions value)? showProfileOptions,
    TResult Function(_ReactionAskReportReasonDialog value)?
        askReportReasonDialog,
    TResult Function(_ReactionShowBlockConfirmationDialog value)?
        showBlockConfirmationDialog,
    TResult Function(_ReactionShowProgressDialog value)? showProgressDialog,
    TResult Function(_ReactionDismissProgressDialog value)?
        dismissProgressDialog,
    required TResult orElse(),
  }) {
    if (showBlockConfirmationDialog != null) {
      return showBlockConfirmationDialog(this);
    }
    return orElse();
  }
}

abstract class _ReactionShowBlockConfirmationDialog
    implements UserProfileReaction {
  factory _ReactionShowBlockConfirmationDialog(String message) =
      _$_ReactionShowBlockConfirmationDialog;

  String get message;
  @JsonKey(ignore: true)
  _$ReactionShowBlockConfirmationDialogCopyWith<
          _ReactionShowBlockConfirmationDialog>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ReactionShowProgressDialogCopyWith<$Res> {
  factory _$ReactionShowProgressDialogCopyWith(
          _ReactionShowProgressDialog value,
          $Res Function(_ReactionShowProgressDialog) then) =
      __$ReactionShowProgressDialogCopyWithImpl<$Res>;
}

/// @nodoc
class __$ReactionShowProgressDialogCopyWithImpl<$Res>
    extends _$UserProfileReactionCopyWithImpl<$Res>
    implements _$ReactionShowProgressDialogCopyWith<$Res> {
  __$ReactionShowProgressDialogCopyWithImpl(_ReactionShowProgressDialog _value,
      $Res Function(_ReactionShowProgressDialog) _then)
      : super(_value, (v) => _then(v as _ReactionShowProgressDialog));

  @override
  _ReactionShowProgressDialog get _value =>
      super._value as _ReactionShowProgressDialog;
}

/// @nodoc

class _$_ReactionShowProgressDialog implements _ReactionShowProgressDialog {
  _$_ReactionShowProgressDialog();

  @override
  String toString() {
    return 'UserProfileReaction.showProgressDialog()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReactionShowProgressDialog);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) showSnackBar,
    required TResult Function() showProfileOptions,
    required TResult Function(String? reason) askReportReasonDialog,
    required TResult Function(String message) showBlockConfirmationDialog,
    required TResult Function() showProgressDialog,
    required TResult Function() dismissProgressDialog,
  }) {
    return showProgressDialog();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message)? showSnackBar,
    TResult Function()? showProfileOptions,
    TResult Function(String? reason)? askReportReasonDialog,
    TResult Function(String message)? showBlockConfirmationDialog,
    TResult Function()? showProgressDialog,
    TResult Function()? dismissProgressDialog,
  }) {
    return showProgressDialog?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? showSnackBar,
    TResult Function()? showProfileOptions,
    TResult Function(String? reason)? askReportReasonDialog,
    TResult Function(String message)? showBlockConfirmationDialog,
    TResult Function()? showProgressDialog,
    TResult Function()? dismissProgressDialog,
    required TResult orElse(),
  }) {
    if (showProgressDialog != null) {
      return showProgressDialog();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ReactionShowSnackBar value) showSnackBar,
    required TResult Function(_ReactionShowProfileOptions value)
        showProfileOptions,
    required TResult Function(_ReactionAskReportReasonDialog value)
        askReportReasonDialog,
    required TResult Function(_ReactionShowBlockConfirmationDialog value)
        showBlockConfirmationDialog,
    required TResult Function(_ReactionShowProgressDialog value)
        showProgressDialog,
    required TResult Function(_ReactionDismissProgressDialog value)
        dismissProgressDialog,
  }) {
    return showProgressDialog(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ReactionShowSnackBar value)? showSnackBar,
    TResult Function(_ReactionShowProfileOptions value)? showProfileOptions,
    TResult Function(_ReactionAskReportReasonDialog value)?
        askReportReasonDialog,
    TResult Function(_ReactionShowBlockConfirmationDialog value)?
        showBlockConfirmationDialog,
    TResult Function(_ReactionShowProgressDialog value)? showProgressDialog,
    TResult Function(_ReactionDismissProgressDialog value)?
        dismissProgressDialog,
  }) {
    return showProgressDialog?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ReactionShowSnackBar value)? showSnackBar,
    TResult Function(_ReactionShowProfileOptions value)? showProfileOptions,
    TResult Function(_ReactionAskReportReasonDialog value)?
        askReportReasonDialog,
    TResult Function(_ReactionShowBlockConfirmationDialog value)?
        showBlockConfirmationDialog,
    TResult Function(_ReactionShowProgressDialog value)? showProgressDialog,
    TResult Function(_ReactionDismissProgressDialog value)?
        dismissProgressDialog,
    required TResult orElse(),
  }) {
    if (showProgressDialog != null) {
      return showProgressDialog(this);
    }
    return orElse();
  }
}

abstract class _ReactionShowProgressDialog implements UserProfileReaction {
  factory _ReactionShowProgressDialog() = _$_ReactionShowProgressDialog;
}

/// @nodoc
abstract class _$ReactionDismissProgressDialogCopyWith<$Res> {
  factory _$ReactionDismissProgressDialogCopyWith(
          _ReactionDismissProgressDialog value,
          $Res Function(_ReactionDismissProgressDialog) then) =
      __$ReactionDismissProgressDialogCopyWithImpl<$Res>;
}

/// @nodoc
class __$ReactionDismissProgressDialogCopyWithImpl<$Res>
    extends _$UserProfileReactionCopyWithImpl<$Res>
    implements _$ReactionDismissProgressDialogCopyWith<$Res> {
  __$ReactionDismissProgressDialogCopyWithImpl(
      _ReactionDismissProgressDialog _value,
      $Res Function(_ReactionDismissProgressDialog) _then)
      : super(_value, (v) => _then(v as _ReactionDismissProgressDialog));

  @override
  _ReactionDismissProgressDialog get _value =>
      super._value as _ReactionDismissProgressDialog;
}

/// @nodoc

class _$_ReactionDismissProgressDialog
    implements _ReactionDismissProgressDialog {
  _$_ReactionDismissProgressDialog();

  @override
  String toString() {
    return 'UserProfileReaction.dismissProgressDialog()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReactionDismissProgressDialog);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) showSnackBar,
    required TResult Function() showProfileOptions,
    required TResult Function(String? reason) askReportReasonDialog,
    required TResult Function(String message) showBlockConfirmationDialog,
    required TResult Function() showProgressDialog,
    required TResult Function() dismissProgressDialog,
  }) {
    return dismissProgressDialog();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message)? showSnackBar,
    TResult Function()? showProfileOptions,
    TResult Function(String? reason)? askReportReasonDialog,
    TResult Function(String message)? showBlockConfirmationDialog,
    TResult Function()? showProgressDialog,
    TResult Function()? dismissProgressDialog,
  }) {
    return dismissProgressDialog?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? showSnackBar,
    TResult Function()? showProfileOptions,
    TResult Function(String? reason)? askReportReasonDialog,
    TResult Function(String message)? showBlockConfirmationDialog,
    TResult Function()? showProgressDialog,
    TResult Function()? dismissProgressDialog,
    required TResult orElse(),
  }) {
    if (dismissProgressDialog != null) {
      return dismissProgressDialog();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ReactionShowSnackBar value) showSnackBar,
    required TResult Function(_ReactionShowProfileOptions value)
        showProfileOptions,
    required TResult Function(_ReactionAskReportReasonDialog value)
        askReportReasonDialog,
    required TResult Function(_ReactionShowBlockConfirmationDialog value)
        showBlockConfirmationDialog,
    required TResult Function(_ReactionShowProgressDialog value)
        showProgressDialog,
    required TResult Function(_ReactionDismissProgressDialog value)
        dismissProgressDialog,
  }) {
    return dismissProgressDialog(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ReactionShowSnackBar value)? showSnackBar,
    TResult Function(_ReactionShowProfileOptions value)? showProfileOptions,
    TResult Function(_ReactionAskReportReasonDialog value)?
        askReportReasonDialog,
    TResult Function(_ReactionShowBlockConfirmationDialog value)?
        showBlockConfirmationDialog,
    TResult Function(_ReactionShowProgressDialog value)? showProgressDialog,
    TResult Function(_ReactionDismissProgressDialog value)?
        dismissProgressDialog,
  }) {
    return dismissProgressDialog?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ReactionShowSnackBar value)? showSnackBar,
    TResult Function(_ReactionShowProfileOptions value)? showProfileOptions,
    TResult Function(_ReactionAskReportReasonDialog value)?
        askReportReasonDialog,
    TResult Function(_ReactionShowBlockConfirmationDialog value)?
        showBlockConfirmationDialog,
    TResult Function(_ReactionShowProgressDialog value)? showProgressDialog,
    TResult Function(_ReactionDismissProgressDialog value)?
        dismissProgressDialog,
    required TResult orElse(),
  }) {
    if (dismissProgressDialog != null) {
      return dismissProgressDialog(this);
    }
    return orElse();
  }
}

abstract class _ReactionDismissProgressDialog implements UserProfileReaction {
  factory _ReactionDismissProgressDialog() = _$_ReactionDismissProgressDialog;
}

/// @nodoc
class _$UserProfileSelectedOptionTearOff {
  const _$UserProfileSelectedOptionTearOff();

  _SelectedOptionReport report() {
    return _SelectedOptionReport();
  }

  _SelectedOptionBlock block() {
    return _SelectedOptionBlock();
  }
}

/// @nodoc
const $UserProfileSelectedOption = _$UserProfileSelectedOptionTearOff();

/// @nodoc
mixin _$UserProfileSelectedOption {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() report,
    required TResult Function() block,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? report,
    TResult Function()? block,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? report,
    TResult Function()? block,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SelectedOptionReport value) report,
    required TResult Function(_SelectedOptionBlock value) block,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_SelectedOptionReport value)? report,
    TResult Function(_SelectedOptionBlock value)? block,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SelectedOptionReport value)? report,
    TResult Function(_SelectedOptionBlock value)? block,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileSelectedOptionCopyWith<$Res> {
  factory $UserProfileSelectedOptionCopyWith(UserProfileSelectedOption value,
          $Res Function(UserProfileSelectedOption) then) =
      _$UserProfileSelectedOptionCopyWithImpl<$Res>;
}

/// @nodoc
class _$UserProfileSelectedOptionCopyWithImpl<$Res>
    implements $UserProfileSelectedOptionCopyWith<$Res> {
  _$UserProfileSelectedOptionCopyWithImpl(this._value, this._then);

  final UserProfileSelectedOption _value;
  // ignore: unused_field
  final $Res Function(UserProfileSelectedOption) _then;
}

/// @nodoc
abstract class _$SelectedOptionReportCopyWith<$Res> {
  factory _$SelectedOptionReportCopyWith(_SelectedOptionReport value,
          $Res Function(_SelectedOptionReport) then) =
      __$SelectedOptionReportCopyWithImpl<$Res>;
}

/// @nodoc
class __$SelectedOptionReportCopyWithImpl<$Res>
    extends _$UserProfileSelectedOptionCopyWithImpl<$Res>
    implements _$SelectedOptionReportCopyWith<$Res> {
  __$SelectedOptionReportCopyWithImpl(
      _SelectedOptionReport _value, $Res Function(_SelectedOptionReport) _then)
      : super(_value, (v) => _then(v as _SelectedOptionReport));

  @override
  _SelectedOptionReport get _value => super._value as _SelectedOptionReport;
}

/// @nodoc

class _$_SelectedOptionReport implements _SelectedOptionReport {
  _$_SelectedOptionReport();

  @override
  String toString() {
    return 'UserProfileSelectedOption.report()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _SelectedOptionReport);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() report,
    required TResult Function() block,
  }) {
    return report();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? report,
    TResult Function()? block,
  }) {
    return report?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? report,
    TResult Function()? block,
    required TResult orElse(),
  }) {
    if (report != null) {
      return report();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SelectedOptionReport value) report,
    required TResult Function(_SelectedOptionBlock value) block,
  }) {
    return report(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_SelectedOptionReport value)? report,
    TResult Function(_SelectedOptionBlock value)? block,
  }) {
    return report?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SelectedOptionReport value)? report,
    TResult Function(_SelectedOptionBlock value)? block,
    required TResult orElse(),
  }) {
    if (report != null) {
      return report(this);
    }
    return orElse();
  }
}

abstract class _SelectedOptionReport implements UserProfileSelectedOption {
  factory _SelectedOptionReport() = _$_SelectedOptionReport;
}

/// @nodoc
abstract class _$SelectedOptionBlockCopyWith<$Res> {
  factory _$SelectedOptionBlockCopyWith(_SelectedOptionBlock value,
          $Res Function(_SelectedOptionBlock) then) =
      __$SelectedOptionBlockCopyWithImpl<$Res>;
}

/// @nodoc
class __$SelectedOptionBlockCopyWithImpl<$Res>
    extends _$UserProfileSelectedOptionCopyWithImpl<$Res>
    implements _$SelectedOptionBlockCopyWith<$Res> {
  __$SelectedOptionBlockCopyWithImpl(
      _SelectedOptionBlock _value, $Res Function(_SelectedOptionBlock) _then)
      : super(_value, (v) => _then(v as _SelectedOptionBlock));

  @override
  _SelectedOptionBlock get _value => super._value as _SelectedOptionBlock;
}

/// @nodoc

class _$_SelectedOptionBlock implements _SelectedOptionBlock {
  _$_SelectedOptionBlock();

  @override
  String toString() {
    return 'UserProfileSelectedOption.block()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _SelectedOptionBlock);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() report,
    required TResult Function() block,
  }) {
    return block();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? report,
    TResult Function()? block,
  }) {
    return block?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? report,
    TResult Function()? block,
    required TResult orElse(),
  }) {
    if (block != null) {
      return block();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SelectedOptionReport value) report,
    required TResult Function(_SelectedOptionBlock value) block,
  }) {
    return block(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_SelectedOptionReport value)? report,
    TResult Function(_SelectedOptionBlock value)? block,
  }) {
    return block?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SelectedOptionReport value)? report,
    TResult Function(_SelectedOptionBlock value)? block,
    required TResult orElse(),
  }) {
    if (block != null) {
      return block(this);
    }
    return orElse();
  }
}

abstract class _SelectedOptionBlock implements UserProfileSelectedOption {
  factory _SelectedOptionBlock() = _$_SelectedOptionBlock;
}
