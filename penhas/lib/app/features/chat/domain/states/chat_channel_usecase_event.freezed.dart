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
  _Loaded loaded() {
    return const _Loaded();
  }

// ignore: unused_element
  _UpdateUser updateUser(ChatUserEntity user) {
    return _UpdateUser(
      user,
    );
  }

// ignore: unused_element
  _UpdateMetada updateMetada(ChatChannelSessionMetadataEntity metadata) {
    return _UpdateMetada(
      metadata,
    );
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
    @required Result loaded(),
    @required Result updateUser(ChatUserEntity user),
    @required Result updateMetada(ChatChannelSessionMetadataEntity metadata),
    @required Result errorOnLoading(String message),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result loaded(),
    Result updateUser(ChatUserEntity user),
    Result updateMetada(ChatChannelSessionMetadataEntity metadata),
    Result errorOnLoading(String message),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result loaded(_Loaded value),
    @required Result updateUser(_UpdateUser value),
    @required Result updateMetada(_UpdateMetada value),
    @required Result errorOnLoading(_ErrorOnLoading value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result loaded(_Loaded value),
    Result updateUser(_UpdateUser value),
    Result updateMetada(_UpdateMetada value),
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
    @required Result loaded(),
    @required Result updateUser(ChatUserEntity user),
    @required Result updateMetada(ChatChannelSessionMetadataEntity metadata),
    @required Result errorOnLoading(String message),
  }) {
    assert(initial != null);
    assert(loaded != null);
    assert(updateUser != null);
    assert(updateMetada != null);
    assert(errorOnLoading != null);
    return initial();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result loaded(),
    Result updateUser(ChatUserEntity user),
    Result updateMetada(ChatChannelSessionMetadataEntity metadata),
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
    @required Result loaded(_Loaded value),
    @required Result updateUser(_UpdateUser value),
    @required Result updateMetada(_UpdateMetada value),
    @required Result errorOnLoading(_ErrorOnLoading value),
  }) {
    assert(initial != null);
    assert(loaded != null);
    assert(updateUser != null);
    assert(updateMetada != null);
    assert(errorOnLoading != null);
    return initial(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result loaded(_Loaded value),
    Result updateUser(_UpdateUser value),
    Result updateMetada(_UpdateMetada value),
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
abstract class _$LoadedCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) then) =
      __$LoadedCopyWithImpl<$Res>;
}

