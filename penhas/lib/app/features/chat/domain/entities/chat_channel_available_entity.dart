import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'chat_assistant_entity.dart';
import 'chat_channel_entity.dart';

class ChatChannelAvailableEntity extends Equatable {
  final bool hasMore;
  final String nextPage;
  final List<ChatChannelEntity> channels;
  final ChatChannelEntity support;
  final ChatAssistantEntity assistant;

  ChatChannelAvailableEntity({
    @required this.hasMore,
    @required this.nextPage,
    @required this.channels,
    @required this.support,
    @required this.assistant,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        hasMore,
        nextPage,
        channels,
        support,
        assistant,
      ];
}
