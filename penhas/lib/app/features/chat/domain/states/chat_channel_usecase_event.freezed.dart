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
}

/// @nodoc
// ignore: unused_element
const $ChatChannelUseCaseEvent = _$ChatChannelUseCaseEventTearOff();

/// @nodoc
mixin _$ChatChannelUseCaseEvent {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
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
  }) {
    assert(initial != null);
    return initial();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
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
  }) {
    assert(initial != null);
    return initial(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
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
