// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'guardian_alert_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

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

// ignore: unused_element
const $GuardianAlertState = _$GuardianAlertStateTearOff();

mixin _$GuardianAlertState {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result alert(GuardianAlertMessageAction action),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result alert(GuardianAlertMessageAction action),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result alert(_Alert value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result alert(_Alert value),
    @required Result orElse(),
  });
}

abstract class $GuardianAlertStateCopyWith<$Res> {
  factory $GuardianAlertStateCopyWith(
          GuardianAlertState value, $Res Function(GuardianAlertState) then) =
      _$GuardianAlertStateCopyWithImpl<$Res>;
}

class _$GuardianAlertStateCopyWithImpl<$Res>
    implements $GuardianAlertStateCopyWith<$Res> {
  _$GuardianAlertStateCopyWithImpl(this._value, this._then);

  final GuardianAlertState _value;
  // ignore: unused_field
  final $Res Function(GuardianAlertState) _then;
}

abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

class __$InitialCopyWithImpl<$Res>
    extends _$GuardianAlertStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;
}

class _$_Initial with DiagnosticableTreeMixin implements _Initial {
  const _$_Initial();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GuardianAlertState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'GuardianAlertState.initial'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result alert(GuardianAlertMessageAction action),
  }) {
    assert(initial != null);
    assert(alert != null);
    return initial();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result alert(GuardianAlertMessageAction action),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result alert(_Alert value),
  }) {
    assert(initial != null);
    assert(alert != null);
    return initial(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result alert(_Alert value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements GuardianAlertState {
  const factory _Initial() = _$_Initial;
}

abstract class _$AlertCopyWith<$Res> {
  factory _$AlertCopyWith(_Alert value, $Res Function(_Alert) then) =
      __$AlertCopyWithImpl<$Res>;
  $Res call({GuardianAlertMessageAction action});
}

class __$AlertCopyWithImpl<$Res> extends _$GuardianAlertStateCopyWithImpl<$Res>
    implements _$AlertCopyWith<$Res> {
  __$AlertCopyWithImpl(_Alert _value, $Res Function(_Alert) _then)
      : super(_value, (v) => _then(v as _Alert));

  @override
  _Alert get _value => super._value as _Alert;

  @override
  $Res call({
    Object action = freezed,
  }) {
    return _then(_Alert(
      action == freezed ? _value.action : action as GuardianAlertMessageAction,
    ));
  }
}

class _$_Alert with DiagnosticableTreeMixin implements _Alert {
  const _$_Alert(this.action) : assert(action != null);

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
        (other is _Alert &&
            (identical(other.action, action) ||
                const DeepCollectionEquality().equals(other.action, action)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(action);

  @override
  _$AlertCopyWith<_Alert> get copyWith =>
      __$AlertCopyWithImpl<_Alert>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result alert(GuardianAlertMessageAction action),
  }) {
    assert(initial != null);
    assert(alert != null);
    return alert(action);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result alert(GuardianAlertMessageAction action),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (alert != null) {
      return alert(action);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result alert(_Alert value),
  }) {
    assert(initial != null);
    assert(alert != null);
    return alert(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result alert(_Alert value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (alert != null) {
      return alert(this);
    }
    return orElse();
  }
}

abstract class _Alert implements GuardianAlertState {
  const factory _Alert(GuardianAlertMessageAction action) = _$_Alert;

  GuardianAlertMessageAction get action;
  _$AlertCopyWith<_Alert> get copyWith;
}
