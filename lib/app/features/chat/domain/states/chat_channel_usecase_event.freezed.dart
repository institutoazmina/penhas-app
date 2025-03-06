// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'chat_channel_usecase_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$_InitialCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$ChatChannelUseCaseEventCopyWithImpl<$Res>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, (v) => _then(v as _$_Initial));

  @override
  _$_Initial get _value => super._value as _$_Initial;
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'ChatChannelUseCaseEvent.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Initial);
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
abstract class _$$_LoadedCopyWith<$Res> {
  factory _$$_LoadedCopyWith(_$_Loaded value, $Res Function(_$_Loaded) then) =
      __$$_LoadedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoadedCopyWithImpl<$Res>
    extends _$ChatChannelUseCaseEventCopyWithImpl<$Res>
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
    return 'ChatChannelUseCaseEvent.loaded()';
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
abstract class _$$_UpdateUserCopyWith<$Res> {
  factory _$$_UpdateUserCopyWith(
          _$_UpdateUser value, $Res Function(_$_UpdateUser) then) =
      __$$_UpdateUserCopyWithImpl<$Res>;
  $Res call({ChatUserEntity user});
}

/// @nodoc
class __$$_UpdateUserCopyWithImpl<$Res>
    extends _$ChatChannelUseCaseEventCopyWithImpl<$Res>
    implements _$$_UpdateUserCopyWith<$Res> {
  __$$_UpdateUserCopyWithImpl(
      _$_UpdateUser _value, $Res Function(_$_UpdateUser) _then)
      : super(_value, (v) => _then(v as _$_UpdateUser));

  @override
  _$_UpdateUser get _value => super._value as _$_UpdateUser;

  @override
  $Res call({
    Object? user = freezed,
  }) {
    return _then(_$_UpdateUser(
      user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as ChatUserEntity,
    ));
  }
}

/// @nodoc

class _$_UpdateUser implements _UpdateUser {
  const _$_UpdateUser(this.user);

  @override
  final ChatUserEntity user;

  @override
  String toString() {
    return 'ChatChannelUseCaseEvent.updateUser(user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UpdateUser &&
            const DeepCollectionEquality().equals(other.user, user));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(user));

  @JsonKey(ignore: true)
  @override
  _$$_UpdateUserCopyWith<_$_UpdateUser> get copyWith =>
      __$$_UpdateUserCopyWithImpl<_$_UpdateUser>(this, _$identity);

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
  const factory _UpdateUser(final ChatUserEntity user) = _$_UpdateUser;

  ChatUserEntity get user;
  @JsonKey(ignore: true)
  _$$_UpdateUserCopyWith<_$_UpdateUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_UpdateMetadataCopyWith<$Res> {
  factory _$$_UpdateMetadataCopyWith(
          _$_UpdateMetadata value, $Res Function(_$_UpdateMetadata) then) =
      __$$_UpdateMetadataCopyWithImpl<$Res>;
  $Res call({ChatChannelSessionMetadataEntity metadata});
}

/// @nodoc
class __$$_UpdateMetadataCopyWithImpl<$Res>
    extends _$ChatChannelUseCaseEventCopyWithImpl<$Res>
    implements _$$_UpdateMetadataCopyWith<$Res> {
  __$$_UpdateMetadataCopyWithImpl(
      _$_UpdateMetadata _value, $Res Function(_$_UpdateMetadata) _then)
      : super(_value, (v) => _then(v as _$_UpdateMetadata));

  @override
  _$_UpdateMetadata get _value => super._value as _$_UpdateMetadata;

  @override
  $Res call({
    Object? metadata = freezed,
  }) {
    return _then(_$_UpdateMetadata(
      metadata == freezed
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as ChatChannelSessionMetadataEntity,
    ));
  }
}

/// @nodoc

class _$_UpdateMetadata implements _UpdateMetadata {
  const _$_UpdateMetadata(this.metadata);

  @override
  final ChatChannelSessionMetadataEntity metadata;

  @override
  String toString() {
    return 'ChatChannelUseCaseEvent.updateMetadata(metadata: $metadata)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UpdateMetadata &&
            const DeepCollectionEquality().equals(other.metadata, metadata));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(metadata));

