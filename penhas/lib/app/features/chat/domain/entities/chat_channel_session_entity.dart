import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'chat_message_entity.dart';
import 'chat_user_entity.dart';

class ChatChannelSessionEntity extends Equatable {
  final bool hasMore;
  final String newer;
  final String older;
  final List<ChatMessageEntity> messages;
  final ChatChannelSessionMetadataEntity metadata;
  final ChatUserEntity user;

  ChatChannelSessionEntity({
    @required this.hasMore,
    @required this.newer,
    @required this.older,
    @required this.messages,
    @required this.metadata,
    @required this.user,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        hasMore,
        newer,
        older,
        messages,
        metadata,
        user,
      ];
}

class ChatChannelSessionMetadataEntity extends Equatable {
  final bool canSendMessage;
  final bool didBlocked;
  final String headerMessage;
  final String headerWarning;
  final bool isBlockable;
  final String lastMessageEtag;

  ChatChannelSessionMetadataEntity({
    @required this.canSendMessage,
    @required this.didBlocked,
    @required this.headerMessage,
    @required this.headerWarning,
    @required this.isBlockable,
    @required this.lastMessageEtag,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        canSendMessage,
        didBlocked,
        headerMessage,
        headerWarning,
        isBlockable,
        lastMessageEtag,
      ];

  static ChatChannelSessionMetadataEntity get empty =>
      ChatChannelSessionMetadataEntity(
        didBlocked: false,
        isBlockable: false,
        canSendMessage: false,
        headerMessage: null,
        headerWarning: null,
        lastMessageEtag: null,
      );
}
