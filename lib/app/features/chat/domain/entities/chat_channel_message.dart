import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'chat_message_entity.dart';

enum ChatChannelMessageType { warning, text }

@immutable
class ChatChannelMessage extends Equatable {
  const ChatChannelMessage({
    required this.content,
    required this.type,
  });

  final ChatMessageEntity content;
  final ChatChannelMessageType type;

  @override
  List<Object?> get props => [
        content,
        type,
      ];
}