  @JsonKey(ignore: true)
  @override
  _$$_UpdateMetadataCopyWith<_$_UpdateMetadata> get copyWith =>
      __$$_UpdateMetadataCopyWithImpl<_$_UpdateMetadata>(this, _$identity);

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
  const factory _UpdateMetadata(
      final ChatChannelSessionMetadataEntity metadata) = _$_UpdateMetadata;

  ChatChannelSessionMetadataEntity get metadata;
  @JsonKey(ignore: true)
  _$$_UpdateMetadataCopyWith<_$_UpdateMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_UpdateMessageCopyWith<$Res> {
  factory _$$_UpdateMessageCopyWith(
          _$_UpdateMessage value, $Res Function(_$_UpdateMessage) then) =
      __$$_UpdateMessageCopyWithImpl<$Res>;
  $Res call({List<ChatChannelMessage> messages});
}

/// @nodoc
class __$$_UpdateMessageCopyWithImpl<$Res>
    extends _$ChatChannelUseCaseEventCopyWithImpl<$Res>
    implements _$$_UpdateMessageCopyWith<$Res> {
  __$$_UpdateMessageCopyWithImpl(
      _$_UpdateMessage _value, $Res Function(_$_UpdateMessage) _then)
      : super(_value, (v) => _then(v as _$_UpdateMessage));

  @override
  _$_UpdateMessage get _value => super._value as _$_UpdateMessage;

  @override
  $Res call({
    Object? messages = freezed,
  }) {
    return _then(_$_UpdateMessage(
      messages == freezed
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<ChatChannelMessage>,
    ));
  }
}

/// @nodoc

class _$_UpdateMessage implements _UpdateMessage {
  const _$_UpdateMessage(final List<ChatChannelMessage> messages)
      : _messages = messages;

  final List<ChatChannelMessage> _messages;
  @override
  List<ChatChannelMessage> get messages {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'ChatChannelUseCaseEvent.updateMessage(messages: $messages)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UpdateMessage &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_messages));

  @JsonKey(ignore: true)
  @override
  _$$_UpdateMessageCopyWith<_$_UpdateMessage> get copyWith =>
      __$$_UpdateMessageCopyWithImpl<_$_UpdateMessage>(this, _$identity);

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
  const factory _UpdateMessage(final List<ChatChannelMessage> messages) =
      _$_UpdateMessage;

  List<ChatChannelMessage> get messages;
  @JsonKey(ignore: true)
  _$$_UpdateMessageCopyWith<_$_UpdateMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ErrorOnLoadingCopyWith<$Res> {
  factory _$$_ErrorOnLoadingCopyWith(
          _$_ErrorOnLoading value, $Res Function(_$_ErrorOnLoading) then) =
      __$$_ErrorOnLoadingCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$$_ErrorOnLoadingCopyWithImpl<$Res>
    extends _$ChatChannelUseCaseEventCopyWithImpl<$Res>
    implements _$$_ErrorOnLoadingCopyWith<$Res> {
  __$$_ErrorOnLoadingCopyWithImpl(
      _$_ErrorOnLoading _value, $Res Function(_$_ErrorOnLoading) _then)
      : super(_value, (v) => _then(v as _$_ErrorOnLoading));

  @override
  _$_ErrorOnLoading get _value => super._value as _$_ErrorOnLoading;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$_ErrorOnLoading(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ErrorOnLoading implements _ErrorOnLoading {
  const _$_ErrorOnLoading(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ChatChannelUseCaseEvent.errorOnLoading(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ErrorOnLoading &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$_ErrorOnLoadingCopyWith<_$_ErrorOnLoading> get copyWith =>
      __$$_ErrorOnLoadingCopyWithImpl<_$_ErrorOnLoading>(this, _$identity);

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
  const factory _ErrorOnLoading(final String message) = _$_ErrorOnLoading;

  String get message;
  @JsonKey(ignore: true)
  _$$_ErrorOnLoadingCopyWith<_$_ErrorOnLoading> get copyWith =>
      throw _privateConstructorUsedError;
}
