import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'guardian_alert_state.freezed.dart';

@freezed
abstract class GuardianAlertState with _$GuardianAlertState {
  const factory GuardianAlertState.initial() = _Initial;
  const factory GuardianAlertState.alert(GuardianAlertMessageAction action) =
      _Alert;
}

abstract class GuardianAlertAction {}

class GuardianAlertMessageAction extends GuardianAlertAction {
  final String message;
  final void Function() onPressed;

  GuardianAlertMessageAction({
    @required this.message,
    @required this.onPressed,
  });
}
