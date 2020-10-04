import 'package:meta/meta.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_session_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_message_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_user_entity.dart';

class ChatChannelSessionModel extends ChatChannelSessionEntity {
  final bool hasMore;
  final String newer;
  final String older;
  final List<ChatMessageEntity> messages;
  final ChatChannelSessionMetadataEntity metadata;
  final ChatUserEntity user;

  ChatChannelSessionModel({
    @required this.hasMore,
    @required this.newer,
    @required this.older,
    @required this.messages,
    @required this.metadata,
    @required this.user,
  });
}

class ChatChannelSessionMetadataModel extends ChatChannelSessionMetadataEntity {
  final bool canSendMessage;
  final bool didBlocked;
  final String headerMessage;
  final String headerWarning;
  final bool isBlockable;
  final String lastMessageEtag;

  ChatChannelSessionMetadataModel({
    @required this.canSendMessage,
    @required this.didBlocked,
    @required this.headerMessage,
    @required this.headerWarning,
    @required this.isBlockable,
    @required this.lastMessageEtag,
  });
}
