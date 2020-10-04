import 'package:meta/meta.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_entity.dart';

import 'chat_user_model.dart';

class ChatChannelModel extends ChatChannelEntity {
  final String token;
  final DateTime lastMessageTime;
  final bool lastMessageIsMime;
  final ChatUserModel user;

  ChatChannelModel({
    @required this.token,
    @required this.lastMessageTime,
    @required this.lastMessageIsMime,
    @required this.user,
  }) : super(
          token: token,
          lastMessageIsMime: lastMessageIsMime,
          lastMessageTime: lastMessageTime,
          user: user,
        );

  ChatChannelModel.fromJson(Map<String, Object> jsonData)
      : token = jsonData["chat_auth"],
        lastMessageTime = DateTime.parse(jsonData["last_message_at"]),
        lastMessageIsMime = jsonData["last_message_is_me"] == 1,
        user = ChatUserModel.fromJson(jsonData);
}
