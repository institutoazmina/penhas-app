import 'package:penhas/app/features/chat/data/models/chat_channel_session_model.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_open_entity.dart';

class ChatChannelOpenModel extends ChatChannelOpenEntity {
  final String? token;
  final ChatChannelSessionModel? session;

  ChatChannelOpenModel({
    required this.token,
    required this.session,
  }) : super(
          token: token,
          session: session,
        );

  ChatChannelOpenModel.fromJson(Map<String, Object> jsonData)
      : token = jsonData["chat_auth"] as String?,
        session = ChatChannelSessionModel.fromJson(jsonData["prefetch"] as Map<String, Object>);
}
