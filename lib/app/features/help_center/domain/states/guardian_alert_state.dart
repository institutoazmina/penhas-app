import 'package:freezed_annotation/freezed_annotation.dart';

part 'guardian_alert_state.freezed.dart';

@freezed
class GuardianAlertState with _$GuardianAlertState {
  const factory GuardianAlertState.initial() = _Initial;
  const factory GuardianAlertState.alert(GuardianAlertMessageAction action) =
      _Alert;
}

abstract class GuardianAlertAction {}

class GuardianAlertMessageAction extends GuardianAlertAction {
  GuardianAlertMessageAction({
    required this.title,
    required this.message,
    required this.onPressed,
  });

  final String title;
  final String? message;

  final void Function() onPressed;
}
