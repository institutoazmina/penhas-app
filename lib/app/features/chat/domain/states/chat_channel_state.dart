import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_channel_state.freezed.dart';

@freezed
class ChatChannelState with _$ChatChannelState {
  const factory ChatChannelState.initial() = _Initial;
  const factory ChatChannelState.loaded() = _Loaded;
  const factory ChatChannelState.error(String message) = _ErrorDetails;
}
