import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/widgets.dart';

class CrashlyticsWrapper {
  @visibleForTesting
  static FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;

  static void register() {
    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = crashlytics.recordFlutterError;
  }

  static Future<void> setCrashlyticsCollectionEnabled(bool enabled) =>
      crashlytics.setCrashlyticsCollectionEnabled(enabled);
}
