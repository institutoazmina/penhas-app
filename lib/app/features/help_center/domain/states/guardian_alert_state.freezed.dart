// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'guardian_alert_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$GuardianAlertStateTearOff {
  const _$GuardianAlertStateTearOff();

  _Initial initial() {
    return const _Initial();
  }

  _Alert alert(GuardianAlertMessageAction action) {
    return _Alert(
      action,
    );
  }
}

/// @nodoc
const $GuardianAlertState = _$GuardianAlertStateTearOff();

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
abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res>
    extends _$GuardianAlertStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;
}

/// @nodoc

class _$_Initial with DiagnosticableTreeMixin implements _Initial {
  const _$_Initial();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GuardianAlertState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'GuardianAlertState.initial'));
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
abstract class _$AlertCopyWith<$Res> {
  factory _$AlertCopyWith(_Alert value, $Res Function(_Alert) then) =
      __$AlertCopyWithImpl<$Res>;
  $Res call({GuardianAlertMessageAction action});
}

/// @nodoc
class __$AlertCopyWithImpl<$Res> extends _$GuardianAlertStateCopyWithImpl<$Res>
    implements _$AlertCopyWith<$Res> {
  __$AlertCopyWithImpl(_Alert _value, $Res Function(_Alert) _then)
      : super(_value, (v) => _then(v as _Alert));

  @override
  _Alert get _value => super._value as _Alert;

  @override
  $Res call({
    Object? action = freezed,
  }) {
    return _then(_Alert(
      action == freezed
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as GuardianAlertMessageAction,
    ));
  }
}

/// @nodoc

class _$_Alert with DiagnosticableTreeMixin implements _Alert {
  const _$_Alert(this.action);

  @override
  final GuardianAlertMessageAction action;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GuardianAlertState.alert(action: $action)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GuardianAlertState.alert'))
      ..add(DiagnosticsProperty('action', action));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Alert &&
            const DeepCollectionEquality().equals(other.action, action));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(action));

  @JsonKey(ignore: true)
  @override
  _$AlertCopyWith<_Alert> get copyWith =>
      __$AlertCopyWithImpl<_Alert>(this, _$identity);

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
  const factory _Alert(GuardianAlertMessageAction action) = _$_Alert;

  GuardianAlertMessageAction get action;
  @JsonKey(ignore: true)
  _$AlertCopyWith<_Alert> get copyWith => throw _privateConstructorUsedError;
}
