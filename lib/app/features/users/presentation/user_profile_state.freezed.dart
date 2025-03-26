// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
    TResult? Function()? initial,
    TResult? Function(UserDetailEntity person)? loaded,
    TResult? Function(String message)? error,
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
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ErrorDetails value)? error,
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
      _$UserProfileStateCopyWithImpl<$Res, UserProfileState>;
}

/// @nodoc
class _$UserProfileStateCopyWithImpl<$Res, $Val extends UserProfileState>
    implements $UserProfileStateCopyWith<$Res> {
  _$UserProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$UserProfileStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'UserProfileState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
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
    TResult? Function()? initial,
    TResult? Function(UserDetailEntity person)? loaded,
    TResult? Function(String message)? error,
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
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ErrorDetails value)? error,
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
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserDetailEntity person});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$UserProfileStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? person = null,
  }) {
    return _then(_$LoadedImpl(
      null == person
          ? _value.person
          : person // ignore: cast_nullable_to_non_nullable
              as UserDetailEntity,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(this.person);

  @override
  final UserDetailEntity person;

  @override
  String toString() {
    return 'UserProfileState.loaded(person: $person)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.person, person) || other.person == person));
  }

  @override
  int get hashCode => Object.hash(runtimeType, person);

  /// Create a copy of UserProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

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
    TResult? Function()? initial,
    TResult? Function(UserDetailEntity person)? loaded,
    TResult? Function(String message)? error,
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
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ErrorDetails value)? error,
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
  const factory _Loaded(final UserDetailEntity person) = _$LoadedImpl;

  UserDetailEntity get person;

  /// Create a copy of UserProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorDetailsImplCopyWith<$Res> {
  factory _$$ErrorDetailsImplCopyWith(
          _$ErrorDetailsImpl value, $Res Function(_$ErrorDetailsImpl) then) =
      __$$ErrorDetailsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorDetailsImplCopyWithImpl<$Res>
    extends _$UserProfileStateCopyWithImpl<$Res, _$ErrorDetailsImpl>
    implements _$$ErrorDetailsImplCopyWith<$Res> {
  __$$ErrorDetailsImplCopyWithImpl(
      _$ErrorDetailsImpl _value, $Res Function(_$ErrorDetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorDetailsImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorDetailsImpl implements _ErrorDetails {
  const _$ErrorDetailsImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'UserProfileState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorDetailsImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of UserProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorDetailsImplCopyWith<_$ErrorDetailsImpl> get copyWith =>
      __$$ErrorDetailsImplCopyWithImpl<_$ErrorDetailsImpl>(this, _$identity);

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
    TResult? Function()? initial,
    TResult? Function(UserDetailEntity person)? loaded,
    TResult? Function(String message)? error,
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
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ErrorDetails value)? error,
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
  const factory _ErrorDetails(final String message) = _$ErrorDetailsImpl;

  String get message;

  /// Create a copy of UserProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorDetailsImplCopyWith<_$ErrorDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

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
    TResult? Function()? hidden,
    TResult? Function()? visible,
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
    TResult? Function(_MenuStateHidden value)? hidden,
    TResult? Function(_MenuStateVisible value)? visible,
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
      _$UserMenuStateCopyWithImpl<$Res, UserMenuState>;
}

/// @nodoc
class _$UserMenuStateCopyWithImpl<$Res, $Val extends UserMenuState>
    implements $UserMenuStateCopyWith<$Res> {
  _$UserMenuStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserMenuState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$MenuStateHiddenImplCopyWith<$Res> {
  factory _$$MenuStateHiddenImplCopyWith(_$MenuStateHiddenImpl value,
          $Res Function(_$MenuStateHiddenImpl) then) =
      __$$MenuStateHiddenImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MenuStateHiddenImplCopyWithImpl<$Res>
    extends _$UserMenuStateCopyWithImpl<$Res, _$MenuStateHiddenImpl>
    implements _$$MenuStateHiddenImplCopyWith<$Res> {
  __$$MenuStateHiddenImplCopyWithImpl(
      _$MenuStateHiddenImpl _value, $Res Function(_$MenuStateHiddenImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserMenuState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MenuStateHiddenImpl implements _MenuStateHidden {
  const _$MenuStateHiddenImpl();

  @override
  String toString() {
    return 'UserMenuState.hidden()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MenuStateHiddenImpl);
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
    TResult? Function()? hidden,
    TResult? Function()? visible,
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
    TResult? Function(_MenuStateHidden value)? hidden,
    TResult? Function(_MenuStateVisible value)? visible,
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
  const factory _MenuStateHidden() = _$MenuStateHiddenImpl;
}

/// @nodoc
abstract class _$$MenuStateVisibleImplCopyWith<$Res> {
  factory _$$MenuStateVisibleImplCopyWith(_$MenuStateVisibleImpl value,
          $Res Function(_$MenuStateVisibleImpl) then) =
      __$$MenuStateVisibleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MenuStateVisibleImplCopyWithImpl<$Res>
    extends _$UserMenuStateCopyWithImpl<$Res, _$MenuStateVisibleImpl>
    implements _$$MenuStateVisibleImplCopyWith<$Res> {
  __$$MenuStateVisibleImplCopyWithImpl(_$MenuStateVisibleImpl _value,
      $Res Function(_$MenuStateVisibleImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserMenuState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MenuStateVisibleImpl implements _MenuStateVisible {
  const _$MenuStateVisibleImpl();

  @override
  String toString() {
    return 'UserMenuState.visible()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MenuStateVisibleImpl);
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
    TResult? Function()? hidden,
    TResult? Function()? visible,
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
    TResult? Function(_MenuStateHidden value)? hidden,
    TResult? Function(_MenuStateVisible value)? visible,
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
  const factory _MenuStateVisible() = _$MenuStateVisibleImpl;
}

/// @nodoc
mixin _$UserProfileReaction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool inMainboardPage)
        showSnackBar,
    required TResult Function() showProfileOptions,
    required TResult Function(String? reason) askReportReasonDialog,
    required TResult Function(String message) showBlockConfirmationDialog,
    required TResult Function() showProgressDialog,
    required TResult Function() dismissProgressDialog,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, bool inMainboardPage)? showSnackBar,
    TResult? Function()? showProfileOptions,
    TResult? Function(String? reason)? askReportReasonDialog,
    TResult? Function(String message)? showBlockConfirmationDialog,
    TResult? Function()? showProgressDialog,
    TResult? Function()? dismissProgressDialog,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool inMainboardPage)? showSnackBar,
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
    TResult? Function(_ReactionShowSnackBar value)? showSnackBar,
    TResult? Function(_ReactionShowProfileOptions value)? showProfileOptions,
    TResult? Function(_ReactionAskReportReasonDialog value)?
        askReportReasonDialog,
    TResult? Function(_ReactionShowBlockConfirmationDialog value)?
        showBlockConfirmationDialog,
    TResult? Function(_ReactionShowProgressDialog value)? showProgressDialog,
    TResult? Function(_ReactionDismissProgressDialog value)?
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
      _$UserProfileReactionCopyWithImpl<$Res, UserProfileReaction>;
}

/// @nodoc
class _$UserProfileReactionCopyWithImpl<$Res, $Val extends UserProfileReaction>
    implements $UserProfileReactionCopyWith<$Res> {
  _$UserProfileReactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfileReaction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ReactionShowSnackBarImplCopyWith<$Res> {
  factory _$$ReactionShowSnackBarImplCopyWith(_$ReactionShowSnackBarImpl value,
          $Res Function(_$ReactionShowSnackBarImpl) then) =
      __$$ReactionShowSnackBarImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, bool inMainboardPage});
}

/// @nodoc
class __$$ReactionShowSnackBarImplCopyWithImpl<$Res>
    extends _$UserProfileReactionCopyWithImpl<$Res, _$ReactionShowSnackBarImpl>
    implements _$$ReactionShowSnackBarImplCopyWith<$Res> {
  __$$ReactionShowSnackBarImplCopyWithImpl(_$ReactionShowSnackBarImpl _value,
      $Res Function(_$ReactionShowSnackBarImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfileReaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? inMainboardPage = null,
  }) {
    return _then(_$ReactionShowSnackBarImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      inMainboardPage: null == inMainboardPage
          ? _value.inMainboardPage
          : inMainboardPage // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ReactionShowSnackBarImpl implements _ReactionShowSnackBar {
  _$ReactionShowSnackBarImpl(this.message, {this.inMainboardPage = false});

  @override
  final String message;
  @override
  @JsonKey()
  final bool inMainboardPage;

  @override
  String toString() {
    return 'UserProfileReaction.showSnackBar(message: $message, inMainboardPage: $inMainboardPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReactionShowSnackBarImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.inMainboardPage, inMainboardPage) ||
                other.inMainboardPage == inMainboardPage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, inMainboardPage);

  /// Create a copy of UserProfileReaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReactionShowSnackBarImplCopyWith<_$ReactionShowSnackBarImpl>
      get copyWith =>
          __$$ReactionShowSnackBarImplCopyWithImpl<_$ReactionShowSnackBarImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool inMainboardPage)
        showSnackBar,
    required TResult Function() showProfileOptions,
    required TResult Function(String? reason) askReportReasonDialog,
    required TResult Function(String message) showBlockConfirmationDialog,
    required TResult Function() showProgressDialog,
    required TResult Function() dismissProgressDialog,
  }) {
    return showSnackBar(message, inMainboardPage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, bool inMainboardPage)? showSnackBar,
    TResult? Function()? showProfileOptions,
    TResult? Function(String? reason)? askReportReasonDialog,
    TResult? Function(String message)? showBlockConfirmationDialog,
    TResult? Function()? showProgressDialog,
    TResult? Function()? dismissProgressDialog,
  }) {
    return showSnackBar?.call(message, inMainboardPage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool inMainboardPage)? showSnackBar,
    TResult Function()? showProfileOptions,
    TResult Function(String? reason)? askReportReasonDialog,
    TResult Function(String message)? showBlockConfirmationDialog,
    TResult Function()? showProgressDialog,
    TResult Function()? dismissProgressDialog,
    required TResult orElse(),
  }) {
    if (showSnackBar != null) {
      return showSnackBar(message, inMainboardPage);
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
    TResult? Function(_ReactionShowSnackBar value)? showSnackBar,
    TResult? Function(_ReactionShowProfileOptions value)? showProfileOptions,
    TResult? Function(_ReactionAskReportReasonDialog value)?
        askReportReasonDialog,
    TResult? Function(_ReactionShowBlockConfirmationDialog value)?
        showBlockConfirmationDialog,
    TResult? Function(_ReactionShowProgressDialog value)? showProgressDialog,
    TResult? Function(_ReactionDismissProgressDialog value)?
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
  factory _ReactionShowSnackBar(final String message,
      {final bool inMainboardPage}) = _$ReactionShowSnackBarImpl;

  String get message;
  bool get inMainboardPage;

  /// Create a copy of UserProfileReaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReactionShowSnackBarImplCopyWith<_$ReactionShowSnackBarImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReactionShowProfileOptionsImplCopyWith<$Res> {
  factory _$$ReactionShowProfileOptionsImplCopyWith(
          _$ReactionShowProfileOptionsImpl value,
          $Res Function(_$ReactionShowProfileOptionsImpl) then) =
      __$$ReactionShowProfileOptionsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ReactionShowProfileOptionsImplCopyWithImpl<$Res>
    extends _$UserProfileReactionCopyWithImpl<$Res,
        _$ReactionShowProfileOptionsImpl>
    implements _$$ReactionShowProfileOptionsImplCopyWith<$Res> {
  __$$ReactionShowProfileOptionsImplCopyWithImpl(
      _$ReactionShowProfileOptionsImpl _value,
      $Res Function(_$ReactionShowProfileOptionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfileReaction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ReactionShowProfileOptionsImpl implements _ReactionShowProfileOptions {
  _$ReactionShowProfileOptionsImpl();

  @override
  String toString() {
    return 'UserProfileReaction.showProfileOptions()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReactionShowProfileOptionsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool inMainboardPage)
        showSnackBar,
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
    TResult? Function(String message, bool inMainboardPage)? showSnackBar,
    TResult? Function()? showProfileOptions,
    TResult? Function(String? reason)? askReportReasonDialog,
    TResult? Function(String message)? showBlockConfirmationDialog,
    TResult? Function()? showProgressDialog,
    TResult? Function()? dismissProgressDialog,
  }) {
    return showProfileOptions?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool inMainboardPage)? showSnackBar,
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
    TResult? Function(_ReactionShowSnackBar value)? showSnackBar,
    TResult? Function(_ReactionShowProfileOptions value)? showProfileOptions,
    TResult? Function(_ReactionAskReportReasonDialog value)?
        askReportReasonDialog,
    TResult? Function(_ReactionShowBlockConfirmationDialog value)?
        showBlockConfirmationDialog,
    TResult? Function(_ReactionShowProgressDialog value)? showProgressDialog,
    TResult? Function(_ReactionDismissProgressDialog value)?
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
  factory _ReactionShowProfileOptions() = _$ReactionShowProfileOptionsImpl;
}

/// @nodoc
abstract class _$$ReactionAskReportReasonDialogImplCopyWith<$Res> {
  factory _$$ReactionAskReportReasonDialogImplCopyWith(
          _$ReactionAskReportReasonDialogImpl value,
          $Res Function(_$ReactionAskReportReasonDialogImpl) then) =
      __$$ReactionAskReportReasonDialogImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? reason});
}

/// @nodoc
class __$$ReactionAskReportReasonDialogImplCopyWithImpl<$Res>
    extends _$UserProfileReactionCopyWithImpl<$Res,
        _$ReactionAskReportReasonDialogImpl>
    implements _$$ReactionAskReportReasonDialogImplCopyWith<$Res> {
  __$$ReactionAskReportReasonDialogImplCopyWithImpl(
      _$ReactionAskReportReasonDialogImpl _value,
      $Res Function(_$ReactionAskReportReasonDialogImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfileReaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reason = freezed,
  }) {
    return _then(_$ReactionAskReportReasonDialogImpl(
      freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ReactionAskReportReasonDialogImpl
    implements _ReactionAskReportReasonDialog {
  _$ReactionAskReportReasonDialogImpl([this.reason = null]);

  @override
  @JsonKey()
  final String? reason;

  @override
  String toString() {
    return 'UserProfileReaction.askReportReasonDialog(reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReactionAskReportReasonDialogImpl &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reason);

  /// Create a copy of UserProfileReaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReactionAskReportReasonDialogImplCopyWith<
          _$ReactionAskReportReasonDialogImpl>
      get copyWith => __$$ReactionAskReportReasonDialogImplCopyWithImpl<
          _$ReactionAskReportReasonDialogImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool inMainboardPage)
        showSnackBar,
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
    TResult? Function(String message, bool inMainboardPage)? showSnackBar,
    TResult? Function()? showProfileOptions,
    TResult? Function(String? reason)? askReportReasonDialog,
    TResult? Function(String message)? showBlockConfirmationDialog,
    TResult? Function()? showProgressDialog,
    TResult? Function()? dismissProgressDialog,
  }) {
    return askReportReasonDialog?.call(reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool inMainboardPage)? showSnackBar,
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
    TResult? Function(_ReactionShowSnackBar value)? showSnackBar,
    TResult? Function(_ReactionShowProfileOptions value)? showProfileOptions,
    TResult? Function(_ReactionAskReportReasonDialog value)?
        askReportReasonDialog,
    TResult? Function(_ReactionShowBlockConfirmationDialog value)?
        showBlockConfirmationDialog,
    TResult? Function(_ReactionShowProgressDialog value)? showProgressDialog,
    TResult? Function(_ReactionDismissProgressDialog value)?
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
  factory _ReactionAskReportReasonDialog([final String? reason]) =
      _$ReactionAskReportReasonDialogImpl;

  String? get reason;

  /// Create a copy of UserProfileReaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReactionAskReportReasonDialogImplCopyWith<
          _$ReactionAskReportReasonDialogImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReactionShowBlockConfirmationDialogImplCopyWith<$Res> {
  factory _$$ReactionShowBlockConfirmationDialogImplCopyWith(
          _$ReactionShowBlockConfirmationDialogImpl value,
          $Res Function(_$ReactionShowBlockConfirmationDialogImpl) then) =
      __$$ReactionShowBlockConfirmationDialogImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ReactionShowBlockConfirmationDialogImplCopyWithImpl<$Res>
    extends _$UserProfileReactionCopyWithImpl<$Res,
        _$ReactionShowBlockConfirmationDialogImpl>
    implements _$$ReactionShowBlockConfirmationDialogImplCopyWith<$Res> {
  __$$ReactionShowBlockConfirmationDialogImplCopyWithImpl(
      _$ReactionShowBlockConfirmationDialogImpl _value,
      $Res Function(_$ReactionShowBlockConfirmationDialogImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfileReaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ReactionShowBlockConfirmationDialogImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ReactionShowBlockConfirmationDialogImpl
    implements _ReactionShowBlockConfirmationDialog {
  _$ReactionShowBlockConfirmationDialogImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'UserProfileReaction.showBlockConfirmationDialog(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReactionShowBlockConfirmationDialogImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of UserProfileReaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReactionShowBlockConfirmationDialogImplCopyWith<
          _$ReactionShowBlockConfirmationDialogImpl>
      get copyWith => __$$ReactionShowBlockConfirmationDialogImplCopyWithImpl<
          _$ReactionShowBlockConfirmationDialogImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool inMainboardPage)
        showSnackBar,
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
    TResult? Function(String message, bool inMainboardPage)? showSnackBar,
    TResult? Function()? showProfileOptions,
    TResult? Function(String? reason)? askReportReasonDialog,
    TResult? Function(String message)? showBlockConfirmationDialog,
    TResult? Function()? showProgressDialog,
    TResult? Function()? dismissProgressDialog,
  }) {
    return showBlockConfirmationDialog?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool inMainboardPage)? showSnackBar,
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
    TResult? Function(_ReactionShowSnackBar value)? showSnackBar,
    TResult? Function(_ReactionShowProfileOptions value)? showProfileOptions,
    TResult? Function(_ReactionAskReportReasonDialog value)?
        askReportReasonDialog,
    TResult? Function(_ReactionShowBlockConfirmationDialog value)?
        showBlockConfirmationDialog,
    TResult? Function(_ReactionShowProgressDialog value)? showProgressDialog,
    TResult? Function(_ReactionDismissProgressDialog value)?
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
  factory _ReactionShowBlockConfirmationDialog(final String message) =
      _$ReactionShowBlockConfirmationDialogImpl;

  String get message;

  /// Create a copy of UserProfileReaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReactionShowBlockConfirmationDialogImplCopyWith<
          _$ReactionShowBlockConfirmationDialogImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReactionShowProgressDialogImplCopyWith<$Res> {
  factory _$$ReactionShowProgressDialogImplCopyWith(
          _$ReactionShowProgressDialogImpl value,
          $Res Function(_$ReactionShowProgressDialogImpl) then) =
      __$$ReactionShowProgressDialogImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ReactionShowProgressDialogImplCopyWithImpl<$Res>
    extends _$UserProfileReactionCopyWithImpl<$Res,
        _$ReactionShowProgressDialogImpl>
    implements _$$ReactionShowProgressDialogImplCopyWith<$Res> {
  __$$ReactionShowProgressDialogImplCopyWithImpl(
      _$ReactionShowProgressDialogImpl _value,
      $Res Function(_$ReactionShowProgressDialogImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfileReaction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ReactionShowProgressDialogImpl implements _ReactionShowProgressDialog {
  _$ReactionShowProgressDialogImpl();

  @override
  String toString() {
    return 'UserProfileReaction.showProgressDialog()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReactionShowProgressDialogImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool inMainboardPage)
        showSnackBar,
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
    TResult? Function(String message, bool inMainboardPage)? showSnackBar,
    TResult? Function()? showProfileOptions,
    TResult? Function(String? reason)? askReportReasonDialog,
    TResult? Function(String message)? showBlockConfirmationDialog,
    TResult? Function()? showProgressDialog,
    TResult? Function()? dismissProgressDialog,
  }) {
    return showProgressDialog?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool inMainboardPage)? showSnackBar,
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
    TResult? Function(_ReactionShowSnackBar value)? showSnackBar,
    TResult? Function(_ReactionShowProfileOptions value)? showProfileOptions,
    TResult? Function(_ReactionAskReportReasonDialog value)?
        askReportReasonDialog,
    TResult? Function(_ReactionShowBlockConfirmationDialog value)?
        showBlockConfirmationDialog,
    TResult? Function(_ReactionShowProgressDialog value)? showProgressDialog,
    TResult? Function(_ReactionDismissProgressDialog value)?
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
  factory _ReactionShowProgressDialog() = _$ReactionShowProgressDialogImpl;
}

/// @nodoc
abstract class _$$ReactionDismissProgressDialogImplCopyWith<$Res> {
  factory _$$ReactionDismissProgressDialogImplCopyWith(
          _$ReactionDismissProgressDialogImpl value,
          $Res Function(_$ReactionDismissProgressDialogImpl) then) =
      __$$ReactionDismissProgressDialogImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ReactionDismissProgressDialogImplCopyWithImpl<$Res>
    extends _$UserProfileReactionCopyWithImpl<$Res,
        _$ReactionDismissProgressDialogImpl>
    implements _$$ReactionDismissProgressDialogImplCopyWith<$Res> {
  __$$ReactionDismissProgressDialogImplCopyWithImpl(
      _$ReactionDismissProgressDialogImpl _value,
      $Res Function(_$ReactionDismissProgressDialogImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfileReaction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ReactionDismissProgressDialogImpl
    implements _ReactionDismissProgressDialog {
  _$ReactionDismissProgressDialogImpl();

  @override
  String toString() {
    return 'UserProfileReaction.dismissProgressDialog()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReactionDismissProgressDialogImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool inMainboardPage)
        showSnackBar,
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
    TResult? Function(String message, bool inMainboardPage)? showSnackBar,
    TResult? Function()? showProfileOptions,
    TResult? Function(String? reason)? askReportReasonDialog,
    TResult? Function(String message)? showBlockConfirmationDialog,
    TResult? Function()? showProgressDialog,
    TResult? Function()? dismissProgressDialog,
  }) {
    return dismissProgressDialog?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool inMainboardPage)? showSnackBar,
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
    TResult? Function(_ReactionShowSnackBar value)? showSnackBar,
    TResult? Function(_ReactionShowProfileOptions value)? showProfileOptions,
    TResult? Function(_ReactionAskReportReasonDialog value)?
        askReportReasonDialog,
    TResult? Function(_ReactionShowBlockConfirmationDialog value)?
        showBlockConfirmationDialog,
    TResult? Function(_ReactionShowProgressDialog value)? showProgressDialog,
    TResult? Function(_ReactionDismissProgressDialog value)?
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
  factory _ReactionDismissProgressDialog() =
      _$ReactionDismissProgressDialogImpl;
}

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
    TResult? Function()? report,
    TResult? Function()? block,
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
    TResult? Function(_SelectedOptionReport value)? report,
    TResult? Function(_SelectedOptionBlock value)? block,
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
      _$UserProfileSelectedOptionCopyWithImpl<$Res, UserProfileSelectedOption>;
}

/// @nodoc
class _$UserProfileSelectedOptionCopyWithImpl<$Res,
        $Val extends UserProfileSelectedOption>
    implements $UserProfileSelectedOptionCopyWith<$Res> {
  _$UserProfileSelectedOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfileSelectedOption
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SelectedOptionReportImplCopyWith<$Res> {
  factory _$$SelectedOptionReportImplCopyWith(_$SelectedOptionReportImpl value,
          $Res Function(_$SelectedOptionReportImpl) then) =
      __$$SelectedOptionReportImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SelectedOptionReportImplCopyWithImpl<$Res>
    extends _$UserProfileSelectedOptionCopyWithImpl<$Res,
        _$SelectedOptionReportImpl>
    implements _$$SelectedOptionReportImplCopyWith<$Res> {
  __$$SelectedOptionReportImplCopyWithImpl(_$SelectedOptionReportImpl _value,
      $Res Function(_$SelectedOptionReportImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfileSelectedOption
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SelectedOptionReportImpl implements _SelectedOptionReport {
  _$SelectedOptionReportImpl();

  @override
  String toString() {
    return 'UserProfileSelectedOption.report()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectedOptionReportImpl);
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
    TResult? Function()? report,
    TResult? Function()? block,
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
    TResult? Function(_SelectedOptionReport value)? report,
    TResult? Function(_SelectedOptionBlock value)? block,
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
  factory _SelectedOptionReport() = _$SelectedOptionReportImpl;
}

/// @nodoc
abstract class _$$SelectedOptionBlockImplCopyWith<$Res> {
  factory _$$SelectedOptionBlockImplCopyWith(_$SelectedOptionBlockImpl value,
          $Res Function(_$SelectedOptionBlockImpl) then) =
      __$$SelectedOptionBlockImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SelectedOptionBlockImplCopyWithImpl<$Res>
    extends _$UserProfileSelectedOptionCopyWithImpl<$Res,
        _$SelectedOptionBlockImpl>
    implements _$$SelectedOptionBlockImplCopyWith<$Res> {
  __$$SelectedOptionBlockImplCopyWithImpl(_$SelectedOptionBlockImpl _value,
      $Res Function(_$SelectedOptionBlockImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfileSelectedOption
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SelectedOptionBlockImpl implements _SelectedOptionBlock {
  _$SelectedOptionBlockImpl();

  @override
  String toString() {
    return 'UserProfileSelectedOption.block()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectedOptionBlockImpl);
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
    TResult? Function()? report,
    TResult? Function()? block,
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
    TResult? Function(_SelectedOptionReport value)? report,
    TResult? Function(_SelectedOptionBlock value)? block,
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
  factory _SelectedOptionBlock() = _$SelectedOptionBlockImpl;
}
