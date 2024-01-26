import 'dart:async';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider_android/path_provider_android.dart';
import 'package:path_provider_ios/path_provider_ios.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';
import 'package:shared_preferences_ios/shared_preferences_ios.dart';
import 'package:workmanager/workmanager.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app/core/managers/background_task_manager.dart';
import 'app/core/remoteconfig/remote_config.dart';
import 'firebase_options.dart';

void main() {
  _runGuardedWithCrashlytics(() {
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: kDebugMode,
    );

    runApp(
      ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    );
  });
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  _registerRequiredPlugins();

  _runGuardedWithCrashlytics(() {
    Modular.init(AppModule());

    final taskManager = Modular.get<IBackgroundTaskManager>();
    taskManager.runPendingTasks();
  });
}

void _runGuardedWithCrashlytics(FutureOr<void> Function() callback) async {
  _ProxyHttpOverrides.register();
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeFirebase();

  runZonedGuarded(
    () async {
      await Future.wait([
        Hive.initFlutter(),
        _initRemoteConfig(),
      ]);

      await callback();
    },
    (error, stack) =>
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
  );
}

Future<void> _initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  if (kDebugMode) {
    await Future.wait([
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false),
      FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false),
    ]);
  }
}

Future<void> _initRemoteConfig() async {
  final remoteConfig = RemoteConfigService(
    remoteConfig: FirebaseRemoteConfig.instance,
  );
  await remoteConfig.initialize();
}

void _registerRequiredPlugins() {
  if (Platform.isAndroid) {
    PathProviderAndroid.registerWith();
    SharedPreferencesAndroid.registerWith();
  } else if (Platform.isIOS) {
    PathProviderIOS.registerWith();
    SharedPreferencesIOS.registerWith();
  }
}

class _ProxyHttpOverrides extends HttpOverrides {
  static const String _devHost = 'dev-penhas-api.appcivico.com';

  static void register() {
    HttpOverrides.global = _ProxyHttpOverrides();
  }

  static bool allowBadDevCertificateCallback(
    X509Certificate cert,
    String host,
    int port,
  ) =>
      host == _devHost;

  @override
  HttpClient createHttpClient(SecurityContext? context) =>
      super.createHttpClient(context)
        ..badCertificateCallback = allowBadDevCertificateCallback;
}
