import '../../domain/entities/chat_channel_session_entity.dart';
import 'chat_message_model.dart';
import 'chat_user_model.dart';

class ChatChannelSessionModel extends ChatChannelSessionEntity {
  const ChatChannelSessionModel({
    required bool? hasMore,
    required String? newer,
    required String? older,
    required List<ChatMessageModel>? messages,
    required ChatChannelSessionMetadataModel? metadata,
    required ChatUserModel? user,
  }) : super(
          hasMore: hasMore,
          newer: newer,
          older: older,
          messages: messages,
          metadata: metadata,
          user: user,
        );

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
    required bool canSendMessage,
    required bool didBlocked,
    required String? headerMessage,
    required String? headerWarning,
    required bool isBlockable,
    required String? lastMessageEtag,
  }) : super(
          canSendMessage: canSendMessage,
          didBlocked: didBlocked,
          headerMessage: headerMessage,
          headerWarning: headerWarning,
          isBlockable: isBlockable,
          lastMessageEtag: lastMessageEtag,
        );

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
