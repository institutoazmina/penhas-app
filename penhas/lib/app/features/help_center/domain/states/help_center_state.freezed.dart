// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'help_center_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$HelpCenterStateTearOff {
  const _$HelpCenterStateTearOff();

// ignore: unused_element
  _Initial initial() {
    return const _Initial();
  }

// ignore: unused_element
  _GuardianTriggered guardianTriggered(GuardianAlertMessageAction action) {
    return _GuardianTriggered(
      action,
    );
  }

// ignore: unused_element
  _CallingPolice callingPolice(String callingNumber) {
    return _CallingPolice(
      callingNumber,
    );
  }
}

// ignore: unused_element
const $HelpCenterState = _$HelpCenterStateTearOff();

mixin _$HelpCenterState {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result guardianTriggered(GuardianAlertMessageAction action),
    @required Result callingPolice(String callingNumber),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result guardianTriggered(GuardianAlertMessageAction action),
    Result callingPolice(String callingNumber),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result guardianTriggered(_GuardianTriggered value),
    @required Result callingPolice(_CallingPolice value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result guardianTriggered(_GuardianTriggered value),
    Result callingPolice(_CallingPolice value),
    @required Result orElse(),
  });
}

abstract class $HelpCenterStateCopyWith<$Res> {
  factory $HelpCenterStateCopyWith(
          HelpCenterState value, $Res Function(HelpCenterState) then) =
      _$HelpCenterStateCopyWithImpl<$Res>;
}

class _$HelpCenterStateCopyWithImpl<$Res>
    implements $HelpCenterStateCopyWith<$Res> {
  _$HelpCenterStateCopyWithImpl(this._value, this._then);

  final HelpCenterState _value;
  // ignore: unused_field
  final $Res Function(HelpCenterState) _then;
}

abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

