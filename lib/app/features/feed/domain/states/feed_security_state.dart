import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_security_state.freezed.dart';

@freezed
class FeedSecurityState with _$FeedSecurityState {
  const factory FeedSecurityState.enable() = _Enable;
  const factory FeedSecurityState.disable() = _Disable;
}
