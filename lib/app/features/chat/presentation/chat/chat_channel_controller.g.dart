// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_channel_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatChannelController on _ChatChannelControllerBase, Store {
  Computed<ChatChannelComposerType>? _$composerTypeComputed;

  @override
  ChatChannelComposerType get composerType => (_$composerTypeComputed ??=
          Computed<ChatChannelComposerType>(() => super.composerType,
              name: '_ChatChannelControllerBase.composerType'))
      .value;

  late final _$currentStateAtom =
      Atom(name: '_ChatChannelControllerBase.currentState', context: context);

  @override
  ChatChannelState get currentState {
    _$currentStateAtom.reportRead();
    return super.currentState;
  }

  @override
  set currentState(ChatChannelState value) {
    _$currentStateAtom.reportWrite(value, super.currentState, () {
      super.currentState = value;
    });
  }

  late final _$userAtom =
      Atom(name: '_ChatChannelControllerBase.user', context: context);

  @override
  ChatUserEntity get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(ChatUserEntity value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$metadataAtom =
      Atom(name: '_ChatChannelControllerBase.metadata', context: context);

  @override
  ChatChannelSessionMetadataEntity get metadata {
    _$metadataAtom.reportRead();
    return super.metadata;
  }

  @override
  set metadata(ChatChannelSessionMetadataEntity value) {
    _$metadataAtom.reportWrite(value, super.metadata, () {
      super.metadata = value;
    });
  }

  late final _$channelMessagesAtom = Atom(
      name: '_ChatChannelControllerBase.channelMessages', context: context);

  @override
  ObservableList<ChatChannelMessage> get channelMessages {
    _$channelMessagesAtom.reportRead();
    return super.channelMessages;
  }

  @override
  set channelMessages(ObservableList<ChatChannelMessage> value) {
    _$channelMessagesAtom.reportWrite(value, super.channelMessages, () {
      super.channelMessages = value;
    });
  }

  late final _$blockChatAsyncAction =
      AsyncAction('_ChatChannelControllerBase.blockChat', context: context);

  @override
  Future<void> blockChat() {
    return _$blockChatAsyncAction.run(() => super.blockChat());
  }

  late final _$unBlockChatAsyncAction =
      AsyncAction('_ChatChannelControllerBase.unBlockChat', context: context);

  @override
  Future<void> unBlockChat() {
    return _$unBlockChatAsyncAction.run(() => super.unBlockChat());
  }

  late final _$deleteSessionAsyncAction =
      AsyncAction('_ChatChannelControllerBase.deleteSession', context: context);

  @override
  Future<void> deleteSession() {
    return _$deleteSessionAsyncAction.run(() => super.deleteSession());
  }

  late final _$sentMessageAsyncAction =
      AsyncAction('_ChatChannelControllerBase.sentMessage', context: context);

  @override
  Future<void> sentMessage(String message) {
    return _$sentMessageAsyncAction.run(() => super.sentMessage(message));
  }

  @override
  String toString() {
    return '''
currentState: ${currentState},
user: ${user},
metadata: ${metadata},
channelMessages: ${channelMessages},
composerType: ${composerType}
    ''';
  }
}
