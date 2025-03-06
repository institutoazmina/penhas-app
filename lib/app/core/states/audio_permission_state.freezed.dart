// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'audio_permission_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AudioPermissionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() granted,
    required TResult Function() denied,
    required TResult Function() permanentlyDenied,
    required TResult Function() restricted,
    required TResult Function() undefined,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? granted,
    TResult Function()? denied,
    TResult Function()? permanentlyDenied,
    TResult Function()? restricted,
    TResult Function()? undefined,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? granted,
    TResult Function()? denied,
    TResult Function()? permanentlyDenied,
    TResult Function()? restricted,
    TResult Function()? undefined,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Granted value) granted,
    required TResult Function(_Denied value) denied,
    required TResult Function(_PermanentlyDenied value) permanentlyDenied,
    required TResult Function(_Restricted value) restricted,
    required TResult Function(_Undefined value) undefined,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Granted value)? granted,
    TResult Function(_Denied value)? denied,
    TResult Function(_PermanentlyDenied value)? permanentlyDenied,
    TResult Function(_Restricted value)? restricted,
    TResult Function(_Undefined value)? undefined,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Granted value)? granted,
    TResult Function(_Denied value)? denied,
    TResult Function(_PermanentlyDenied value)? permanentlyDenied,
    TResult Function(_Restricted value)? restricted,
    TResult Function(_Undefined value)? undefined,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioPermissionStateCopyWith<$Res> {
  factory $AudioPermissionStateCopyWith(AudioPermissionState value,
          $Res Function(AudioPermissionState) then) =
      _$AudioPermissionStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$AudioPermissionStateCopyWithImpl<$Res>
    implements $AudioPermissionStateCopyWith<$Res> {
  _$AudioPermissionStateCopyWithImpl(this._value, this._then);

  final AudioPermissionState _value;
  // ignore: unused_field
  final $Res Function(AudioPermissionState) _then;
}

/// @nodoc
abstract class _$$_GrantedCopyWith<$Res> {
  factory _$$_GrantedCopyWith(
          _$_Granted value, $Res Function(_$_Granted) then) =
      __$$_GrantedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_GrantedCopyWithImpl<$Res>
    extends _$AudioPermissionStateCopyWithImpl<$Res>
    implements _$$_GrantedCopyWith<$Res> {
  __$$_GrantedCopyWithImpl(_$_Granted _value, $Res Function(_$_Granted) _then)
      : super(_value, (v) => _then(v as _$_Granted));

  @override
  _$_Granted get _value => super._value as _$_Granted;
}

/// @nodoc

class _$_Granted implements _Granted {
  const _$_Granted();

  @override
  String toString() {
    return 'AudioPermissionState.granted()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Granted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() granted,
    required TResult Function() denied,
    required TResult Function() permanentlyDenied,
    required TResult Function() restricted,
    required TResult Function() undefined,
  }) {
    return granted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? granted,
    TResult Function()? denied,
    TResult Function()? permanentlyDenied,
    TResult Function()? restricted,
    TResult Function()? undefined,
  }) {
    return granted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? granted,
    TResult Function()? denied,
    TResult Function()? permanentlyDenied,
    TResult Function()? restricted,
    TResult Function()? undefined,
    required TResult orElse(),
  }) {
    if (granted != null) {
      return granted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Granted value) granted,
    required TResult Function(_Denied value) denied,
    required TResult Function(_PermanentlyDenied value) permanentlyDenied,
    required TResult Function(_Restricted value) restricted,
    required TResult Function(_Undefined value) undefined,
  }) {
    return granted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Granted value)? granted,
    TResult Function(_Denied value)? denied,
    TResult Function(_PermanentlyDenied value)? permanentlyDenied,
    TResult Function(_Restricted value)? restricted,
    TResult Function(_Undefined value)? undefined,
  }) {
    return granted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Granted value)? granted,
    TResult Function(_Denied value)? denied,
    TResult Function(_PermanentlyDenied value)? permanentlyDenied,
    TResult Function(_Restricted value)? restricted,
    TResult Function(_Undefined value)? undefined,
    required TResult orElse(),
  }) {
    if (granted != null) {
      return granted(this);
    }
    return orElse();
  }
}

abstract class _Granted implements AudioPermissionState {
  const factory _Granted() = _$_Granted;
}

/// @nodoc
abstract class _$$_DeniedCopyWith<$Res> {
  factory _$$_DeniedCopyWith(_$_Denied value, $Res Function(_$_Denied) then) =
      __$$_DeniedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_DeniedCopyWithImpl<$Res>
    extends _$AudioPermissionStateCopyWithImpl<$Res>
    implements _$$_DeniedCopyWith<$Res> {
  __$$_DeniedCopyWithImpl(_$_Denied _value, $Res Function(_$_Denied) _then)
      : super(_value, (v) => _then(v as _$_Denied));

  @override
  _$_Denied get _value => super._value as _$_Denied;
}

/// @nodoc

class _$_Denied implements _Denied {
  const _$_Denied();

