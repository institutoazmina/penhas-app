// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'chat_channel_usecase_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ChatChannelUseCaseEventTearOff {
  const _$ChatChannelUseCaseEventTearOff();

  _Initial initial() {
    return const _Initial();
  }

  _Loaded loaded() {
    return const _Loaded();
  }

  _UpdateUser updateUser(ChatUserEntity user) {
    return _UpdateUser(
      user,
    );
  }

  _UpdateMetadata updateMetadata(ChatChannelSessionMetadataEntity metadata) {
    return _UpdateMetadata(
      metadata,
    );
  }

  _UpdateMessage updateMessage(List<ChatChannelMessage> messages) {
    return _UpdateMessage(
      messages,
    );
  }

  _ErrorOnLoading errorOnLoading(String message) {
    return _ErrorOnLoading(
      message,
    );
  }
}

/// @nodoc
const $ChatChannelUseCaseEvent = _$ChatChannelUseCaseEventTearOff();

/// @nodoc
mixin _$ChatChannelUseCaseEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loaded,
    required TResult Function(ChatUserEntity user) updateUser,
    required TResult Function(ChatChannelSessionMetadataEntity metadata)
        updateMetadata,
    required TResult Function(List<ChatChannelMessage> messages) updateMessage,
    required TResult Function(String message) errorOnLoading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loaded,
    TResult Function(ChatUserEntity user)? updateUser,
    TResult Function(ChatChannelSessionMetadataEntity metadata)? updateMetadata,
    TResult Function(List<ChatChannelMessage> messages)? updateMessage,
    TResult Function(String message)? errorOnLoading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loaded,
    TResult Function(ChatUserEntity user)? updateUser,
    TResult Function(ChatChannelSessionMetadataEntity metadata)? updateMetadata,
    TResult Function(List<ChatChannelMessage> messages)? updateMessage,
    TResult Function(String message)? errorOnLoading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_UpdateUser value) updateUser,
    required TResult Function(_UpdateMetadata value) updateMetadata,
    required TResult Function(_UpdateMessage value) updateMessage,
    required TResult Function(_ErrorOnLoading value) errorOnLoading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_UpdateUser value)? updateUser,
    TResult Function(_UpdateMetadata value)? updateMetadata,
    TResult Function(_UpdateMessage value)? updateMessage,
    TResult Function(_ErrorOnLoading value)? errorOnLoading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_UpdateUser value)? updateUser,
    TResult Function(_UpdateMetadata value)? updateMetadata,
    TResult Function(_UpdateMessage value)? updateMessage,
    TResult Function(_ErrorOnLoading value)? errorOnLoading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
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
        .add(DiagnosticsProperty('type', 'ChatChannelUseCaseEvent.initial'));
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
    required TResult Function() loaded,
    required TResult Function(ChatUserEntity user) updateUser,
    required TResult Function(ChatChannelSessionMetadataEntity metadata)
        updateMetadata,
    required TResult Function(List<ChatChannelMessage> messages) updateMessage,
    required TResult Function(String message) errorOnLoading,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loaded,
    TResult Function(ChatUserEntity user)? updateUser,
    TResult Function(ChatChannelSessionMetadataEntity metadata)? updateMetadata,
    TResult Function(List<ChatChannelMessage> messages)? updateMessage,
    TResult Function(String message)? errorOnLoading,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loaded,
    TResult Function(ChatUserEntity user)? updateUser,
    TResult Function(ChatChannelSessionMetadataEntity metadata)? updateMetadata,
    TResult Function(List<ChatChannelMessage> messages)? updateMessage,
    TResult Function(String message)? errorOnLoading,
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
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_UpdateUser value) updateUser,
    required TResult Function(_UpdateMetadata value) updateMetadata,
    required TResult Function(_UpdateMessage value) updateMessage,
    required TResult Function(_ErrorOnLoading value) errorOnLoading,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_UpdateUser value)? updateUser,
    TResult Function(_UpdateMetadata value)? updateMetadata,
    TResult Function(_UpdateMessage value)? updateMessage,
    TResult Function(_ErrorOnLoading value)? errorOnLoading,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_UpdateUser value)? updateUser,
    TResult Function(_UpdateMetadata value)? updateMetadata,
    TResult Function(_UpdateMessage value)? updateMessage,
    TResult Function(_ErrorOnLoading value)? errorOnLoading,
    required TResult orElse(),
  }) {
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
        .add(DiagnosticsProperty('type', 'ChatChannelUseCaseEvent.loaded'));
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
    required TResult Function() initial,
    required TResult Function() loaded,
    required TResult Function(ChatUserEntity user) updateUser,
    required TResult Function(ChatChannelSessionMetadataEntity metadata)
        updateMetadata,
    required TResult Function(List<ChatChannelMessage> messages) updateMessage,
    required TResult Function(String message) errorOnLoading,
  }) {
    return loaded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loaded,
    TResult Function(ChatUserEntity user)? updateUser,
    TResult Function(ChatChannelSessionMetadataEntity metadata)? updateMetadata,
    TResult Function(List<ChatChannelMessage> messages)? updateMessage,
    TResult Function(String message)? errorOnLoading,
  }) {
    return loaded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loaded,
    TResult Function(ChatUserEntity user)? updateUser,
    TResult Function(ChatChannelSessionMetadataEntity metadata)? updateMetadata,
    TResult Function(List<ChatChannelMessage> messages)? updateMessage,
    TResult Function(String message)? errorOnLoading,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_UpdateUser value) updateUser,
    required TResult Function(_UpdateMetadata value) updateMetadata,
    required TResult Function(_UpdateMessage value) updateMessage,
    required TResult Function(_ErrorOnLoading value) errorOnLoading,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_UpdateUser value)? updateUser,
    TResult Function(_UpdateMetadata value)? updateMetadata,
    TResult Function(_UpdateMessage value)? updateMessage,
    TResult Function(_ErrorOnLoading value)? errorOnLoading,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_UpdateUser value)? updateUser,
    TResult Function(_UpdateMetadata value)? updateMetadata,
    TResult Function(_UpdateMessage value)? updateMessage,
    TResult Function(_ErrorOnLoading value)? errorOnLoading,
    required TResult orElse(),
  }) {
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
    Object? user = freezed,
  }) {
    return _then(_UpdateUser(
      user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as ChatUserEntity,
    ));
  }
}

