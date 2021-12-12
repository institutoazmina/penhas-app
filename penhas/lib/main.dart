import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
<<<<<<< HEAD
import 'package:flutter/foundation.dart';
=======
>>>>>>> Fix code syntax
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/app_module.dart';
import 'package:penhas/app/app_widget.dart';
<<<<<<< HEAD

const _kTestingCrashlytics = false;
=======
>>>>>>> Fix code syntax

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Pass all uncaught errors from the framework to Crashlytics.
  FirebaseCrashlytics.instance
      .setCrashlyticsCollectionEnabled(_kTestingCrashlytics || !kDebugMode);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

<<<<<<< HEAD
  runZonedGuarded(
    () async {
      runApp(
        ModularApp(
          module: AppModule(),
          child: AppWidget(),
        ),
      );
    },
    FirebaseCrashlytics.instance.recordError,
=======
  runApp(
    ModularApp(module: AppModule(), child: AppWidget()),
>>>>>>> Fix code syntax
  );
}
