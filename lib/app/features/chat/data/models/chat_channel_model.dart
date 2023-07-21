import '../../domain/entities/chat_channel_entity.dart';
import 'chat_user_model.dart';

class ChatChannelModel extends ChatChannelEntity {
  const ChatChannelModel({
    required String? token,
    required DateTime lastMessageTime,
    required bool lastMessageIsMime,
    required ChatUserModel user,
  }) : super(
          token: token,
          lastMessageIsMime: lastMessageIsMime,
          lastMessageTime: lastMessageTime,
          user: user,
        );

  factory ChatChannelModel.fromJson(Map<String, dynamic> jsonData) =>
      ChatChannelModel(
        token: jsonData['chat_auth'],
        lastMessageTime: DateTime.parse(jsonData['last_message_at'] as String),
        lastMessageIsMime: jsonData['last_message_is_me'] == 1,
        user: ChatUserModel.fromJson(jsonData),
      );
}
