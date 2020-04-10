import 'package:mobx/mobx.dart';

part 'registration_controller.g.dart';

class RegistrationController = _RegistrationControllerBase
    with _$RegistrationController;

abstract class _RegistrationControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
