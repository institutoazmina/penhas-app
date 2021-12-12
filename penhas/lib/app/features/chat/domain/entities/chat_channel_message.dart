<<<<<<< HEAD
import 'package:penhas/app/features/chat/domain/entities/chat_message_entity.dart';
=======
import 'package:email_validator/email_validator.dart';

import 'chat_message_entity.dart';
>>>>>>> Fix code syntax

enum ChatChannelMessageType { warning, text }

class ChatChannelMessage {
  ChatChannelMessage({
    required this.content,
    required this.type,
  });

  final ChatMessageEntity content;
  final ChatChannelMessageType type;
}
