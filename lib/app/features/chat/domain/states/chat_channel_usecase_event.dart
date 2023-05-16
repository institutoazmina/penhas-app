import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/chat_channel_message.dart';
import '../entities/chat_channel_session_entity.dart';
import '../entities/chat_user_entity.dart';

part 'chat_channel_usecase_event.freezed.dart';

@freezed
class ChatChannelUseCaseEvent with _$ChatChannelUseCaseEvent {
  const factory ChatChannelUseCaseEvent.initial() = _Initial;
  const factory ChatChannelUseCaseEvent.loaded() = _Loaded;
  const factory ChatChannelUseCaseEvent.updateUser(ChatUserEntity user) =
      _UpdateUser;
  const factory ChatChannelUseCaseEvent.updateMetadata(
    ChatChannelSessionMetadataEntity metadata,
  ) = _UpdateMetadata;
  const factory ChatChannelUseCaseEvent.updateMessage(
    List<ChatChannelMessage> messages,
  ) = _UpdateMessage;
  const factory ChatChannelUseCaseEvent.errorOnLoading(String message) =
      _ErrorOnLoading;
}
