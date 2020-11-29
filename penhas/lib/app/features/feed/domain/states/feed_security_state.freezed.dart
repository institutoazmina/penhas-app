// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'feed_security_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$FeedSecurityStateTearOff {
  const _$FeedSecurityStateTearOff();

// ignore: unused_element
  _Enable enable() {
    return const _Enable();
  }

// ignore: unused_element
  _Disable disable() {
    return const _Disable();
  }
}

/// @nodoc
// ignore: unused_element
const $FeedSecurityState = _$FeedSecurityStateTearOff();

/// @nodoc
mixin _$FeedSecurityState {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result enable(),
    @required Result disable(),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result enable(),
    Result disable(),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result enable(_Enable value),
    @required Result disable(_Disable value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result enable(_Enable value),
    Result disable(_Disable value),
    @required Result orElse(),
  });
}

/// @nodoc
abstract class $FeedSecurityStateCopyWith<$Res> {
  factory $FeedSecurityStateCopyWith(
          FeedSecurityState value, $Res Function(FeedSecurityState) then) =
      _$FeedSecurityStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$FeedSecurityStateCopyWithImpl<$Res>
    implements $FeedSecurityStateCopyWith<$Res> {
  _$FeedSecurityStateCopyWithImpl(this._value, this._then);

  final FeedSecurityState _value;
  // ignore: unused_field
  final $Res Function(FeedSecurityState) _then;
}

/// @nodoc
abstract class _$EnableCopyWith<$Res> {
  factory _$EnableCopyWith(_Enable value, $Res Function(_Enable) then) =
      __$EnableCopyWithImpl<$Res>;
}

/// @nodoc
class __$EnableCopyWithImpl<$Res> extends _$FeedSecurityStateCopyWithImpl<$Res>
    implements _$EnableCopyWith<$Res> {
  __$EnableCopyWithImpl(_Enable _value, $Res Function(_Enable) _then)
      : super(_value, (v) => _then(v as _Enable));

  @override
  _Enable get _value => super._value as _Enable;
}

/// @nodoc
class _$_Enable with DiagnosticableTreeMixin implements _Enable {
  const _$_Enable();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FeedSecurityState.enable()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'FeedSecurityState.enable'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Enable);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result enable(),
    @required Result disable(),
  }) {
    assert(enable != null);
    assert(disable != null);
    return enable();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result enable(),
    Result disable(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (enable != null) {
      return enable();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result enable(_Enable value),
    @required Result disable(_Disable value),
  }) {
    assert(enable != null);
    assert(disable != null);
    return enable(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result enable(_Enable value),
    Result disable(_Disable value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (enable != null) {
      return enable(this);
    }
    return orElse();
  }
}

abstract class _Enable implements FeedSecurityState {
  const factory _Enable() = _$_Enable;
}

/// @nodoc
abstract class _$DisableCopyWith<$Res> {
  factory _$DisableCopyWith(_Disable value, $Res Function(_Disable) then) =
      __$DisableCopyWithImpl<$Res>;
}

/// @nodoc
class __$DisableCopyWithImpl<$Res> extends _$FeedSecurityStateCopyWithImpl<$Res>
    implements _$DisableCopyWith<$Res> {
  __$DisableCopyWithImpl(_Disable _value, $Res Function(_Disable) _then)
      : super(_value, (v) => _then(v as _Disable));

  @override
  _Disable get _value => super._value as _Disable;
}

/// @nodoc
class _$_Disable with DiagnosticableTreeMixin implements _Disable {
  const _$_Disable();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FeedSecurityState.disable()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'FeedSecurityState.disable'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Disable);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result enable(),
    @required Result disable(),
  }) {
    assert(enable != null);
    assert(disable != null);
    return disable();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result enable(),
    Result disable(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (disable != null) {
      return disable();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result enable(_Enable value),
    @required Result disable(_Disable value),
  }) {
    assert(enable != null);
    assert(disable != null);
    return disable(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result enable(_Enable value),
    Result disable(_Disable value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (disable != null) {
      return disable(this);
    }
    return orElse();
  }
}

abstract class _Disable implements FeedSecurityState {
  const factory _Disable() = _$_Disable;
}
