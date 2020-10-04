import 'package:meta/meta.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_open_entity.dart';

import 'chat_channel_session_model.dart';

class ChatChannelOpenModel extends ChatChannelOpenEntity {
  final String token;
  final ChatChannelSessionModel session;

  ChatChannelOpenModel({
    @required this.token,
    @required this.session,
  }) : super(
          token: token,
          session: session,
        );

  ChatChannelOpenModel.fromJson(Map<String, Object> jsonData)
      : token = jsonData["chat_auth"],
        session = ChatChannelSessionModel.fromJson(jsonData["prefetch"]);
}
