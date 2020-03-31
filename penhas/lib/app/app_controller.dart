import 'package:mobx/mobx.dart';
part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  void onMenuAction() {
    print("[onMenuAction] To be implemented");
  }

  void onSearchAction() {
    print("[onSearchAction] To be implemented");
  }

  void onNotificationAction() {
    print("[onNotificationAction] To be implemented");
  }
}
