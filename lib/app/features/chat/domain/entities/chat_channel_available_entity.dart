import 'package:equatable/equatable.dart';

import 'chat_assistant_entity.dart';
import 'chat_channel_entity.dart';

class ChatChannelAvailableEntity extends Equatable {
  const ChatChannelAvailableEntity({
    required this.hasMore,
    required this.nextPage,
    required this.channels,
    required this.support,
    required this.assistant,
  });

  final bool? hasMore;
  final String? nextPage;
  final List<ChatChannelEntity>? channels;
  final ChatChannelEntity? support;
  final ChatAssistantEntity? assistant;

  @override
  List<Object?> get props => [
        hasMore,
        nextPage,
        channels,
        support,
        assistant,
      ];
}