  @override
  String toString() {
    return 'AudioPermissionState.denied()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Denied);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() granted,
    required TResult Function() denied,
    required TResult Function() permanentlyDenied,
    required TResult Function() restricted,
    required TResult Function() undefined,
  }) {
    return denied();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? granted,
    TResult Function()? denied,
    TResult Function()? permanentlyDenied,
    TResult Function()? restricted,
    TResult Function()? undefined,
  }) {
    return denied?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? granted,
    TResult Function()? denied,
    TResult Function()? permanentlyDenied,
    TResult Function()? restricted,
    TResult Function()? undefined,
    required TResult orElse(),
  }) {
    if (denied != null) {
      return denied();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Granted value) granted,
    required TResult Function(_Denied value) denied,
    required TResult Function(_PermanentlyDenied value) permanentlyDenied,
    required TResult Function(_Restricted value) restricted,
    required TResult Function(_Undefined value) undefined,
  }) {
    return denied(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Granted value)? granted,
    TResult Function(_Denied value)? denied,
    TResult Function(_PermanentlyDenied value)? permanentlyDenied,
    TResult Function(_Restricted value)? restricted,
    TResult Function(_Undefined value)? undefined,
  }) {
    return denied?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Granted value)? granted,
    TResult Function(_Denied value)? denied,
    TResult Function(_PermanentlyDenied value)? permanentlyDenied,
    TResult Function(_Restricted value)? restricted,
    TResult Function(_Undefined value)? undefined,
    required TResult orElse(),
  }) {
    if (denied != null) {
      return denied(this);
    }
    return orElse();
  }
}

abstract class _Denied implements AudioPermissionState {
  const factory _Denied() = _$_Denied;
}

/// @nodoc
abstract class _$$_PermanentlyDeniedCopyWith<$Res> {
  factory _$$_PermanentlyDeniedCopyWith(_$_PermanentlyDenied value,
          $Res Function(_$_PermanentlyDenied) then) =
      __$$_PermanentlyDeniedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_PermanentlyDeniedCopyWithImpl<$Res>
    extends _$AudioPermissionStateCopyWithImpl<$Res>
    implements _$$_PermanentlyDeniedCopyWith<$Res> {
  __$$_PermanentlyDeniedCopyWithImpl(
      _$_PermanentlyDenied _value, $Res Function(_$_PermanentlyDenied) _then)
      : super(_value, (v) => _then(v as _$_PermanentlyDenied));

  @override
  _$_PermanentlyDenied get _value => super._value as _$_PermanentlyDenied;
}

/// @nodoc

class _$_PermanentlyDenied implements _PermanentlyDenied {
  const _$_PermanentlyDenied();

  @override
  String toString() {
    return 'AudioPermissionState.permanentlyDenied()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_PermanentlyDenied);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() granted,
    required TResult Function() denied,
    required TResult Function() permanentlyDenied,
    required TResult Function() restricted,
    required TResult Function() undefined,
  }) {
    return permanentlyDenied();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? granted,
    TResult Function()? denied,
    TResult Function()? permanentlyDenied,
    TResult Function()? restricted,
    TResult Function()? undefined,
  }) {
    return permanentlyDenied?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? granted,
    TResult Function()? denied,
    TResult Function()? permanentlyDenied,
    TResult Function()? restricted,
    TResult Function()? undefined,
    required TResult orElse(),
  }) {
    if (permanentlyDenied != null) {
      return permanentlyDenied();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Granted value) granted,
    required TResult Function(_Denied value) denied,
    required TResult Function(_PermanentlyDenied value) permanentlyDenied,
    required TResult Function(_Restricted value) restricted,
    required TResult Function(_Undefined value) undefined,
  }) {
    return permanentlyDenied(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Granted value)? granted,
    TResult Function(_Denied value)? denied,
    TResult Function(_PermanentlyDenied value)? permanentlyDenied,
    TResult Function(_Restricted value)? restricted,
    TResult Function(_Undefined value)? undefined,
  }) {
    return permanentlyDenied?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Granted value)? granted,
    TResult Function(_Denied value)? denied,
    TResult Function(_PermanentlyDenied value)? permanentlyDenied,
    TResult Function(_Restricted value)? restricted,
    TResult Function(_Undefined value)? undefined,
    required TResult orElse(),
  }) {
    if (permanentlyDenied != null) {
      return permanentlyDenied(this);
    }
    return orElse();
  }
}

abstract class _PermanentlyDenied implements AudioPermissionState {
  const factory _PermanentlyDenied() = _$_PermanentlyDenied;
}

