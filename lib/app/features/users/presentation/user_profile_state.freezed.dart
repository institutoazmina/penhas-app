// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$_InitialCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$UserProfileStateCopyWithImpl<$Res>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, (v) => _then(v as _$_Initial));

  @override
  _$_Initial get _value => super._value as _$_Initial;
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
        (other.runtimeType == runtimeType && other is _$_Initial);
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
abstract class _$$_LoadedCopyWith<$Res> {
  factory _$$_LoadedCopyWith(_$_Loaded value, $Res Function(_$_Loaded) then) =
      __$$_LoadedCopyWithImpl<$Res>;
  $Res call({UserDetailEntity person});
}

/// @nodoc
class __$$_LoadedCopyWithImpl<$Res> extends _$UserProfileStateCopyWithImpl<$Res>
    implements _$$_LoadedCopyWith<$Res> {
  __$$_LoadedCopyWithImpl(_$_Loaded _value, $Res Function(_$_Loaded) _then)
      : super(_value, (v) => _then(v as _$_Loaded));

  @override
  _$_Loaded get _value => super._value as _$_Loaded;

  @override
  $Res call({
    Object? person = freezed,
  }) {
    return _then(_$_Loaded(
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
            other is _$_Loaded &&
            const DeepCollectionEquality().equals(other.person, person));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(person));

  @JsonKey(ignore: true)
  @override
  _$$_LoadedCopyWith<_$_Loaded> get copyWith =>
      __$$_LoadedCopyWithImpl<_$_Loaded>(this, _$identity);

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
  const factory _Loaded(final UserDetailEntity person) = _$_Loaded;

  UserDetailEntity get person;
  @JsonKey(ignore: true)
  _$$_LoadedCopyWith<_$_Loaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ErrorDetailsCopyWith<$Res> {
  factory _$$_ErrorDetailsCopyWith(
          _$_ErrorDetails value, $Res Function(_$_ErrorDetails) then) =
      __$$_ErrorDetailsCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$$_ErrorDetailsCopyWithImpl<$Res>
    extends _$UserProfileStateCopyWithImpl<$Res>
    implements _$$_ErrorDetailsCopyWith<$Res> {
  __$$_ErrorDetailsCopyWithImpl(
      _$_ErrorDetails _value, $Res Function(_$_ErrorDetails) _then)
      : super(_value, (v) => _then(v as _$_ErrorDetails));

  @override
  _$_ErrorDetails get _value => super._value as _$_ErrorDetails;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$_ErrorDetails(
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
            other is _$_ErrorDetails &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$_ErrorDetailsCopyWith<_$_ErrorDetails> get copyWith =>
      __$$_ErrorDetailsCopyWithImpl<_$_ErrorDetails>(this, _$identity);

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
  const factory _ErrorDetails(final String message) = _$_ErrorDetails;

  String get message;
  @JsonKey(ignore: true)
  _$$_ErrorDetailsCopyWith<_$_ErrorDetails> get copyWith =>
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
abstract class _$$_MenuStateHiddenCopyWith<$Res> {
  factory _$$_MenuStateHiddenCopyWith(
          _$_MenuStateHidden value, $Res Function(_$_MenuStateHidden) then) =
      __$$_MenuStateHiddenCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_MenuStateHiddenCopyWithImpl<$Res>
    extends _$UserMenuStateCopyWithImpl<$Res>
    implements _$$_MenuStateHiddenCopyWith<$Res> {
  __$$_MenuStateHiddenCopyWithImpl(
      _$_MenuStateHidden _value, $Res Function(_$_MenuStateHidden) _then)
      : super(_value, (v) => _then(v as _$_MenuStateHidden));

  @override
  _$_MenuStateHidden get _value => super._value as _$_MenuStateHidden;
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
        (other.runtimeType == runtimeType && other is _$_MenuStateHidden);
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
abstract class _$$_MenuStateVisibleCopyWith<$Res> {
  factory _$$_MenuStateVisibleCopyWith(
          _$_MenuStateVisible value, $Res Function(_$_MenuStateVisible) then) =
      __$$_MenuStateVisibleCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_MenuStateVisibleCopyWithImpl<$Res>
    extends _$UserMenuStateCopyWithImpl<$Res>
    implements _$$_MenuStateVisibleCopyWith<$Res> {
  __$$_MenuStateVisibleCopyWithImpl(
      _$_MenuStateVisible _value, $Res Function(_$_MenuStateVisible) _then)
      : super(_value, (v) => _then(v as _$_MenuStateVisible));

  @override
  _$_MenuStateVisible get _value => super._value as _$_MenuStateVisible;
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
        (other.runtimeType == runtimeType && other is _$_MenuStateVisible);
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
    TResult Function(String message, bool inMainboardPage)? showSnackBar,
    TResult Function()? showProfileOptions,
    TResult Function(String? reason)? askReportReasonDialog,
    TResult Function(String message)? showBlockConfirmationDialog,
    TResult Function()? showProgressDialog,
    TResult Function()? dismissProgressDialog,
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
abstract class _$$_ReactionShowSnackBarCopyWith<$Res> {
  factory _$$_ReactionShowSnackBarCopyWith(_$_ReactionShowSnackBar value,
          $Res Function(_$_ReactionShowSnackBar) then) =
      __$$_ReactionShowSnackBarCopyWithImpl<$Res>;
  $Res call({String message, bool inMainboardPage});
}

/// @nodoc
class __$$_ReactionShowSnackBarCopyWithImpl<$Res>
    extends _$UserProfileReactionCopyWithImpl<$Res>
    implements _$$_ReactionShowSnackBarCopyWith<$Res> {
  __$$_ReactionShowSnackBarCopyWithImpl(_$_ReactionShowSnackBar _value,
      $Res Function(_$_ReactionShowSnackBar) _then)
      : super(_value, (v) => _then(v as _$_ReactionShowSnackBar));

  @override
  _$_ReactionShowSnackBar get _value => super._value as _$_ReactionShowSnackBar;

  @override
  $Res call({
    Object? message = freezed,
    Object? inMainboardPage = freezed,
  }) {
    return _then(_$_ReactionShowSnackBar(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      inMainboardPage: inMainboardPage == freezed
          ? _value.inMainboardPage
          : inMainboardPage // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ReactionShowSnackBar implements _ReactionShowSnackBar {
  _$_ReactionShowSnackBar(this.message, {this.inMainboardPage = false});

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReactionShowSnackBar &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality()
                .equals(other.inMainboardPage, inMainboardPage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(inMainboardPage));

  @JsonKey(ignore: true)
  @override
  _$$_ReactionShowSnackBarCopyWith<_$_ReactionShowSnackBar> get copyWith =>
      __$$_ReactionShowSnackBarCopyWithImpl<_$_ReactionShowSnackBar>(
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
    TResult Function(String message, bool inMainboardPage)? showSnackBar,
    TResult Function()? showProfileOptions,
    TResult Function(String? reason)? askReportReasonDialog,
    TResult Function(String message)? showBlockConfirmationDialog,
    TResult Function()? showProgressDialog,
    TResult Function()? dismissProgressDialog,
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
  factory _ReactionShowSnackBar(final String message,
      {final bool inMainboardPage}) = _$_ReactionShowSnackBar;

  String get message;
  bool get inMainboardPage;
  @JsonKey(ignore: true)
  _$$_ReactionShowSnackBarCopyWith<_$_ReactionShowSnackBar> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ReactionShowProfileOptionsCopyWith<$Res> {
  factory _$$_ReactionShowProfileOptionsCopyWith(
          _$_ReactionShowProfileOptions value,
          $Res Function(_$_ReactionShowProfileOptions) then) =
      __$$_ReactionShowProfileOptionsCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_ReactionShowProfileOptionsCopyWithImpl<$Res>
    extends _$UserProfileReactionCopyWithImpl<$Res>
    implements _$$_ReactionShowProfileOptionsCopyWith<$Res> {
  __$$_ReactionShowProfileOptionsCopyWithImpl(
      _$_ReactionShowProfileOptions _value,
      $Res Function(_$_ReactionShowProfileOptions) _then)
      : super(_value, (v) => _then(v as _$_ReactionShowProfileOptions));

  @override
  _$_ReactionShowProfileOptions get _value =>
      super._value as _$_ReactionShowProfileOptions;
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
            other is _$_ReactionShowProfileOptions);
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
    TResult Function(String message, bool inMainboardPage)? showSnackBar,
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
abstract class _$$_ReactionAskReportReasonDialogCopyWith<$Res> {
  factory _$$_ReactionAskReportReasonDialogCopyWith(
          _$_ReactionAskReportReasonDialog value,
          $Res Function(_$_ReactionAskReportReasonDialog) then) =
      __$$_ReactionAskReportReasonDialogCopyWithImpl<$Res>;
  $Res call({String? reason});
}

/// @nodoc
class __$$_ReactionAskReportReasonDialogCopyWithImpl<$Res>
    extends _$UserProfileReactionCopyWithImpl<$Res>
    implements _$$_ReactionAskReportReasonDialogCopyWith<$Res> {
  __$$_ReactionAskReportReasonDialogCopyWithImpl(
      _$_ReactionAskReportReasonDialog _value,
      $Res Function(_$_ReactionAskReportReasonDialog) _then)
      : super(_value, (v) => _then(v as _$_ReactionAskReportReasonDialog));

  @override
  _$_ReactionAskReportReasonDialog get _value =>
      super._value as _$_ReactionAskReportReasonDialog;

  @override
  $Res call({
    Object? reason = freezed,
  }) {
    return _then(_$_ReactionAskReportReasonDialog(
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

  @override
  @JsonKey()
  final String? reason;

  @override
  String toString() {
    return 'UserProfileReaction.askReportReasonDialog(reason: $reason)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReactionAskReportReasonDialog &&
            const DeepCollectionEquality().equals(other.reason, reason));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(reason));

  @JsonKey(ignore: true)
  @override
  _$$_ReactionAskReportReasonDialogCopyWith<_$_ReactionAskReportReasonDialog>
      get copyWith => __$$_ReactionAskReportReasonDialogCopyWithImpl<
          _$_ReactionAskReportReasonDialog>(this, _$identity);

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
    TResult Function(String message, bool inMainboardPage)? showSnackBar,
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
  factory _ReactionAskReportReasonDialog([final String? reason]) =
      _$_ReactionAskReportReasonDialog;

  String? get reason;
  @JsonKey(ignore: true)
  _$$_ReactionAskReportReasonDialogCopyWith<_$_ReactionAskReportReasonDialog>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ReactionShowBlockConfirmationDialogCopyWith<$Res> {
  factory _$$_ReactionShowBlockConfirmationDialogCopyWith(
          _$_ReactionShowBlockConfirmationDialog value,
          $Res Function(_$_ReactionShowBlockConfirmationDialog) then) =
      __$$_ReactionShowBlockConfirmationDialogCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$$_ReactionShowBlockConfirmationDialogCopyWithImpl<$Res>
    extends _$UserProfileReactionCopyWithImpl<$Res>
    implements _$$_ReactionShowBlockConfirmationDialogCopyWith<$Res> {
  __$$_ReactionShowBlockConfirmationDialogCopyWithImpl(
      _$_ReactionShowBlockConfirmationDialog _value,
      $Res Function(_$_ReactionShowBlockConfirmationDialog) _then)
      : super(
            _value, (v) => _then(v as _$_ReactionShowBlockConfirmationDialog));

  @override
  _$_ReactionShowBlockConfirmationDialog get _value =>
      super._value as _$_ReactionShowBlockConfirmationDialog;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$_ReactionShowBlockConfirmationDialog(
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
            other is _$_ReactionShowBlockConfirmationDialog &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$_ReactionShowBlockConfirmationDialogCopyWith<
          _$_ReactionShowBlockConfirmationDialog>
      get copyWith => __$$_ReactionShowBlockConfirmationDialogCopyWithImpl<
          _$_ReactionShowBlockConfirmationDialog>(this, _$identity);

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
    TResult Function(String message, bool inMainboardPage)? showSnackBar,
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
  factory _ReactionShowBlockConfirmationDialog(final String message) =
      _$_ReactionShowBlockConfirmationDialog;

  String get message;
  @JsonKey(ignore: true)
  _$$_ReactionShowBlockConfirmationDialogCopyWith<
          _$_ReactionShowBlockConfirmationDialog>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ReactionShowProgressDialogCopyWith<$Res> {
  factory _$$_ReactionShowProgressDialogCopyWith(
          _$_ReactionShowProgressDialog value,
          $Res Function(_$_ReactionShowProgressDialog) then) =
      __$$_ReactionShowProgressDialogCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_ReactionShowProgressDialogCopyWithImpl<$Res>
    extends _$UserProfileReactionCopyWithImpl<$Res>
    implements _$$_ReactionShowProgressDialogCopyWith<$Res> {
  __$$_ReactionShowProgressDialogCopyWithImpl(
      _$_ReactionShowProgressDialog _value,
      $Res Function(_$_ReactionShowProgressDialog) _then)
      : super(_value, (v) => _then(v as _$_ReactionShowProgressDialog));

  @override
  _$_ReactionShowProgressDialog get _value =>
      super._value as _$_ReactionShowProgressDialog;
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
            other is _$_ReactionShowProgressDialog);
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
    TResult Function(String message, bool inMainboardPage)? showSnackBar,
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
abstract class _$$_ReactionDismissProgressDialogCopyWith<$Res> {
  factory _$$_ReactionDismissProgressDialogCopyWith(
          _$_ReactionDismissProgressDialog value,
          $Res Function(_$_ReactionDismissProgressDialog) then) =
      __$$_ReactionDismissProgressDialogCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_ReactionDismissProgressDialogCopyWithImpl<$Res>
    extends _$UserProfileReactionCopyWithImpl<$Res>
    implements _$$_ReactionDismissProgressDialogCopyWith<$Res> {
  __$$_ReactionDismissProgressDialogCopyWithImpl(
      _$_ReactionDismissProgressDialog _value,
      $Res Function(_$_ReactionDismissProgressDialog) _then)
      : super(_value, (v) => _then(v as _$_ReactionDismissProgressDialog));

  @override
  _$_ReactionDismissProgressDialog get _value =>
      super._value as _$_ReactionDismissProgressDialog;
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
            other is _$_ReactionDismissProgressDialog);
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
    TResult Function(String message, bool inMainboardPage)? showSnackBar,
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
abstract class _$$_SelectedOptionReportCopyWith<$Res> {
  factory _$$_SelectedOptionReportCopyWith(_$_SelectedOptionReport value,
          $Res Function(_$_SelectedOptionReport) then) =
      __$$_SelectedOptionReportCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_SelectedOptionReportCopyWithImpl<$Res>
    extends _$UserProfileSelectedOptionCopyWithImpl<$Res>
    implements _$$_SelectedOptionReportCopyWith<$Res> {
  __$$_SelectedOptionReportCopyWithImpl(_$_SelectedOptionReport _value,
      $Res Function(_$_SelectedOptionReport) _then)
      : super(_value, (v) => _then(v as _$_SelectedOptionReport));

  @override
  _$_SelectedOptionReport get _value => super._value as _$_SelectedOptionReport;
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
        (other.runtimeType == runtimeType && other is _$_SelectedOptionReport);
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
abstract class _$$_SelectedOptionBlockCopyWith<$Res> {
  factory _$$_SelectedOptionBlockCopyWith(_$_SelectedOptionBlock value,
          $Res Function(_$_SelectedOptionBlock) then) =
      __$$_SelectedOptionBlockCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_SelectedOptionBlockCopyWithImpl<$Res>
    extends _$UserProfileSelectedOptionCopyWithImpl<$Res>
    implements _$$_SelectedOptionBlockCopyWith<$Res> {
  __$$_SelectedOptionBlockCopyWithImpl(_$_SelectedOptionBlock _value,
      $Res Function(_$_SelectedOptionBlock) _then)
      : super(_value, (v) => _then(v as _$_SelectedOptionBlock));

  @override
  _$_SelectedOptionBlock get _value => super._value as _$_SelectedOptionBlock;
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
        (other.runtimeType == runtimeType && other is _$_SelectedOptionBlock);
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
