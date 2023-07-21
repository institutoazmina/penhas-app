import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'guardian_alert_state.dart';

part 'help_center_state.freezed.dart';

@freezed
class HelpCenterState with _$HelpCenterState {
  const factory HelpCenterState.initial() = _Initial;
  const factory HelpCenterState.guardianTriggered(
    GuardianAlertMessageAction action,
  ) = _GuardianTriggered;
  const factory HelpCenterState.callingPolice(String callingNumber) =
      _CallingPolice;
}
