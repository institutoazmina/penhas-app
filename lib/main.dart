import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app/core/remoteconfig/remote_config.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
  }

  runZonedGuarded(
    () async {
      await Hive.initFlutter();
      await _initRemoteConfig();
      runApp(
        ModularApp(
          module: AppModule(),
          child: const AppWidget(),
        ),
      );
    },
    (error, stack) =>
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
  );
}

Future<void> _initRemoteConfig() async {
  RemoteConfigService remoteConfig =
      RemoteConfigService(remoteConfig: FirebaseRemoteConfig.instance);
  await remoteConfig.initialize();
}
