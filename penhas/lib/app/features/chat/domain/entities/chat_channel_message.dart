import 'package:email_validator/email_validator.dart';

import 'chat_message_entity.dart';

enum ChatChannelMessageType { warning, text }

class ChatChannelMessage {
  ChatChannelMessage({
    required this.content,
    required this.type,
  });

  final ChatMessageEntity content;
  final ChatChannelMessageType type;
}
