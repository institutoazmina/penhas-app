import 'dart:async';
import 'dart:developer';

import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app/core/managers/impl/background_task_manager.dart';
import 'bootstrap/bootstrap.dart';
import 'bootstrap/impl/background_tasks_runner.dart';
import 'bootstrap/impl/main_app_runner.dart';

void main() {
  BindingBase.debugZoneErrorsAreFatal = true;

  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Bootstrap.instance.withRunner(
      MainAppRunner(),
      onBeforeRun: () async {
        BackgroundTaskManager.instance.registerDispatcher(callbackDispatcher);

        await FileDownloader().configure(
          globalConfig: {Config.requestTimeout: const Duration(minutes: 2)},
        );
        await FileDownloader().start();
        await FileDownloader().rescheduleKilledTasks();
      },
    );
  }, (error, stack) {
    // Tratamento global de erro
    log('Error not disclosed $error');
  });
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Bootstrap.instance.withRunner(
    BackgroundTasksRunner(),
  );
}
