import 'package:collection/collection.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_available_entity.dart';

import 'chat_assistant_model.dart';
import 'chat_channel_model.dart';

class ChatChannelAvailableModel extends ChatChannelAvailableEntity {
  ChatChannelAvailableModel({
    required bool? hasMore,
    required String? nextPage,
    required List<ChatChannelModel>? channels,
    required ChatChannelModel? support,
    required ChatAssistantModel? assistant,
  }) : super(
          hasMore: hasMore,
          nextPage: nextPage,
          channels: channels,
          support: support,
          assistant: assistant,
        );

  factory ChatChannelAvailableModel.fromJson(Map<String, dynamic> jsonData) {
    final hasMore = jsonData['has_more'] == 1;
    final nextPage = jsonData['next_page'];
    final support = ChatChannelModel.fromJson(jsonData['support']);
    final assistant = jsonData['assistant'] == null
        ? null
        : ChatAssistantModel.fromJson(jsonData['assistant']);
    final List<dynamic> jsonChannels = jsonData['rows'];
    final List<ChatChannelModel> channels = jsonChannels
        .map((e) => e as Map<String, dynamic>)
        .map((e) => ChatChannelModel.fromJson(e))
        .whereNotNull()
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
