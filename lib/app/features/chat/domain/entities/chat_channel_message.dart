import 'package:penhas/app/features/chat/domain/entities/chat_message_entity.dart';

enum ChatChannelMessageType { warning, text }

class ChatChannelMessage {
  ChatChannelMessage({
    required this.content,
    required this.type,
  });

  final ChatMessageEntity content;
  final ChatChannelMessageType type;
}
