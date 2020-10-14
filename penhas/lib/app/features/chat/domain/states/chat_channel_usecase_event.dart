import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'chat_channel_usecase_event.freezed.dart';

@freezed
abstract class ChatChannelUseCaseEvent with _$ChatChannelUseCaseEvent {
  const factory ChatChannelUseCaseEvent.initial() = _Initial;
}
