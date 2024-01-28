import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app/core/remoteconfig/remote_config.dart';
import 'firebase_options.dart';

void main() {
  _runGuardedWithCrashlytics(() {
    runApp(
      ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    );
  });
}

void _runGuardedWithCrashlytics(FutureOr<void> Function() callback) async {
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
