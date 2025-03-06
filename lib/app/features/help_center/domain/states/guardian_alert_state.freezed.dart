// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'guardian_alert_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GuardianAlertState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(GuardianAlertMessageAction action) alert,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(GuardianAlertMessageAction action)? alert,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(GuardianAlertMessageAction action)? alert,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Alert value) alert,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Alert value)? alert,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Alert value)? alert,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GuardianAlertStateCopyWith<$Res> {
  factory $GuardianAlertStateCopyWith(
          GuardianAlertState value, $Res Function(GuardianAlertState) then) =
      _$GuardianAlertStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$GuardianAlertStateCopyWithImpl<$Res>
    implements $GuardianAlertStateCopyWith<$Res> {
  _$GuardianAlertStateCopyWithImpl(this._value, this._then);

  final GuardianAlertState _value;
  // ignore: unused_field
  final $Res Function(GuardianAlertState) _then;
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$GuardianAlertStateCopyWithImpl<$Res>
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
    return 'GuardianAlertState.initial()';
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
    required TResult Function(GuardianAlertMessageAction action) alert,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(GuardianAlertMessageAction action)? alert,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(GuardianAlertMessageAction action)? alert,
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
    required TResult Function(_Alert value) alert,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Alert value)? alert,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Alert value)? alert,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements GuardianAlertState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$$_AlertCopyWith<$Res> {
  factory _$$_AlertCopyWith(_$_Alert value, $Res Function(_$_Alert) then) =
      __$$_AlertCopyWithImpl<$Res>;
  $Res call({GuardianAlertMessageAction action});
}

/// @nodoc
class __$$_AlertCopyWithImpl<$Res>
    extends _$GuardianAlertStateCopyWithImpl<$Res>
    implements _$$_AlertCopyWith<$Res> {
  __$$_AlertCopyWithImpl(_$_Alert _value, $Res Function(_$_Alert) _then)
      : super(_value, (v) => _then(v as _$_Alert));

  @override
  _$_Alert get _value => super._value as _$_Alert;

  @override
  $Res call({
    Object? action = freezed,
  }) {
    return _then(_$_Alert(
      action == freezed
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as GuardianAlertMessageAction,
    ));
  }
}

/// @nodoc

class _$_Alert implements _Alert {
  const _$_Alert(this.action);

  @override
  final GuardianAlertMessageAction action;

  @override
  String toString() {
    return 'GuardianAlertState.alert(action: $action)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Alert &&
            const DeepCollectionEquality().equals(other.action, action));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(action));

  @JsonKey(ignore: true)
  @override
  _$$_AlertCopyWith<_$_Alert> get copyWith =>
      __$$_AlertCopyWithImpl<_$_Alert>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(GuardianAlertMessageAction action) alert,
  }) {
    return alert(action);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(GuardianAlertMessageAction action)? alert,
  }) {
    return alert?.call(action);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(GuardianAlertMessageAction action)? alert,
    required TResult orElse(),
  }) {
    if (alert != null) {
      return alert(action);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Alert value) alert,
  }) {
    return alert(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Alert value)? alert,
  }) {
    return alert?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Alert value)? alert,
    required TResult orElse(),
  }) {
    if (alert != null) {
      return alert(this);
    }
    return orElse();
  }
}

abstract class _Alert implements GuardianAlertState {
  const factory _Alert(final GuardianAlertMessageAction action) = _$_Alert;

  GuardianAlertMessageAction get action;
  @JsonKey(ignore: true)
  _$$_AlertCopyWith<_$_Alert> get copyWith =>
      throw _privateConstructorUsedError;
}