/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    extends _$ChatChannelUseCaseEventCopyWithImpl<$Res>
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
    return 'ChatChannelUseCaseEvent.loaded()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatChannelUseCaseEvent.loaded'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Loaded);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result loaded(),
    @required Result updateUser(ChatUserEntity user),
    @required Result updateMetada(ChatChannelSessionMetadataEntity metadata),
    @required Result errorOnLoading(String message),
  }) {
    assert(initial != null);
    assert(loaded != null);
    assert(updateUser != null);
    assert(updateMetada != null);
    assert(errorOnLoading != null);
    return loaded();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result loaded(),
    Result updateUser(ChatUserEntity user),
    Result updateMetada(ChatChannelSessionMetadataEntity metadata),
    Result errorOnLoading(String message),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loaded != null) {
      return loaded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result loaded(_Loaded value),
    @required Result updateUser(_UpdateUser value),
    @required Result updateMetada(_UpdateMetada value),
    @required Result errorOnLoading(_ErrorOnLoading value),
  }) {
    assert(initial != null);
    assert(loaded != null);
    assert(updateUser != null);
    assert(updateMetada != null);
    assert(errorOnLoading != null);
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result loaded(_Loaded value),
    Result updateUser(_UpdateUser value),
    Result updateMetada(_UpdateMetada value),
    Result errorOnLoading(_ErrorOnLoading value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements ChatChannelUseCaseEvent {
  const factory _Loaded() = _$_Loaded;
}

/// @nodoc
abstract class _$UpdateUserCopyWith<$Res> {
  factory _$UpdateUserCopyWith(
          _UpdateUser value, $Res Function(_UpdateUser) then) =
      __$UpdateUserCopyWithImpl<$Res>;
  $Res call({ChatUserEntity user});
}

/// @nodoc
class __$UpdateUserCopyWithImpl<$Res>
    extends _$ChatChannelUseCaseEventCopyWithImpl<$Res>
    implements _$UpdateUserCopyWith<$Res> {
  __$UpdateUserCopyWithImpl(
      _UpdateUser _value, $Res Function(_UpdateUser) _then)
      : super(_value, (v) => _then(v as _UpdateUser));

  @override
  _UpdateUser get _value => super._value as _UpdateUser;

  @override
  $Res call({
    Object user = freezed,
  }) {
    return _then(_UpdateUser(
      user == freezed ? _value.user : user as ChatUserEntity,
    ));
  }
}

/// @nodoc
class _$_UpdateUser with DiagnosticableTreeMixin implements _UpdateUser {
  const _$_UpdateUser(this.user) : assert(user != null);

  @override
  final ChatUserEntity user;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatChannelUseCaseEvent.updateUser(user: $user)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatChannelUseCaseEvent.updateUser'))
      ..add(DiagnosticsProperty('user', user));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UpdateUser &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(user);

  @override
  _$UpdateUserCopyWith<_UpdateUser> get copyWith =>
      __$UpdateUserCopyWithImpl<_UpdateUser>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result loaded(),
    @required Result updateUser(ChatUserEntity user),
    @required Result updateMetada(ChatChannelSessionMetadataEntity metadata),
    @required Result errorOnLoading(String message),
  }) {
    assert(initial != null);
    assert(loaded != null);
    assert(updateUser != null);
    assert(updateMetada != null);
    assert(errorOnLoading != null);
    return updateUser(user);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result loaded(),
    Result updateUser(ChatUserEntity user),
    Result updateMetada(ChatChannelSessionMetadataEntity metadata),
    Result errorOnLoading(String message),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (updateUser != null) {
      return updateUser(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result loaded(_Loaded value),
    @required Result updateUser(_UpdateUser value),
    @required Result updateMetada(_UpdateMetada value),
    @required Result errorOnLoading(_ErrorOnLoading value),
  }) {
    assert(initial != null);
    assert(loaded != null);
    assert(updateUser != null);
    assert(updateMetada != null);
    assert(errorOnLoading != null);
    return updateUser(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result loaded(_Loaded value),
    Result updateUser(_UpdateUser value),
    Result updateMetada(_UpdateMetada value),
    Result errorOnLoading(_ErrorOnLoading value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (updateUser != null) {
      return updateUser(this);
    }
    return orElse();
  }
}

abstract class _UpdateUser implements ChatChannelUseCaseEvent {
  const factory _UpdateUser(ChatUserEntity user) = _$_UpdateUser;

  ChatUserEntity get user;
  _$UpdateUserCopyWith<_UpdateUser> get copyWith;
}

/// @nodoc
abstract class _$UpdateMetadaCopyWith<$Res> {
  factory _$UpdateMetadaCopyWith(
          _UpdateMetada value, $Res Function(_UpdateMetada) then) =
      __$UpdateMetadaCopyWithImpl<$Res>;
  $Res call({ChatChannelSessionMetadataEntity metadata});
}

/// @nodoc
class __$UpdateMetadaCopyWithImpl<$Res>
    extends _$ChatChannelUseCaseEventCopyWithImpl<$Res>
    implements _$UpdateMetadaCopyWith<$Res> {
  __$UpdateMetadaCopyWithImpl(
      _UpdateMetada _value, $Res Function(_UpdateMetada) _then)
      : super(_value, (v) => _then(v as _UpdateMetada));

  @override
  _UpdateMetada get _value => super._value as _UpdateMetada;

  @override
  $Res call({
    Object metadata = freezed,
  }) {
    return _then(_UpdateMetada(
      metadata == freezed
          ? _value.metadata
          : metadata as ChatChannelSessionMetadataEntity,
    ));
  }
}

/// @nodoc
class _$_UpdateMetada with DiagnosticableTreeMixin implements _UpdateMetada {
  const _$_UpdateMetada(this.metadata) : assert(metadata != null);

  @override
  final ChatChannelSessionMetadataEntity metadata;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatChannelUseCaseEvent.updateMetada(metadata: $metadata)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatChannelUseCaseEvent.updateMetada'))
      ..add(DiagnosticsProperty('metadata', metadata));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UpdateMetada &&
            (identical(other.metadata, metadata) ||
                const DeepCollectionEquality()
                    .equals(other.metadata, metadata)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(metadata);

  @override
  _$UpdateMetadaCopyWith<_UpdateMetada> get copyWith =>
      __$UpdateMetadaCopyWithImpl<_UpdateMetada>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result loaded(),
    @required Result updateUser(ChatUserEntity user),
    @required Result updateMetada(ChatChannelSessionMetadataEntity metadata),
    @required Result errorOnLoading(String message),
  }) {
    assert(initial != null);
    assert(loaded != null);
    assert(updateUser != null);
    assert(updateMetada != null);
    assert(errorOnLoading != null);
    return updateMetada(metadata);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result loaded(),
    Result updateUser(ChatUserEntity user),
    Result updateMetada(ChatChannelSessionMetadataEntity metadata),
    Result errorOnLoading(String message),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (updateMetada != null) {
      return updateMetada(metadata);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result loaded(_Loaded value),
    @required Result updateUser(_UpdateUser value),
    @required Result updateMetada(_UpdateMetada value),
    @required Result errorOnLoading(_ErrorOnLoading value),
  }) {
    assert(initial != null);
    assert(loaded != null);
    assert(updateUser != null);
    assert(updateMetada != null);
    assert(errorOnLoading != null);
    return updateMetada(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result loaded(_Loaded value),
    Result updateUser(_UpdateUser value),
    Result updateMetada(_UpdateMetada value),
    Result errorOnLoading(_ErrorOnLoading value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (updateMetada != null) {
      return updateMetada(this);
    }
    return orElse();
  }
}

abstract class _UpdateMetada implements ChatChannelUseCaseEvent {
  const factory _UpdateMetada(ChatChannelSessionMetadataEntity metadata) =
      _$_UpdateMetada;

  ChatChannelSessionMetadataEntity get metadata;
  _$UpdateMetadaCopyWith<_UpdateMetada> get copyWith;
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
    @required Result loaded(),
    @required Result updateUser(ChatUserEntity user),
    @required Result updateMetada(ChatChannelSessionMetadataEntity metadata),
    @required Result errorOnLoading(String message),
  }) {
    assert(initial != null);
    assert(loaded != null);
    assert(updateUser != null);
    assert(updateMetada != null);
    assert(errorOnLoading != null);
    return errorOnLoading(message);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result loaded(),
    Result updateUser(ChatUserEntity user),
    Result updateMetada(ChatChannelSessionMetadataEntity metadata),
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
    @required Result loaded(_Loaded value),
    @required Result updateUser(_UpdateUser value),
    @required Result updateMetada(_UpdateMetada value),
    @required Result errorOnLoading(_ErrorOnLoading value),
  }) {
    assert(initial != null);
    assert(loaded != null);
    assert(updateUser != null);
    assert(updateMetada != null);
    assert(errorOnLoading != null);
    return errorOnLoading(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result loaded(_Loaded value),
    Result updateUser(_UpdateUser value),
    Result updateMetada(_UpdateMetada value),
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