class __$InitialCopyWithImpl<$Res> extends _$HelpCenterStateCopyWithImpl<$Res>
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
    return 'HelpCenterState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'HelpCenterState.initial'));
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
    @required Result guardianTriggered(GuardianAlertMessageAction action),
    @required Result callingPolice(String callingNumber),
  }) {
    assert(initial != null);
    assert(guardianTriggered != null);
    assert(callingPolice != null);
    return initial();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result guardianTriggered(GuardianAlertMessageAction action),
    Result callingPolice(String callingNumber),
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
    @required Result guardianTriggered(_GuardianTriggered value),
    @required Result callingPolice(_CallingPolice value),
  }) {
    assert(initial != null);
    assert(guardianTriggered != null);
    assert(callingPolice != null);
    return initial(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result guardianTriggered(_GuardianTriggered value),
    Result callingPolice(_CallingPolice value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements HelpCenterState {
  const factory _Initial() = _$_Initial;
}

abstract class _$GuardianTriggeredCopyWith<$Res> {
  factory _$GuardianTriggeredCopyWith(
          _GuardianTriggered value, $Res Function(_GuardianTriggered) then) =
      __$GuardianTriggeredCopyWithImpl<$Res>;
  $Res call({GuardianAlertMessageAction action});
}

class __$GuardianTriggeredCopyWithImpl<$Res>
    extends _$HelpCenterStateCopyWithImpl<$Res>
    implements _$GuardianTriggeredCopyWith<$Res> {
  __$GuardianTriggeredCopyWithImpl(
      _GuardianTriggered _value, $Res Function(_GuardianTriggered) _then)
      : super(_value, (v) => _then(v as _GuardianTriggered));

  @override
  _GuardianTriggered get _value => super._value as _GuardianTriggered;

  @override
  $Res call({
    Object action = freezed,
  }) {
    return _then(_GuardianTriggered(
      action == freezed ? _value.action : action as GuardianAlertMessageAction,
    ));
  }
}

class _$_GuardianTriggered
    with DiagnosticableTreeMixin
    implements _GuardianTriggered {
  const _$_GuardianTriggered(this.action) : assert(action != null);

  @override
  final GuardianAlertMessageAction action;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HelpCenterState.guardianTriggered(action: $action)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HelpCenterState.guardianTriggered'))
      ..add(DiagnosticsProperty('action', action));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GuardianTriggered &&
            (identical(other.action, action) ||
                const DeepCollectionEquality().equals(other.action, action)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(action);

  @override
  _$GuardianTriggeredCopyWith<_GuardianTriggered> get copyWith =>
      __$GuardianTriggeredCopyWithImpl<_GuardianTriggered>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result guardianTriggered(GuardianAlertMessageAction action),
    @required Result callingPolice(String callingNumber),
  }) {
    assert(initial != null);
    assert(guardianTriggered != null);
    assert(callingPolice != null);
    return guardianTriggered(action);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result guardianTriggered(GuardianAlertMessageAction action),
    Result callingPolice(String callingNumber),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (guardianTriggered != null) {
      return guardianTriggered(action);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result guardianTriggered(_GuardianTriggered value),
    @required Result callingPolice(_CallingPolice value),
  }) {
    assert(initial != null);
    assert(guardianTriggered != null);
    assert(callingPolice != null);
    return guardianTriggered(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result guardianTriggered(_GuardianTriggered value),
    Result callingPolice(_CallingPolice value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (guardianTriggered != null) {
      return guardianTriggered(this);
    }
    return orElse();
  }
}

abstract class _GuardianTriggered implements HelpCenterState {
  const factory _GuardianTriggered(GuardianAlertMessageAction action) =
      _$_GuardianTriggered;

  GuardianAlertMessageAction get action;
  _$GuardianTriggeredCopyWith<_GuardianTriggered> get copyWith;
}

abstract class _$CallingPoliceCopyWith<$Res> {
  factory _$CallingPoliceCopyWith(
          _CallingPolice value, $Res Function(_CallingPolice) then) =
      __$CallingPoliceCopyWithImpl<$Res>;
  $Res call({String callingNumber});
}

class __$CallingPoliceCopyWithImpl<$Res>
    extends _$HelpCenterStateCopyWithImpl<$Res>
    implements _$CallingPoliceCopyWith<$Res> {
  __$CallingPoliceCopyWithImpl(
      _CallingPolice _value, $Res Function(_CallingPolice) _then)
      : super(_value, (v) => _then(v as _CallingPolice));

  @override
  _CallingPolice get _value => super._value as _CallingPolice;

  @override
  $Res call({
    Object callingNumber = freezed,
  }) {
    return _then(_CallingPolice(
      callingNumber == freezed ? _value.callingNumber : callingNumber as String,
    ));
  }
}

class _$_CallingPolice with DiagnosticableTreeMixin implements _CallingPolice {
  const _$_CallingPolice(this.callingNumber) : assert(callingNumber != null);

  @override
  final String callingNumber;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HelpCenterState.callingPolice(callingNumber: $callingNumber)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HelpCenterState.callingPolice'))
      ..add(DiagnosticsProperty('callingNumber', callingNumber));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CallingPolice &&
            (identical(other.callingNumber, callingNumber) ||
                const DeepCollectionEquality()
                    .equals(other.callingNumber, callingNumber)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(callingNumber);

  @override
  _$CallingPoliceCopyWith<_CallingPolice> get copyWith =>
      __$CallingPoliceCopyWithImpl<_CallingPolice>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result guardianTriggered(GuardianAlertMessageAction action),
    @required Result callingPolice(String callingNumber),
  }) {
    assert(initial != null);
    assert(guardianTriggered != null);
    assert(callingPolice != null);
    return callingPolice(callingNumber);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result guardianTriggered(GuardianAlertMessageAction action),
    Result callingPolice(String callingNumber),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (callingPolice != null) {
      return callingPolice(callingNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result guardianTriggered(_GuardianTriggered value),
    @required Result callingPolice(_CallingPolice value),
  }) {
    assert(initial != null);
    assert(guardianTriggered != null);
    assert(callingPolice != null);
    return callingPolice(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result guardianTriggered(_GuardianTriggered value),
    Result callingPolice(_CallingPolice value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (callingPolice != null) {
      return callingPolice(this);
    }
    return orElse();
  }
}

abstract class _CallingPolice implements HelpCenterState {
  const factory _CallingPolice(String callingNumber) = _$_CallingPolice;

  String get callingNumber;
  _$CallingPoliceCopyWith<_CallingPolice> get copyWith;
}
