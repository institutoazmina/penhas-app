import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'help_center_state.freezed.dart';

@freezed
abstract class HelpCenterState with _$HelpCenterState {
  const factory HelpCenterState.initial() = _Initial;
  const factory HelpCenterState.guardianTriggered() = _GuardianTriggered;
}