/// @nodoc

class _$_UpdateUser with DiagnosticableTreeMixin implements _UpdateUser {
  const _$_UpdateUser(this.user);

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
        (other.runtimeType == runtimeType &&
            other is _UpdateUser &&
            const DeepCollectionEquality().equals(other.user, user));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(user));

  @JsonKey(ignore: true)
  @override
  _$UpdateUserCopyWith<_UpdateUser> get copyWith =>
      __$UpdateUserCopyWithImpl<_UpdateUser>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loaded,
    required TResult Function(ChatUserEntity user) updateUser,
    required TResult Function(ChatChannelSessionMetadataEntity metadata)
        updateMetadata,
    required TResult Function(List<ChatChannelMessage> messages) updateMessage,
    required TResult Function(String message) errorOnLoading,
  }) {
    return updateUser(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loaded,
    TResult Function(ChatUserEntity user)? updateUser,
    TResult Function(ChatChannelSessionMetadataEntity metadata)? updateMetadata,
    TResult Function(List<ChatChannelMessage> messages)? updateMessage,
    TResult Function(String message)? errorOnLoading,
  }) {
    return updateUser?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loaded,
    TResult Function(ChatUserEntity user)? updateUser,
    TResult Function(ChatChannelSessionMetadataEntity metadata)? updateMetadata,
    TResult Function(List<ChatChannelMessage> messages)? updateMessage,
    TResult Function(String message)? errorOnLoading,
    required TResult orElse(),
  }) {
    if (updateUser != null) {
      return updateUser(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_UpdateUser value) updateUser,
    required TResult Function(_UpdateMetadata value) updateMetadata,
    required TResult Function(_UpdateMessage value) updateMessage,
    required TResult Function(_ErrorOnLoading value) errorOnLoading,
  }) {
    return updateUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_UpdateUser value)? updateUser,
    TResult Function(_UpdateMetadata value)? updateMetadata,
    TResult Function(_UpdateMessage value)? updateMessage,
    TResult Function(_ErrorOnLoading value)? errorOnLoading,
  }) {
    return updateUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_UpdateUser value)? updateUser,
    TResult Function(_UpdateMetadata value)? updateMetadata,
    TResult Function(_UpdateMessage value)? updateMessage,
    TResult Function(_ErrorOnLoading value)? errorOnLoading,
    required TResult orElse(),
  }) {
    if (updateUser != null) {
      return updateUser(this);
    }
    return orElse();
  }
}

