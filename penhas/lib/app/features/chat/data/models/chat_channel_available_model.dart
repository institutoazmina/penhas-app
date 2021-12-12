import 'package:collection/collection.dart';
import 'package:penhas/app/features/chat/data/models/chat_assistant_model.dart';
import 'package:penhas/app/features/chat/data/models/chat_channel_model.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_available_entity.dart';

class ChatChannelAvailableModel extends ChatChannelAvailableEntity {
  final bool? hasMore;
  final String? nextPage;
  final List<ChatChannelModel>? channels;
  final ChatChannelModel? support;
  final ChatAssistantModel? assistant;

  ChatChannelAvailableModel({
    required this.hasMore,
    required this.nextPage,
    required this.channels,
    required this.support,
    required this.assistant,
  });

  factory ChatChannelAvailableModel.fromJson(Map<String, Object> jsonData) {
    final hasMore = jsonData["has_more"] == 1;
    final nextPage = jsonData["next_page"];
    final support = ChatChannelModel.fromJson(jsonData["support"] as Map<String, Object>);
    final assistant = jsonData["assistant"] == null
        ? null
        : ChatAssistantModel.fromJson(jsonData["assistant"] as Map<String, Object>);
    final List<Object> jsonChannels = jsonData["rows"] as List<Object>;
    final List<ChatChannelModel> channels = jsonChannels
        .map((e) => e as Map<String, dynamic>)
        .map((e) => ChatChannelModel.fromJson(e))
        .whereNotNull()
        .toList();

    return ChatChannelAvailableModel(
      hasMore: hasMore,
      nextPage: nextPage as String?,
      channels: channels,
      support: support,
      assistant: assistant,
    );
  }
}
