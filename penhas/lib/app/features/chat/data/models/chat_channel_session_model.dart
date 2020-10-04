import 'package:meta/meta.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_session_entity.dart';

import 'chat_user_model.dart';
import 'chat_message_model.dart';

class ChatChannelSessionModel extends ChatChannelSessionEntity {
  final bool hasMore;
  final String newer;
  final String older;
  final List<ChatMessageModel> messages;
  final ChatChannelSessionMetadataModel metadata;
  final ChatUserModel user;

  ChatChannelSessionModel({
    @required this.hasMore,
    @required this.newer,
    @required this.older,
    @required this.messages,
    @required this.metadata,
    @required this.user,
  }) : super(
          hasMore: hasMore,
          newer: newer,
          older: older,
          messages: messages,
          metadata: metadata,
          user: user,
        );

  factory ChatChannelSessionModel.fromJson(Map<String, Object> jsonData) {
    final List<Object> jsonMessages = jsonData["messages"];
    final List<ChatMessageModel> messages = jsonMessages
        .map((e) => e as Map<String, Object>)
        .map((e) => ChatMessageModel.fromJson(e))
        .where((e) => e != null)
        .toList();

    return ChatChannelSessionModel(
      hasMore: jsonData["has_more"] == 1,
      newer: jsonData["newer"],
      older: jsonData["older"],
      messages: messages,
      metadata: ChatChannelSessionMetadataModel.fromJson(jsonData["meta"]),
      user: ChatUserModel.fromJson(jsonData["other"]),
    );
  }
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
  }) : super(
          canSendMessage: canSendMessage,
          didBlocked: didBlocked,
          headerMessage: headerMessage,
          headerWarning: headerWarning,
          isBlockable: isBlockable,
          lastMessageEtag: lastMessageEtag,
        );

  ChatChannelSessionMetadataModel.fromJson(Map<String, Object> jsonData)
      : canSendMessage = jsonData["can_send_message"] == 1,
        didBlocked = jsonData["did_blocked"] == 1,
        headerMessage = jsonData["header_message"],
        headerWarning = jsonData["header_warning"],
        isBlockable = jsonData["is_blockable"] == 1,
        lastMessageEtag = jsonData["last_msg_etag"];
}