abstract class _UpdateUser implements ChatChannelUseCaseEvent {
  const factory _UpdateUser(ChatUserEntity user) = _$_UpdateUser;

  ChatUserEntity get user;
  @JsonKey(ignore: true)
  _$UpdateUserCopyWith<_UpdateUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$UpdateMetadataCopyWith<$Res> {
  factory _$UpdateMetadataCopyWith(
          _UpdateMetadata value, $Res Function(_UpdateMetadata) then) =
      __$UpdateMetadataCopyWithImpl<$Res>;
  $Res call({ChatChannelSessionMetadataEntity metadata});
}

/// @nodoc
class __$UpdateMetadataCopyWithImpl<$Res>
    extends _$ChatChannelUseCaseEventCopyWithImpl<$Res>
    implements _$UpdateMetadataCopyWith<$Res> {
  __$UpdateMetadataCopyWithImpl(
      _UpdateMetadata _value, $Res Function(_UpdateMetadata) _then)
      : super(_value, (v) => _then(v as _UpdateMetadata));

  @override
  _UpdateMetadata get _value => super._value as _UpdateMetadata;

  @override
  $Res call({
    Object? metadata = freezed,
  }) {
    return _then(_UpdateMetadata(
      metadata == freezed
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as ChatChannelSessionMetadataEntity,
    ));
  }
}

/// @nodoc

class _$_UpdateMetadata
    with DiagnosticableTreeMixin
    implements _UpdateMetadata {
  const _$_UpdateMetadata(this.metadata);

  @override
  final ChatChannelSessionMetadataEntity metadata;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatChannelUseCaseEvent.updateMetadata(metadata: $metadata)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
          DiagnosticsProperty('type', 'ChatChannelUseCaseEvent.updateMetadata'))
      ..add(DiagnosticsProperty('metadata', metadata));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UpdateMetadata &&
            const DeepCollectionEquality().equals(other.metadata, metadata));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(metadata));

  @JsonKey(ignore: true)
  @override
  _$UpdateMetadataCopyWith<_UpdateMetadata> get copyWith =>
      __$UpdateMetadataCopyWithImpl<_UpdateMetadata>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loaded,
    required TResult Function(ChatUserEntity user) updateUser,
    required TResult Function(ChatChannelSessionMetadataEntity metadata)
        updateMetadata,
    required TResult Function(List<ChatChannelMessage> messages) updateMessage,
    required TResult Function(String message) errorOnLoading,
  }) {
    return updateMetadata(metadata);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loaded,
    TResult Function(ChatUserEntity user)? updateUser,
    TResult Function(ChatChannelSessionMetadataEntity metadata)? updateMetadata,
    TResult Function(List<ChatChannelMessage> messages)? updateMessage,
    TResult Function(String message)? errorOnLoading,
  }) {
    return updateMetadata?.call(metadata);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loaded,
    TResult Function(ChatUserEntity user)? updateUser,
    TResult Function(ChatChannelSessionMetadataEntity metadata)? updateMetadata,
    TResult Function(List<ChatChannelMessage> messages)? updateMessage,
    TResult Function(String message)? errorOnLoading,
    required TResult orElse(),
  }) {
    if (updateMetadata != null) {
      return updateMetadata(metadata);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_UpdateUser value) updateUser,
    required TResult Function(_UpdateMetadata value) updateMetadata,
    required TResult Function(_UpdateMessage value) updateMessage,
    required TResult Function(_ErrorOnLoading value) errorOnLoading,
  }) {
    return updateMetadata(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_UpdateUser value)? updateUser,
    TResult Function(_UpdateMetadata value)? updateMetadata,
    TResult Function(_UpdateMessage value)? updateMessage,
    TResult Function(_ErrorOnLoading value)? errorOnLoading,
  }) {
    return updateMetadata?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_UpdateUser value)? updateUser,
    TResult Function(_UpdateMetadata value)? updateMetadata,
    TResult Function(_UpdateMessage value)? updateMessage,
    TResult Function(_ErrorOnLoading value)? errorOnLoading,
    required TResult orElse(),
  }) {
    if (updateMetadata != null) {
      return updateMetadata(this);
    }
    return orElse();
  }
}

