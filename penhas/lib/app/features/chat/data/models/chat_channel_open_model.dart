import 'package:penhas/app/features/chat/domain/entities/chat_channel_open_entity.dart';

class ChatChannelOpenModel extends ChatChannelOpenEntity {
  ChatChannelOpenModel({
    required String? token,
    required ChatChannelSessionModel? session,
  }) : super(
          token: token,
          session: session,
        );

  factory ChatChannelOpenModel.fromJson(Map<String, dynamic> jsonData) =>
      ChatChannelOpenModel(
        token: jsonData["chat_auth"],
        session: ChatChannelSessionModel.fromJson(jsonData["prefetch"]),
      );
}
