import 'package:flutter_modular/flutter_modular.dart';

import '../../app/app_module.dart';
import '../../app/core/extension/platform_interfaces.dart';
import '../../app/core/managers/background_task_manager.dart';
import '../bootstrap.dart';
import 'app_runner_mixin.dart';

class BackgroundTasksRunner extends Runner with RunnerMixin {
  @override
  Future<void> initialize() async {
    PlatformPlugins.ensureAllInitialized();
    await super.initialize();
  }

  @override
  Future<void> configure() async {
    await super.configure();

    Modular.init(AppModule());
  }

  @override
  void run() {
    final taskManager = Modular.get<IBackgroundTaskManager>();
    taskManager.runPendingTasks();
  }
}
