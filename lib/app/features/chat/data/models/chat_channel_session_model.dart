import '../../domain/entities/chat_channel_session_entity.dart';
import 'chat_message_model.dart';
import 'chat_user_model.dart';

class ChatChannelSessionModel extends ChatChannelSessionEntity {
  const ChatChannelSessionModel({
    required super.hasMore,
    required super.newer,
    required super.older,
    required List<ChatMessageModel>? super.messages,
    required ChatChannelSessionMetadataModel? super.metadata,
    required ChatUserModel? super.user,
  });

  factory ChatChannelSessionModel.fromJson(Map<String, dynamic> jsonData) {
    final List jsonMessages = jsonData['messages'];
    final List<ChatMessageModel> messages =
        jsonMessages.map((e) => ChatMessageModel.fromJson(e)).toList();

    return ChatChannelSessionModel(
      hasMore: jsonData['has_more'] == 1,
      newer: jsonData['newer'],
      older: jsonData['older'],
      messages: messages,
      metadata: ChatChannelSessionMetadataModel.fromJson(jsonData['meta']),
      user: ChatUserModel.fromJson(jsonData['other']),
    );
  }
}

class ChatChannelSessionMetadataModel extends ChatChannelSessionMetadataEntity {
  const ChatChannelSessionMetadataModel({
    required super.canSendMessage,
    required super.didBlocked,
    required super.headerMessage,
    required super.headerWarning,
    required super.isBlockable,
    required super.lastMessageEtag,
  });

  factory ChatChannelSessionMetadataModel.fromJson(
    Map<String, dynamic> jsonData,
  ) =>
      ChatChannelSessionMetadataModel(
        canSendMessage: jsonData['can_send_message'] == 1,
        didBlocked: jsonData['did_blocked'] == 1,
        headerMessage: jsonData['header_message'],
        headerWarning: jsonData['header_warning'],
        isBlockable: jsonData['is_blockable'] == 1,
        lastMessageEtag: jsonData['last_msg_etag'],
      );
}
