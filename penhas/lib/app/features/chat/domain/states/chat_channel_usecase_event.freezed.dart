// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'chat_channel_usecase_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$ChatChannelUseCaseEventTearOff {
  const _$ChatChannelUseCaseEventTearOff();

// ignore: unused_element
  _Initial initial() {
    return const _Initial();
  }

// ignore: unused_element
  _ErrorOnLoading errorOnLoading(String message) {
    return _ErrorOnLoading(
      message,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ChatChannelUseCaseEvent = _$ChatChannelUseCaseEventTearOff();

/// @nodoc
mixin _$ChatChannelUseCaseEvent {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result errorOnLoading(String message),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result errorOnLoading(String message),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result errorOnLoading(_ErrorOnLoading value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result errorOnLoading(_ErrorOnLoading value),
    @required Result orElse(),
  });
}

/// @nodoc
abstract class $ChatChannelUseCaseEventCopyWith<$Res> {
  factory $ChatChannelUseCaseEventCopyWith(ChatChannelUseCaseEvent value,
          $Res Function(ChatChannelUseCaseEvent) then) =
      _$ChatChannelUseCaseEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ChatChannelUseCaseEventCopyWithImpl<$Res>
    implements $ChatChannelUseCaseEventCopyWith<$Res> {
  _$ChatChannelUseCaseEventCopyWithImpl(this._value, this._then);

  final ChatChannelUseCaseEvent _value;
  // ignore: unused_field
  final $Res Function(ChatChannelUseCaseEvent) _then;
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res>
    extends _$ChatChannelUseCaseEventCopyWithImpl<$Res>
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
    return 'ChatChannelUseCaseEvent.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatChannelUseCaseEvent.initial'));
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
    @required Result errorOnLoading(String message),
  }) {
    assert(initial != null);
    assert(errorOnLoading != null);
    return initial();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result errorOnLoading(String message),
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
    @required Result errorOnLoading(_ErrorOnLoading value),
  }) {
    assert(initial != null);
    assert(errorOnLoading != null);
    return initial(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result errorOnLoading(_ErrorOnLoading value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ChatChannelUseCaseEvent {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$ErrorOnLoadingCopyWith<$Res> {
  factory _$ErrorOnLoadingCopyWith(
          _ErrorOnLoading value, $Res Function(_ErrorOnLoading) then) =
      __$ErrorOnLoadingCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$ErrorOnLoadingCopyWithImpl<$Res>
    extends _$ChatChannelUseCaseEventCopyWithImpl<$Res>
    implements _$ErrorOnLoadingCopyWith<$Res> {
  __$ErrorOnLoadingCopyWithImpl(
      _ErrorOnLoading _value, $Res Function(_ErrorOnLoading) _then)
      : super(_value, (v) => _then(v as _ErrorOnLoading));

  @override
  _ErrorOnLoading get _value => super._value as _ErrorOnLoading;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(_ErrorOnLoading(
      message == freezed ? _value.message : message as String,
    ));
  }
}

/// @nodoc
class _$_ErrorOnLoading
    with DiagnosticableTreeMixin
    implements _ErrorOnLoading {
  const _$_ErrorOnLoading(this.message) : assert(message != null);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatChannelUseCaseEvent.errorOnLoading(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
          DiagnosticsProperty('type', 'ChatChannelUseCaseEvent.errorOnLoading'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ErrorOnLoading &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @override
  _$ErrorOnLoadingCopyWith<_ErrorOnLoading> get copyWith =>
      __$ErrorOnLoadingCopyWithImpl<_ErrorOnLoading>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result errorOnLoading(String message),
  }) {
    assert(initial != null);
    assert(errorOnLoading != null);
    return errorOnLoading(message);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result errorOnLoading(String message),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (errorOnLoading != null) {
      return errorOnLoading(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result errorOnLoading(_ErrorOnLoading value),
  }) {
    assert(initial != null);
    assert(errorOnLoading != null);
    return errorOnLoading(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result errorOnLoading(_ErrorOnLoading value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (errorOnLoading != null) {
      return errorOnLoading(this);
    }
    return orElse();
  }
}

abstract class _ErrorOnLoading implements ChatChannelUseCaseEvent {
  const factory _ErrorOnLoading(String message) = _$_ErrorOnLoading;

  String get message;
  _$ErrorOnLoadingCopyWith<_ErrorOnLoading> get copyWith;
}
