import 'package:mobx/mobx.dart';

part 'new_toot_controller.g.dart';

class NewTootController = _NewTootControllerBase with _$NewTootController;

abstract class _NewTootControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
