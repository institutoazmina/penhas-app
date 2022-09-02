import 'package:equatable/equatable.dart';

import 'package:penhas/app/features/chat/domain/entities/chat_assistant_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_entity.dart';

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
  bool get stringify => true;

  @override
  List<Object?> get props => [
        hasMore,
        nextPage,
        channels,
        support,
        assistant,
      ];
}