/// @nodoc
abstract class _$$_RestrictedCopyWith<$Res> {
  factory _$$_RestrictedCopyWith(
          _$_Restricted value, $Res Function(_$_Restricted) then) =
      __$$_RestrictedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_RestrictedCopyWithImpl<$Res>
    extends _$AudioPermissionStateCopyWithImpl<$Res>
    implements _$$_RestrictedCopyWith<$Res> {
  __$$_RestrictedCopyWithImpl(
      _$_Restricted _value, $Res Function(_$_Restricted) _then)
      : super(_value, (v) => _then(v as _$_Restricted));

  @override
  _$_Restricted get _value => super._value as _$_Restricted;
}

/// @nodoc

class _$_Restricted implements _Restricted {
  const _$_Restricted();

  @override
  String toString() {
    return 'AudioPermissionState.restricted()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Restricted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() granted,
    required TResult Function() denied,
    required TResult Function() permanentlyDenied,
    required TResult Function() restricted,
    required TResult Function() undefined,
  }) {
    return restricted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? granted,
    TResult Function()? denied,
    TResult Function()? permanentlyDenied,
    TResult Function()? restricted,
    TResult Function()? undefined,
  }) {
    return restricted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? granted,
    TResult Function()? denied,
    TResult Function()? permanentlyDenied,
    TResult Function()? restricted,
    TResult Function()? undefined,
    required TResult orElse(),
  }) {
    if (restricted != null) {
      return restricted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Granted value) granted,
    required TResult Function(_Denied value) denied,
    required TResult Function(_PermanentlyDenied value) permanentlyDenied,
    required TResult Function(_Restricted value) restricted,
    required TResult Function(_Undefined value) undefined,
  }) {
    return restricted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Granted value)? granted,
    TResult Function(_Denied value)? denied,
    TResult Function(_PermanentlyDenied value)? permanentlyDenied,
    TResult Function(_Restricted value)? restricted,
    TResult Function(_Undefined value)? undefined,
  }) {
    return restricted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Granted value)? granted,
    TResult Function(_Denied value)? denied,
    TResult Function(_PermanentlyDenied value)? permanentlyDenied,
    TResult Function(_Restricted value)? restricted,
    TResult Function(_Undefined value)? undefined,
    required TResult orElse(),
  }) {
    if (restricted != null) {
      return restricted(this);
    }
    return orElse();
  }
}

abstract class _Restricted implements AudioPermissionState {
  const factory _Restricted() = _$_Restricted;
}

/// @nodoc
abstract class _$$_UndefinedCopyWith<$Res> {
  factory _$$_UndefinedCopyWith(
          _$_Undefined value, $Res Function(_$_Undefined) then) =
      __$$_UndefinedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_UndefinedCopyWithImpl<$Res>
    extends _$AudioPermissionStateCopyWithImpl<$Res>
    implements _$$_UndefinedCopyWith<$Res> {
  __$$_UndefinedCopyWithImpl(
      _$_Undefined _value, $Res Function(_$_Undefined) _then)
      : super(_value, (v) => _then(v as _$_Undefined));

  @override
  _$_Undefined get _value => super._value as _$_Undefined;
}

/// @nodoc

class _$_Undefined implements _Undefined {
  const _$_Undefined();

  @override
  String toString() {
    return 'AudioPermissionState.undefined()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Undefined);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() granted,
    required TResult Function() denied,
    required TResult Function() permanentlyDenied,
    required TResult Function() restricted,
    required TResult Function() undefined,
  }) {
    return undefined();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? granted,
    TResult Function()? denied,
    TResult Function()? permanentlyDenied,
    TResult Function()? restricted,
    TResult Function()? undefined,
  }) {
    return undefined?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? granted,
    TResult Function()? denied,
    TResult Function()? permanentlyDenied,
    TResult Function()? restricted,
    TResult Function()? undefined,
    required TResult orElse(),
  }) {
    if (undefined != null) {
      return undefined();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Granted value) granted,
    required TResult Function(_Denied value) denied,
    required TResult Function(_PermanentlyDenied value) permanentlyDenied,
    required TResult Function(_Restricted value) restricted,
    required TResult Function(_Undefined value) undefined,
  }) {
    return undefined(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Granted value)? granted,
    TResult Function(_Denied value)? denied,
    TResult Function(_PermanentlyDenied value)? permanentlyDenied,
    TResult Function(_Restricted value)? restricted,
    TResult Function(_Undefined value)? undefined,
  }) {
    return undefined?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Granted value)? granted,
    TResult Function(_Denied value)? denied,
    TResult Function(_PermanentlyDenied value)? permanentlyDenied,
    TResult Function(_Restricted value)? restricted,
    TResult Function(_Undefined value)? undefined,
    required TResult orElse(),
  }) {
    if (undefined != null) {
      return undefined(this);
    }
    return orElse();
  }
}

abstract class _Undefined implements AudioPermissionState {
  const factory _Undefined() = _$_Undefined;
}
