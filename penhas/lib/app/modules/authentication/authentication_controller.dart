import 'package:mobx/mobx.dart';

part 'authentication_controller.g.dart';

class AuthenticationController = _AuthenticationControllerBase
    with _$AuthenticationController;

abstract class _AuthenticationControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
