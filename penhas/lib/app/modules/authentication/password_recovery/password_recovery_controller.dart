import 'package:mobx/mobx.dart';

part 'password_recovery_controller.g.dart';

class PasswordRecoveryController = _PasswordRecoveryControllerBase
    with _$PasswordRecoveryController;

abstract class _PasswordRecoveryControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
