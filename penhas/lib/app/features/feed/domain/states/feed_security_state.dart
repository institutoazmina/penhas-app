import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'feed_security_state.freezed.dart';

@freezed
abstract class FeedSecurityState with _$FeedSecurityState {
  const factory FeedSecurityState.enable() = _Enable;
  const factory FeedSecurityState.disable() = _Disable;
}
