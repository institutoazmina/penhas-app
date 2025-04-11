import 'dart:developer';

import 'package:flutter_background_service/flutter_background_service.dart';

import '../../../shared/logger/log.dart';
import '../background_task_manager.dart';
import '../background_task_registry.dart';

class BackgroundTaskManager extends IBackgroundTaskManager {
  BackgroundTaskManager({
    IBackgroundTaskRegistry registry = const BackgroundTaskRegistry(),
    FlutterBackgroundService? service,
  })  : _registry = registry,
        _service = service ?? FlutterBackgroundService();

  final FlutterBackgroundService _service;
  final IBackgroundTaskRegistry _registry;

  static IBackgroundTaskManager? _instance;

  static IBackgroundTaskManager get instance =>
      _instance ??= BackgroundTaskManager();

  static set instance(IBackgroundTaskManager value) => _instance = value;

  @override
  Future<void> registerDispatcher(Function callbackDispatcher) async {
    _service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: _onBackgroundServiceStart,
        isForegroundMode: true,
        autoStart: true,
        foregroundServiceTypes: [
          AndroidForegroundType.mediaPlayback,
          AndroidForegroundType.dataSync
        ],
      ),
      iosConfiguration: IosConfiguration(
        onForeground: _onBackgroundServiceStart,
        onBackground: _onIosBackground,
      ),
    );
  }

  static Future<bool> _onIosBackground(ServiceInstance service) async {
    log('iOS Background Task Running');
    return true;
  }

  static void _onBackgroundServiceStart(ServiceInstance service) async {
    if (service is AndroidServiceInstance) {
      service.setAsForegroundService();

      service.setForegroundNotificationInfo(
        title: 'Background Service Running',
        content: 'Tap to return to the app',
      );
    }

    log('Background service started');

    service.on('stopService').listen((event) {
      log('Stopping background service...');
      service.stopSelf();
    });
  }

  @override
  void schedule(String taskName) {
    log('Scheduling task: $taskName');

    _service.startService().then((_) {
      _service.invoke(taskName);
    }).catchError((e, stack) {
      logError('Error starting service: $e', stack);
    });
  }

  @override
  void runPendingTasks() {
    _service.on('executeTask').listen((event) async {
      final taskName = event?['taskName'] as String?;
      if (taskName != null) {
        try {
          log('Executing task: $taskName');
          await _runTaskByName(taskName);
        } catch (e, stack) {
          logError('Task execution error: $e', stack);
        }
      }
    });
  }

  Future<void> _runTaskByName(String taskName) async {
    final taskDefinition = _registry.definitionByName(taskName);
    final task = taskDefinition.taskProvider();
    await task.execute();
  }
}
