import 'package:mobx/mobx.dart';

part 'mainboard_controller.g.dart';

class MainboardController = _MainboardControllerBase with _$MainboardController;

abstract class _MainboardControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
