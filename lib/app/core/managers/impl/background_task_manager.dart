import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:workmanager/workmanager.dart';

import '../../../shared/logger/log.dart';
import '../background_task_manager.dart';

class BackgroundTaskManager extends IBackgroundTaskManager {
  BackgroundTaskManager({
    IBackgroundTaskRegistry registry = const BackgroundTaskRegistry(),
    Workmanager? workManager,
  })  : _registry = registry,
        _workManager = workManager ?? Workmanager(); // coverage:ignore-line

  final Workmanager _workManager;
  final IBackgroundTaskRegistry _registry;

  static IBackgroundTaskManager? _instance;

  static IBackgroundTaskManager get instance =>
      _instance ??= BackgroundTaskManager();

  static set instance(IBackgroundTaskManager value) => _instance = value;

  @override
  void registerDispatcher(Function callbackDispatcher) {
    _workManager.initialize(
      callbackDispatcher,
      isInDebugMode: kDebugMode,
    );
  }

  @override
  void schedule(String taskName) {
    _workManager.registerOneOffTask(
      taskName,
      taskName,
      existingWorkPolicy: ExistingWorkPolicy.replace,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }

  @override
  void runPendingTasks() {
    _workManager.executeTask((task, inputData) async {
      try {
        await _runTaskByName(task);
        return true;
      } catch (e, stack) {
        logError(e, stack);
        return false;
      }
    });
  }

  Future<void> _runTaskByName(String taskName) async {
    final taskDefinition = _registry.definitionByName(taskName);
    for (final module in taskDefinition.dependencies) {
      Modular.bindModule(module);
    }

    final task = taskDefinition.taskProvider();
    await task.execute();

    for (final module in taskDefinition.dependencies) {
      Modular.removeModule(module);
    }
  }
}

class BackgroundTaskRegistry extends IBackgroundTaskRegistry {
  const BackgroundTaskRegistry();

  @override
  TaskDefinition definitionByName(String taskName) {
    throw UnimplementedError(
      'Task $taskName not implemented',
    );
  }
}
