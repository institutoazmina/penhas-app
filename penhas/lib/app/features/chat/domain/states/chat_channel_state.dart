import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_channel_state.freezed.dart';

@freezed
abstract class ChatChannelState with _$ChatChannelState {
  const factory ChatChannelState.initial() = _Initial;
  const factory ChatChannelState.error(String message) = _ErrorDetails;
}
