import 'package:meta/meta.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_available_entity.dart';

import 'chat_channel_model.dart';
import 'chat_assistant_model.dart';

class ChatChannelAvailableModel extends ChatChannelAvailableEntity {
  final bool hasMore;
  final String nextPage;
  final List<ChatChannelModel> channels;
  final ChatChannelModel support;
  final ChatAssistantModel assistant;

  ChatChannelAvailableModel({
    @required this.hasMore,
    @required this.nextPage,
    @required this.channels,
    @required this.support,
    @required this.assistant,
  });

  factory ChatChannelAvailableModel.fromJson(Map<String, Object> jsonData) {
    final hasMore = jsonData["has_more"] == 1;
    final nextPage = jsonData["next_page"];
    final support = ChatChannelModel.fromJson(jsonData["support"]);
    final assistant = jsonData["assistant"] == null
        ? null
        : ChatAssistantModel.fromJson(jsonData["assistant"]);
    final List<Object> jsonChannels = jsonData["rows"];
    final List<ChatChannelModel> channels = jsonChannels
        .map((e) => e as Map<String, Object>)
        .map((e) => ChatChannelModel.fromJson(e))
        .where((e) => e != null)
        .toList();

    return ChatChannelAvailableModel(
      hasMore: hasMore,
      nextPage: nextPage,
      channels: channels,
      support: support,
      assistant: assistant,
    );
  }
}
