import 'dart:async';

import 'package:flutter_background_service/flutter_background_service.dart';

import '../../../shared/logger/log.dart';
import '../background_task_manager.dart';
import '../background_task_registry.dart';

class BackgroundTaskManager extends IBackgroundTaskManager {
  BackgroundTaskManager({
    IBackgroundTaskRegistry registry = const BackgroundTaskRegistry(),
    FlutterBackgroundService? workManager,
  })  : _registry = registry; // coverage:ignore-line

  final IBackgroundTaskRegistry _registry;

  static IBackgroundTaskManager? _instance;

  static IBackgroundTaskManager get instance =>
      _instance ??= BackgroundTaskManager();

  static set instance(IBackgroundTaskManager value) => _instance = value;

  Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true, // Keeps the task running even when app is closed
      autoStart: true, // Auto-starts the service on app launch
    ),
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );

  service.startService();
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) {
  if (service is AndroidServiceInstance) {
    service.setAsForegroundService(); // Runs as a foreground service
  }

  Timer.periodic(const Duration(seconds: 10), (timer) {
    service.invoke('update'); // Calls a function periodically
  });
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  return true;
}

@pragma('vm:entry-point')
void onBackgroundTask(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();
  }

  service.on('startTask').listen((event) async {
    final task = event?['task'];
    
    try {
      await _runTaskByName(task);
      service.invoke('taskCompleted', {'status': true});
    } catch (e, stack) {
      logError(e, stack);
      service.invoke('taskCompleted', {'status': false});
    }
  });
}


  @override
  Future<void> registerDispatcher(Function callbackDispatcher) async {
   await initializeService();
  }

  @override
  void schedule(String taskName) {
    FlutterBackgroundService().invoke(taskName);

  }

  @override
  void runPendingTasks() async {
FlutterBackgroundService().invoke('startTask', {'task': 'yourTaskName'});

  }

  Future<void> _runTaskByName(String taskName) async {
    final taskDefinition = _registry.definitionByName(taskName);

    final task = taskDefinition.taskProvider();
    await task.execute();
  }
}
