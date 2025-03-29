// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_channel_usecase_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
    TResult? Function()? initial,
    TResult? Function()? loaded,
    TResult? Function(ChatUserEntity user)? updateUser,
    TResult? Function(ChatChannelSessionMetadataEntity metadata)?
        updateMetadata,
    TResult? Function(List<ChatChannelMessage> messages)? updateMessage,
    TResult? Function(String message)? errorOnLoading,
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
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_UpdateUser value)? updateUser,
    TResult? Function(_UpdateMetadata value)? updateMetadata,
    TResult? Function(_UpdateMessage value)? updateMessage,
    TResult? Function(_ErrorOnLoading value)? errorOnLoading,
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
      _$ChatChannelUseCaseEventCopyWithImpl<$Res, ChatChannelUseCaseEvent>;
}

/// @nodoc
class _$ChatChannelUseCaseEventCopyWithImpl<$Res,
        $Val extends ChatChannelUseCaseEvent>
    implements $ChatChannelUseCaseEventCopyWith<$Res> {
  _$ChatChannelUseCaseEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatChannelUseCaseEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$ChatChannelUseCaseEventCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatChannelUseCaseEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'ChatChannelUseCaseEvent.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
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
    TResult? Function()? initial,
    TResult? Function()? loaded,
    TResult? Function(ChatUserEntity user)? updateUser,
    TResult? Function(ChatChannelSessionMetadataEntity metadata)?
        updateMetadata,
    TResult? Function(List<ChatChannelMessage> messages)? updateMessage,
    TResult? Function(String message)? errorOnLoading,
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
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_UpdateUser value)? updateUser,
    TResult? Function(_UpdateMetadata value)? updateMetadata,
    TResult? Function(_UpdateMessage value)? updateMessage,
    TResult? Function(_ErrorOnLoading value)? errorOnLoading,
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
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$ChatChannelUseCaseEventCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatChannelUseCaseEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl();

  @override
  String toString() {
    return 'ChatChannelUseCaseEvent.loaded()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadedImpl);
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
    TResult? Function()? initial,
    TResult? Function()? loaded,
    TResult? Function(ChatUserEntity user)? updateUser,
    TResult? Function(ChatChannelSessionMetadataEntity metadata)?
        updateMetadata,
    TResult? Function(List<ChatChannelMessage> messages)? updateMessage,
    TResult? Function(String message)? errorOnLoading,
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
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_UpdateUser value)? updateUser,
    TResult? Function(_UpdateMetadata value)? updateMetadata,
    TResult? Function(_UpdateMessage value)? updateMessage,
    TResult? Function(_ErrorOnLoading value)? errorOnLoading,
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
  const factory _Loaded() = _$LoadedImpl;
}

/// @nodoc
abstract class _$$UpdateUserImplCopyWith<$Res> {
  factory _$$UpdateUserImplCopyWith(
          _$UpdateUserImpl value, $Res Function(_$UpdateUserImpl) then) =
      __$$UpdateUserImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ChatUserEntity user});
}

/// @nodoc
class __$$UpdateUserImplCopyWithImpl<$Res>
    extends _$ChatChannelUseCaseEventCopyWithImpl<$Res, _$UpdateUserImpl>
    implements _$$UpdateUserImplCopyWith<$Res> {
  __$$UpdateUserImplCopyWithImpl(
      _$UpdateUserImpl _value, $Res Function(_$UpdateUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatChannelUseCaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$UpdateUserImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as ChatUserEntity,
    ));
  }
}

/// @nodoc

class _$UpdateUserImpl implements _UpdateUser {
  const _$UpdateUserImpl(this.user);

  @override
  final ChatUserEntity user;

  @override
  String toString() {
    return 'ChatChannelUseCaseEvent.updateUser(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateUserImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  /// Create a copy of ChatChannelUseCaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateUserImplCopyWith<_$UpdateUserImpl> get copyWith =>
      __$$UpdateUserImplCopyWithImpl<_$UpdateUserImpl>(this, _$identity);

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
    TResult? Function()? initial,
    TResult? Function()? loaded,
    TResult? Function(ChatUserEntity user)? updateUser,
    TResult? Function(ChatChannelSessionMetadataEntity metadata)?
        updateMetadata,
    TResult? Function(List<ChatChannelMessage> messages)? updateMessage,
    TResult? Function(String message)? errorOnLoading,
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
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_UpdateUser value)? updateUser,
    TResult? Function(_UpdateMetadata value)? updateMetadata,
    TResult? Function(_UpdateMessage value)? updateMessage,
    TResult? Function(_ErrorOnLoading value)? errorOnLoading,
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
  const factory _UpdateUser(final ChatUserEntity user) = _$UpdateUserImpl;

  ChatUserEntity get user;

  /// Create a copy of ChatChannelUseCaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateUserImplCopyWith<_$UpdateUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateMetadataImplCopyWith<$Res> {
  factory _$$UpdateMetadataImplCopyWith(_$UpdateMetadataImpl value,
          $Res Function(_$UpdateMetadataImpl) then) =
      __$$UpdateMetadataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ChatChannelSessionMetadataEntity metadata});
}

/// @nodoc
class __$$UpdateMetadataImplCopyWithImpl<$Res>
    extends _$ChatChannelUseCaseEventCopyWithImpl<$Res, _$UpdateMetadataImpl>
    implements _$$UpdateMetadataImplCopyWith<$Res> {
  __$$UpdateMetadataImplCopyWithImpl(
      _$UpdateMetadataImpl _value, $Res Function(_$UpdateMetadataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatChannelUseCaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? metadata = null,
  }) {
    return _then(_$UpdateMetadataImpl(
      null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as ChatChannelSessionMetadataEntity,
    ));
  }
}

/// @nodoc

