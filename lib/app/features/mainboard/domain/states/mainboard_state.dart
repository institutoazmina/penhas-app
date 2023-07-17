import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mainboard_state.freezed.dart';

@freezed
class MainboardState with _$MainboardState {
  const factory MainboardState.chat() = _Chat;
  const factory MainboardState.feed() = _Feed;
  const factory MainboardState.escapeManual() = _EscapeManual;
  const factory MainboardState.compose() = _Compose;
  const factory MainboardState.supportPoint() = _SupportPoint;
  const factory MainboardState.helpCenter() = _HelpCenter;

  factory MainboardState.fromString(String? state) {
    switch (state) {
      case 'feed':
        return const MainboardState.feed();
      case 'chat':
        return const MainboardState.chat();
      case 'escapemanual':
        return const MainboardState.escapeManual();
      case 'compose':
        return const MainboardState.compose();
      case 'supportpoint':
        return const MainboardState.supportPoint();
      case 'helpcenter':
        return const MainboardState.helpCenter();
    }

    return const MainboardState.feed();
  }
}
