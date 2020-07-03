import 'package:mobx/mobx.dart';

part 'help_center_controller.g.dart';

class HelpCenterController = _HelpCenterControllerBase
    with _$HelpCenterController;

abstract class _HelpCenterControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
