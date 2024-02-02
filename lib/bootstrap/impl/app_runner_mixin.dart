import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../app/core/extension/hive.dart';
import '../../app/core/remoteconfig/remote_config.dart';
import '../../app/shared/logger/crashlytics.dart';
import '../../firebase_options.dart';
import '../bootstrap.dart';

mixin RunnerMixin on Runner {
  @override
  FutureOr<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _initializeFirebase();
  }

  @override
  FutureOr<void> configure() async {
    const remoteConfig = RemoteConfigService();

    await Future.wait([
      Hive.initFlutter(),
      remoteConfig.initialize(),
    ]);
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    CrashlyticsWrapper.register();

    if (kDebugMode) {
      await Future.wait([
        CrashlyticsWrapper.setCrashlyticsCollectionEnabled(false),
        FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false),
      ]);
    }
  }
}
