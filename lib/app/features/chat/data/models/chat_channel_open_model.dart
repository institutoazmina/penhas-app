import '../../domain/entities/chat_channel_open_entity.dart';
import 'chat_channel_session_model.dart';

class ChatChannelOpenModel extends ChatChannelOpenEntity {
  const ChatChannelOpenModel({
    required super.token,
    required ChatChannelSessionModel? super.session,
  });

  factory ChatChannelOpenModel.fromJson(Map<String, dynamic> jsonData) =>
      ChatChannelOpenModel(
        token: jsonData['chat_auth'],
        session: ChatChannelSessionModel.fromJson(jsonData['prefetch']),
      );
}
