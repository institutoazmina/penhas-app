import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_main_security_state.freezed.dart';

@freezed
class ChatMainSecurityState with _$ChatMainSecurityState {
  const factory ChatMainSecurityState.onlySupport() = _OnlySupport;
  const factory ChatMainSecurityState.supportAndPrivate() = _SupportAndPrivate;
}
