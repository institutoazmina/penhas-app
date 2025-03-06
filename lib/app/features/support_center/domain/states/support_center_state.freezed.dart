// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'support_center_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$_LoadedCopyWith<$Res> {
  factory _$$_LoadedCopyWith(_$_Loaded value, $Res Function(_$_Loaded) then) =
      __$$_LoadedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoadedCopyWithImpl<$Res>
    extends _$SupportCenterStateCopyWithImpl<$Res>
    implements _$$_LoadedCopyWith<$Res> {
  __$$_LoadedCopyWithImpl(_$_Loaded _value, $Res Function(_$_Loaded) _then)
      : super(_value, (v) => _then(v as _$_Loaded));

  @override
  _$_Loaded get _value => super._value as _$_Loaded;
}

/// @nodoc

class _$_Loaded implements _Loaded {
  const _$_Loaded();

  @override
  String toString() {
    return 'SupportCenterState.loaded()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Loaded);
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
abstract class _$$_ErrorDetailsCopyWith<$Res> {
  factory _$$_ErrorDetailsCopyWith(
          _$_ErrorDetails value, $Res Function(_$_ErrorDetails) then) =
      __$$_ErrorDetailsCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$$_ErrorDetailsCopyWithImpl<$Res>
    extends _$SupportCenterStateCopyWithImpl<$Res>
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
    return 'SupportCenterState.error(message: $message)';
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
  const factory _ErrorDetails(final String message) = _$_ErrorDetails;

  String get message;
  @JsonKey(ignore: true)
  _$$_ErrorDetailsCopyWith<_$_ErrorDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_GpsErrorCopyWith<$Res> {
  factory _$$_GpsErrorCopyWith(
          _$_GpsError value, $Res Function(_$_GpsError) then) =
      __$$_GpsErrorCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$$_GpsErrorCopyWithImpl<$Res>
    extends _$SupportCenterStateCopyWithImpl<$Res>
    implements _$$_GpsErrorCopyWith<$Res> {
  __$$_GpsErrorCopyWithImpl(
      _$_GpsError _value, $Res Function(_$_GpsError) _then)
      : super(_value, (v) => _then(v as _$_GpsError));

  @override
  _$_GpsError get _value => super._value as _$_GpsError;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$_GpsError(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_GpsError implements _GpsError {
  const _$_GpsError(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'SupportCenterState.gpsError(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GpsError &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$_GpsErrorCopyWith<_$_GpsError> get copyWith =>
      __$$_GpsErrorCopyWithImpl<_$_GpsError>(this, _$identity);

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
  const factory _GpsError(final String message) = _$_GpsError;

  String get message;
  @JsonKey(ignore: true)
  _$$_GpsErrorCopyWith<_$_GpsError> get copyWith =>
      throw _privateConstructorUsedError;
}