abstract class _UpdateMetadata implements ChatChannelUseCaseEvent {
  const factory _UpdateMetadata(ChatChannelSessionMetadataEntity metadata) =
      _$_UpdateMetadata;

  ChatChannelSessionMetadataEntity get metadata;
  @JsonKey(ignore: true)
  _$UpdateMetadataCopyWith<_UpdateMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$UpdateMessageCopyWith<$Res> {
  factory _$UpdateMessageCopyWith(
          _UpdateMessage value, $Res Function(_UpdateMessage) then) =
      __$UpdateMessageCopyWithImpl<$Res>;
  $Res call({List<ChatChannelMessage> messages});
}

/// @nodoc
class __$UpdateMessageCopyWithImpl<$Res>
    extends _$ChatChannelUseCaseEventCopyWithImpl<$Res>
    implements _$UpdateMessageCopyWith<$Res> {
  __$UpdateMessageCopyWithImpl(
      _UpdateMessage _value, $Res Function(_UpdateMessage) _then)
      : super(_value, (v) => _then(v as _UpdateMessage));

  @override
  _UpdateMessage get _value => super._value as _UpdateMessage;

  @override
  $Res call({
    Object? messages = freezed,
  }) {
    return _then(_UpdateMessage(
      messages == freezed
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<ChatChannelMessage>,
    ));
  }
}

/// @nodoc

class _$_UpdateMessage with DiagnosticableTreeMixin implements _UpdateMessage {
  const _$_UpdateMessage(this.messages);

  @override
  final List<ChatChannelMessage> messages;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatChannelUseCaseEvent.updateMessage(messages: $messages)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
          DiagnosticsProperty('type', 'ChatChannelUseCaseEvent.updateMessage'))
      ..add(DiagnosticsProperty('messages', messages));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UpdateMessage &&
            const DeepCollectionEquality().equals(other.messages, messages));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(messages));

  @JsonKey(ignore: true)
  @override
  _$UpdateMessageCopyWith<_UpdateMessage> get copyWith =>
      __$UpdateMessageCopyWithImpl<_UpdateMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loaded,
    required TResult Function(ChatUserEntity user) updateUser,
    required TResult Function(ChatChannelSessionMetadataEntity metadata)
        updateMetadata,
    required TResult Function(List<ChatChannelMessage> messages) updateMessage,
    required TResult Function(String message) errorOnLoading,
  }) {
    return updateMessage(messages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loaded,
    TResult Function(ChatUserEntity user)? updateUser,
    TResult Function(ChatChannelSessionMetadataEntity metadata)? updateMetadata,
    TResult Function(List<ChatChannelMessage> messages)? updateMessage,
    TResult Function(String message)? errorOnLoading,
  }) {
    return updateMessage?.call(messages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loaded,
    TResult Function(ChatUserEntity user)? updateUser,
    TResult Function(ChatChannelSessionMetadataEntity metadata)? updateMetadata,
    TResult Function(List<ChatChannelMessage> messages)? updateMessage,
    TResult Function(String message)? errorOnLoading,
    required TResult orElse(),
  }) {
    if (updateMessage != null) {
      return updateMessage(messages);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_UpdateUser value) updateUser,
    required TResult Function(_UpdateMetadata value) updateMetadata,
    required TResult Function(_UpdateMessage value) updateMessage,
    required TResult Function(_ErrorOnLoading value) errorOnLoading,
  }) {
    return updateMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_UpdateUser value)? updateUser,
    TResult Function(_UpdateMetadata value)? updateMetadata,
    TResult Function(_UpdateMessage value)? updateMessage,
    TResult Function(_ErrorOnLoading value)? errorOnLoading,
  }) {
    return updateMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_UpdateUser value)? updateUser,
    TResult Function(_UpdateMetadata value)? updateMetadata,
    TResult Function(_UpdateMessage value)? updateMessage,
    TResult Function(_ErrorOnLoading value)? errorOnLoading,
    required TResult orElse(),
  }) {
    if (updateMessage != null) {
      return updateMessage(this);
    }
    return orElse();
  }
}

