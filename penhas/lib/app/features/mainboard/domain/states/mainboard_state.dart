import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'mainboard_state.freezed.dart';

@freezed
abstract class MainboardState with _$MainboardState {
  const factory MainboardState.chat() = _Chat;
  const factory MainboardState.feed() = _Feed;
  const factory MainboardState.compose() = _Compose;
  const factory MainboardState.supportPoint() = _SupportPoint;
  const factory MainboardState.helpCenter() = _HelpCenter;

  static fromString(String state) {
    switch (state) {
      case 'feed':
        return MainboardState.feed();
      case 'chat':
        return MainboardState.chat();
      case 'compose':
        return MainboardState.compose();
      case 'supportpoint':
        return MainboardState.supportPoint();
      case 'helpcenter':
        return MainboardState.helpCenter();
    }

    return MainboardState.feed();
  }
}
