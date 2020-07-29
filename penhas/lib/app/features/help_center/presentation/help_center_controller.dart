import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'help_center_controller.g.dart';

class HelpCenterController = _HelpCenterControllerBase
    with _$HelpCenterController;

abstract class _HelpCenterControllerBase with Store {
  @action
  void newGuardian() {
    Modular.to.pushNamed('/mainboard/helpcenter/newGuardian');
  }

  void guardians() {
    Modular.to.pushNamed('/mainboard/helpcenter/guardians');
  }
}
