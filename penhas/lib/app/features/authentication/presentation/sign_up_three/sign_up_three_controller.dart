import 'package:mobx/mobx.dart';

part 'sign_up_three_controller.g.dart';

class SignUpThreeController = _SignUpThreeControllerBase
    with _$SignUpThreeController;

abstract class _SignUpThreeControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
