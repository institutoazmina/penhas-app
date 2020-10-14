import 'package:email_validator/email_validator.dart';
import 'package:meta/meta.dart';

import 'chat_message_entity.dart';

enum ChatChannelMessageType { warrning, text }

class ChatChannelMessage {
  final ChatMessageEntity content;
  final ChatChannelMessageType type;

  ChatChannelMessage({
    @required this.content,
    @required this.type,
  });
}
