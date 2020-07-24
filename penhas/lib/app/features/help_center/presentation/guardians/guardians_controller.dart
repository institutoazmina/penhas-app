import 'package:mobx/mobx.dart';

part 'guardians_controller.g.dart';

class GuardiansController = _GuardiansControllerBase with _$GuardiansController;

abstract class _GuardiansControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
