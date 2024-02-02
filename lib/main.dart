import 'app/core/managers/impl/background_task_manager.dart';
import 'bootstrap/bootstrap.dart';
import 'bootstrap/impl/background_tasks_runner.dart';
import 'bootstrap/impl/main_app_runner.dart';

void main() {
  Bootstrap.instance.withRunner(
    MainAppRunner(),
    onBeforeRun: () {
      BackgroundTaskManager.instance.registerDispatcher(callbackDispatcher);
    },
  );
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Bootstrap.instance.withRunner(
    BackgroundTasksRunner(),
  );
}
