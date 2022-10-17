// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'support_center_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SupportCenterStateTearOff {
  const _$SupportCenterStateTearOff();

  _Loaded loaded() {
    return const _Loaded();
  }

  _ErrorDetails error(String message) {
    return _ErrorDetails(
      message,
    );
  }

  _GpsError gpsError(String message) {
    return _GpsError(
      message,
    );
  }
}

/// @nodoc
const $SupportCenterState = _$SupportCenterStateTearOff();

/// @nodoc
mixin _$SupportCenterState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loaded,
    required TResult Function(String message) error,
    required TResult Function(String message) gpsError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function(String message)? error,
    TResult Function(String message)? gpsError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function(String message)? error,
    TResult Function(String message)? gpsError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ErrorDetails value) error,
    required TResult Function(_GpsError value) gpsError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ErrorDetails value)? error,
    TResult Function(_GpsError value)? gpsError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ErrorDetails value)? error,
    TResult Function(_GpsError value)? gpsError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
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
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Loaded);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loaded,
    required TResult Function(String message) error,
    required TResult Function(String message) gpsError,
  }) {
    return loaded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function(String message)? error,
    TResult Function(String message)? gpsError,
  }) {
    return loaded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function(String message)? error,
    TResult Function(String message)? gpsError,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ErrorDetails value) error,
    required TResult Function(_GpsError value) gpsError,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ErrorDetails value)? error,
    TResult Function(_GpsError value)? gpsError,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ErrorDetails value)? error,
    TResult Function(_GpsError value)? gpsError,
    required TResult orElse(),
  }) {
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

class _$_ErrorDetails with DiagnosticableTreeMixin implements _ErrorDetails {
  const _$_ErrorDetails(this.message);

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
    required TResult Function() loaded,
    required TResult Function(String message) error,
    required TResult Function(String message) gpsError,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function(String message)? error,
    TResult Function(String message)? gpsError,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function(String message)? error,
    TResult Function(String message)? gpsError,
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
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ErrorDetails value) error,
    required TResult Function(_GpsError value) gpsError,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ErrorDetails value)? error,
    TResult Function(_GpsError value)? gpsError,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ErrorDetails value)? error,
    TResult Function(_GpsError value)? gpsError,
    required TResult orElse(),
  }) {
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
  _$ErrorDetailsCopyWith<_ErrorDetails> get copyWith =>
      throw _privateConstructorUsedError;
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
    Object? message = freezed,
  }) {
    return _then(_GpsError(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_GpsError with DiagnosticableTreeMixin implements _GpsError {
  const _$_GpsError(this.message);

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
        (other.runtimeType == runtimeType &&
            other is _GpsError &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$GpsErrorCopyWith<_GpsError> get copyWith =>
      __$GpsErrorCopyWithImpl<_GpsError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loaded,
    required TResult Function(String message) error,
    required TResult Function(String message) gpsError,
  }) {
    return gpsError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function(String message)? error,
    TResult Function(String message)? gpsError,
  }) {
    return gpsError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function(String message)? error,
    TResult Function(String message)? gpsError,
    required TResult orElse(),
  }) {
    if (gpsError != null) {
      return gpsError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ErrorDetails value) error,
    required TResult Function(_GpsError value) gpsError,
  }) {
    return gpsError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ErrorDetails value)? error,
    TResult Function(_GpsError value)? gpsError,
  }) {
    return gpsError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ErrorDetails value)? error,
    TResult Function(_GpsError value)? gpsError,
    required TResult orElse(),
  }) {
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
  _$GpsErrorCopyWith<_GpsError> get copyWith =>
      throw _privateConstructorUsedError;
}
