// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'support_center_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$SupportCenterStateTearOff {
  const _$SupportCenterStateTearOff();

// ignore: unused_element
  _Loaded loaded() {
    return const _Loaded();
  }

// ignore: unused_element
  _ErrorDetails error(String message) {
    return _ErrorDetails(
      message,
    );
  }

// ignore: unused_element
  _GpsError gpsError(String message) {
    return _GpsError(
      message,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $SupportCenterState = _$SupportCenterStateTearOff();

/// @nodoc
mixin _$SupportCenterState {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loaded(),
    @required TResult error(String message),
    @required TResult gpsError(String message),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult loaded(),
    TResult error(String message),
    TResult gpsError(String message),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult loaded(_Loaded value),
    @required TResult error(_ErrorDetails value),
    @required TResult gpsError(_GpsError value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult loaded(_Loaded value),
    TResult error(_ErrorDetails value),
    TResult gpsError(_GpsError value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $SupportCenterStateCopyWith<$Res> {
  factory $SupportCenterStateCopyWith(
          SupportCenterState value, $Res Function(SupportCenterState) then) =
      _$SupportCenterStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$SupportCenterStateCopyWithImpl<$Res>
    implements $SupportCenterStateCopyWith<$Res> {
  _$SupportCenterStateCopyWithImpl(this._value, this._then);

  final SupportCenterState _value;
  // ignore: unused_field
  final $Res Function(SupportCenterState) _then;
}

/// @nodoc
abstract class _$LoadedCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) then) =
      __$LoadedCopyWithImpl<$Res>;
}

/// @nodoc
class __$LoadedCopyWithImpl<$Res> extends _$SupportCenterStateCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(_Loaded _value, $Res Function(_Loaded) _then)
      : super(_value, (v) => _then(v as _Loaded));

  @override
  _Loaded get _value => super._value as _Loaded;
}

/// @nodoc
class _$_Loaded with DiagnosticableTreeMixin implements _Loaded {
  const _$_Loaded();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SupportCenterState.loaded()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'SupportCenterState.loaded'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Loaded);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loaded(),
    @required TResult error(String message),
    @required TResult gpsError(String message),
  }) {
    assert(loaded != null);
    assert(error != null);
    assert(gpsError != null);
    return loaded();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult loaded(),
    TResult error(String message),
    TResult gpsError(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loaded != null) {
      return loaded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult loaded(_Loaded value),
    @required TResult error(_ErrorDetails value),
    @required TResult gpsError(_GpsError value),
  }) {
    assert(loaded != null);
    assert(error != null);
    assert(gpsError != null);
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult loaded(_Loaded value),
    TResult error(_ErrorDetails value),
    TResult gpsError(_GpsError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements SupportCenterState {
  const factory _Loaded() = _$_Loaded;
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
    extends _$SupportCenterStateCopyWithImpl<$Res>
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
class _$_ErrorDetails with DiagnosticableTreeMixin implements _ErrorDetails {
  const _$_ErrorDetails(this.message) : assert(message != null);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SupportCenterState.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SupportCenterState.error'))
      ..add(DiagnosticsProperty('message', message));
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
    @required TResult loaded(),
    @required TResult error(String message),
    @required TResult gpsError(String message),
  }) {
    assert(loaded != null);
    assert(error != null);
    assert(gpsError != null);
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult loaded(),
    TResult error(String message),
    TResult gpsError(String message),
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
    @required TResult loaded(_Loaded value),
    @required TResult error(_ErrorDetails value),
    @required TResult gpsError(_GpsError value),
  }) {
    assert(loaded != null);
    assert(error != null);
    assert(gpsError != null);
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult loaded(_Loaded value),
    TResult error(_ErrorDetails value),
    TResult gpsError(_GpsError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ErrorDetails implements SupportCenterState {
  const factory _ErrorDetails(String message) = _$_ErrorDetails;

  String get message;
  @JsonKey(ignore: true)
  _$ErrorDetailsCopyWith<_ErrorDetails> get copyWith;
}

/// @nodoc
abstract class _$GpsErrorCopyWith<$Res> {
  factory _$GpsErrorCopyWith(_GpsError value, $Res Function(_GpsError) then) =
      __$GpsErrorCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$GpsErrorCopyWithImpl<$Res>
    extends _$SupportCenterStateCopyWithImpl<$Res>
    implements _$GpsErrorCopyWith<$Res> {
  __$GpsErrorCopyWithImpl(_GpsError _value, $Res Function(_GpsError) _then)
      : super(_value, (v) => _then(v as _GpsError));

  @override
  _GpsError get _value => super._value as _GpsError;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(_GpsError(
      message == freezed ? _value.message : message as String,
    ));
  }
}

/// @nodoc
class _$_GpsError with DiagnosticableTreeMixin implements _GpsError {
  const _$_GpsError(this.message) : assert(message != null);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SupportCenterState.gpsError(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SupportCenterState.gpsError'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GpsError &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  _$GpsErrorCopyWith<_GpsError> get copyWith =>
      __$GpsErrorCopyWithImpl<_GpsError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loaded(),
    @required TResult error(String message),
    @required TResult gpsError(String message),
  }) {
    assert(loaded != null);
    assert(error != null);
    assert(gpsError != null);
    return gpsError(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult loaded(),
    TResult error(String message),
    TResult gpsError(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (gpsError != null) {
      return gpsError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult loaded(_Loaded value),
    @required TResult error(_ErrorDetails value),
    @required TResult gpsError(_GpsError value),
  }) {
    assert(loaded != null);
    assert(error != null);
    assert(gpsError != null);
    return gpsError(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult loaded(_Loaded value),
    TResult error(_ErrorDetails value),
    TResult gpsError(_GpsError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (gpsError != null) {
      return gpsError(this);
    }
    return orElse();
  }
}

abstract class _GpsError implements SupportCenterState {
  const factory _GpsError(String message) = _$_GpsError;

  String get message;
  @JsonKey(ignore: true)
  _$GpsErrorCopyWith<_GpsError> get copyWith;
}
