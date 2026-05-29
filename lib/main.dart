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

        // Configure + resume background uploads WITHOUT blocking app launch.
        // Awaiting these here gated runApp() behind the platform handshake and
        // could hang the splash indefinitely (the swallowed error in
        // Bootstrap.withRunner meant run() never executed). Fire-and-forget,
        // self-guarded, so a slow/failed downloader init never bricks boot.
        unawaited(_initBackgroundUploads());
      },
    );
  }, (error, stack) {
    // Tratamento global de erro
    log('Error not disclosed $error');
  });
}

/// Initializes the background uploader off the boot-critical path.
Future<void> _initBackgroundUploads() async {
  try {
    await FileDownloader().configure(
      globalConfig: {Config.requestTimeout: const Duration(minutes: 2)},
    );
    await FileDownloader().start();
    await FileDownloader().rescheduleKilledTasks();
  } catch (error, stack) {
    log('FileDownloader init failed: $error', stackTrace: stack);
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Bootstrap.instance.withRunner(
    BackgroundTasksRunner(),
  );
}