abstract class _UpdateMessage implements ChatChannelUseCaseEvent {
  const factory _UpdateMessage(List<ChatChannelMessage> messages) =
      _$_UpdateMessage;

  List<ChatChannelMessage> get messages;
  @JsonKey(ignore: true)
  _$UpdateMessageCopyWith<_UpdateMessage> get copyWith =>
      throw _privateConstructorUsedError;
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
    Object? message = freezed,
  }) {
    return _then(_ErrorOnLoading(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ErrorOnLoading
    with DiagnosticableTreeMixin
    implements _ErrorOnLoading {
  const _$_ErrorOnLoading(this.message);

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
        (other.runtimeType == runtimeType &&
            other is _ErrorOnLoading &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$ErrorOnLoadingCopyWith<_ErrorOnLoading> get copyWith =>
      __$ErrorOnLoadingCopyWithImpl<_ErrorOnLoading>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loaded,
    required TResult Function(ChatUserEntity user) updateUser,
    required TResult Function(ChatChannelSessionMetadataEntity metadata)
        updateMetadata,
    required TResult Function(List<ChatChannelMessage> messages) updateMessage,
    required TResult Function(String message) errorOnLoading,
  }) {
    return errorOnLoading(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loaded,
    TResult Function(ChatUserEntity user)? updateUser,
    TResult Function(ChatChannelSessionMetadataEntity metadata)? updateMetadata,
    TResult Function(List<ChatChannelMessage> messages)? updateMessage,
    TResult Function(String message)? errorOnLoading,
  }) {
    return errorOnLoading?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loaded,
    TResult Function(ChatUserEntity user)? updateUser,
    TResult Function(ChatChannelSessionMetadataEntity metadata)? updateMetadata,
    TResult Function(List<ChatChannelMessage> messages)? updateMessage,
    TResult Function(String message)? errorOnLoading,
    required TResult orElse(),
  }) {
    if (errorOnLoading != null) {
      return errorOnLoading(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_UpdateUser value) updateUser,
    required TResult Function(_UpdateMetadata value) updateMetadata,
    required TResult Function(_UpdateMessage value) updateMessage,
    required TResult Function(_ErrorOnLoading value) errorOnLoading,
  }) {
    return errorOnLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_UpdateUser value)? updateUser,
    TResult Function(_UpdateMetadata value)? updateMetadata,
    TResult Function(_UpdateMessage value)? updateMessage,
    TResult Function(_ErrorOnLoading value)? errorOnLoading,
  }) {
    return errorOnLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_UpdateUser value)? updateUser,
    TResult Function(_UpdateMetadata value)? updateMetadata,
    TResult Function(_UpdateMessage value)? updateMessage,
    TResult Function(_ErrorOnLoading value)? errorOnLoading,
    required TResult orElse(),
  }) {
    if (errorOnLoading != null) {
      return errorOnLoading(this);
    }
    return orElse();
  }
}

abstract class _ErrorOnLoading implements ChatChannelUseCaseEvent {
  const factory _ErrorOnLoading(String message) = _$_ErrorOnLoading;

  String get message;
  @JsonKey(ignore: true)
  _$ErrorOnLoadingCopyWith<_ErrorOnLoading> get copyWith =>
      throw _privateConstructorUsedError;
}