class _$UpdateMetadataImpl implements _UpdateMetadata {
  const _$UpdateMetadataImpl(this.metadata);

  @override
  final ChatChannelSessionMetadataEntity metadata;

  @override
  String toString() {
    return 'ChatChannelUseCaseEvent.updateMetadata(metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateMetadataImpl &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata));
  }

  @override
  int get hashCode => Object.hash(runtimeType, metadata);

  /// Create a copy of ChatChannelUseCaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateMetadataImplCopyWith<_$UpdateMetadataImpl> get copyWith =>
      __$$UpdateMetadataImplCopyWithImpl<_$UpdateMetadataImpl>(
          this, _$identity);

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
    TResult? Function()? initial,
    TResult? Function()? loaded,
    TResult? Function(ChatUserEntity user)? updateUser,
    TResult? Function(ChatChannelSessionMetadataEntity metadata)?
        updateMetadata,
    TResult? Function(List<ChatChannelMessage> messages)? updateMessage,
    TResult? Function(String message)? errorOnLoading,
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
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_UpdateUser value)? updateUser,
    TResult? Function(_UpdateMetadata value)? updateMetadata,
    TResult? Function(_UpdateMessage value)? updateMessage,
    TResult? Function(_ErrorOnLoading value)? errorOnLoading,
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
      final ChatChannelSessionMetadataEntity metadata) = _$UpdateMetadataImpl;

  ChatChannelSessionMetadataEntity get metadata;

  /// Create a copy of ChatChannelUseCaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateMetadataImplCopyWith<_$UpdateMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateMessageImplCopyWith<$Res> {
  factory _$$UpdateMessageImplCopyWith(
          _$UpdateMessageImpl value, $Res Function(_$UpdateMessageImpl) then) =
      __$$UpdateMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ChatChannelMessage> messages});
}

/// @nodoc
class __$$UpdateMessageImplCopyWithImpl<$Res>
    extends _$ChatChannelUseCaseEventCopyWithImpl<$Res, _$UpdateMessageImpl>
    implements _$$UpdateMessageImplCopyWith<$Res> {
  __$$UpdateMessageImplCopyWithImpl(
      _$UpdateMessageImpl _value, $Res Function(_$UpdateMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatChannelUseCaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
  }) {
    return _then(_$UpdateMessageImpl(
      null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<ChatChannelMessage>,
    ));
  }
}

/// @nodoc

class _$UpdateMessageImpl implements _UpdateMessage {
  const _$UpdateMessageImpl(final List<ChatChannelMessage> messages)
      : _messages = messages;

  final List<ChatChannelMessage> _messages;
  @override
  List<ChatChannelMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'ChatChannelUseCaseEvent.updateMessage(messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateMessageImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_messages));

  /// Create a copy of ChatChannelUseCaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateMessageImplCopyWith<_$UpdateMessageImpl> get copyWith =>
      __$$UpdateMessageImplCopyWithImpl<_$UpdateMessageImpl>(this, _$identity);

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
    TResult? Function()? initial,
    TResult? Function()? loaded,
    TResult? Function(ChatUserEntity user)? updateUser,
    TResult? Function(ChatChannelSessionMetadataEntity metadata)?
        updateMetadata,
    TResult? Function(List<ChatChannelMessage> messages)? updateMessage,
    TResult? Function(String message)? errorOnLoading,
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
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_UpdateUser value)? updateUser,
    TResult? Function(_UpdateMetadata value)? updateMetadata,
    TResult? Function(_UpdateMessage value)? updateMessage,
    TResult? Function(_ErrorOnLoading value)? errorOnLoading,
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
      _$UpdateMessageImpl;

  List<ChatChannelMessage> get messages;

  /// Create a copy of ChatChannelUseCaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateMessageImplCopyWith<_$UpdateMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorOnLoadingImplCopyWith<$Res> {
  factory _$$ErrorOnLoadingImplCopyWith(_$ErrorOnLoadingImpl value,
          $Res Function(_$ErrorOnLoadingImpl) then) =
      __$$ErrorOnLoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorOnLoadingImplCopyWithImpl<$Res>
    extends _$ChatChannelUseCaseEventCopyWithImpl<$Res, _$ErrorOnLoadingImpl>
    implements _$$ErrorOnLoadingImplCopyWith<$Res> {
  __$$ErrorOnLoadingImplCopyWithImpl(
      _$ErrorOnLoadingImpl _value, $Res Function(_$ErrorOnLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatChannelUseCaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorOnLoadingImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorOnLoadingImpl implements _ErrorOnLoading {
  const _$ErrorOnLoadingImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ChatChannelUseCaseEvent.errorOnLoading(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorOnLoadingImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ChatChannelUseCaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorOnLoadingImplCopyWith<_$ErrorOnLoadingImpl> get copyWith =>
      __$$ErrorOnLoadingImplCopyWithImpl<_$ErrorOnLoadingImpl>(
          this, _$identity);

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
    TResult? Function()? initial,
    TResult? Function()? loaded,
    TResult? Function(ChatUserEntity user)? updateUser,
    TResult? Function(ChatChannelSessionMetadataEntity metadata)?
        updateMetadata,
    TResult? Function(List<ChatChannelMessage> messages)? updateMessage,
    TResult? Function(String message)? errorOnLoading,
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
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_UpdateUser value)? updateUser,
    TResult? Function(_UpdateMetadata value)? updateMetadata,
    TResult? Function(_UpdateMessage value)? updateMessage,
    TResult? Function(_ErrorOnLoading value)? errorOnLoading,
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
  const factory _ErrorOnLoading(final String message) = _$ErrorOnLoadingImpl;

  String get message;

  /// Create a copy of ChatChannelUseCaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorOnLoadingImplCopyWith<_$ErrorOnLoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
