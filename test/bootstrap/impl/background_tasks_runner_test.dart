import 'package:firebase_analytics_platform_interface/firebase_analytics_platform_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_crashlytics_platform_interface/firebase_crashlytics_platform_interface.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:penhas/app/core/managers/background_task_manager.dart';
import 'package:penhas/app/core/managers/impl/background_task_manager.dart';
import 'package:penhas/app/core/remoteconfig/remote_config.dart';
import 'package:penhas/app/shared/logger/crashlytics.dart';
import 'package:penhas/bootstrap/bootstrap.dart';
import 'package:penhas/bootstrap/impl/background_tasks_runner.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

void main() {
  late BackgroundTasksRunner sut;

  setUpAll(() {
    registerFallbackValue(_FakeFirebaseApp());
  });

  setUp(() {
    sut = BackgroundTasksRunner();

    FirebasePlatform.instance = _MockFirebasePlatform();
    FirebaseCrashlyticsPlatform.instance = _MockFirebaseCrashlyticsPlatform();
    FirebaseAnalyticsPlatform.instance = _MockFirebaseAnalyticsPlatform();
    CrashlyticsWrapper.crashlytics = _MockFirebaseCrashlytics();
    RemoteConfigService.remoteConfig = _MockFirebaseRemoteConfig();
    PathProviderPlatform.instance = _MockPathProviderPlatform();
  });

  group(BackgroundTasksRunner, () {
    test(
      'should run the application',
      () async {
        // act
        await Bootstrap.instance.withRunner(
          sut,
          onBeforeRun: () => {
            BackgroundTaskManager.instance = _MockBackgroundTaskManager(),
          },
        );

        // assert
        verify(() => BackgroundTaskManager.instance.runPendingTasks());
      },
    );
  });
}

class _MockBackgroundTaskManager extends Mock
    implements IBackgroundTaskManager {}

class _MockPathProviderPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() => Future.value('/');
}

class _MockFirebaseApp extends Mock implements FirebaseApp {}

class _MockFirebasePlatform extends Mock
    with MockPlatformInterfaceMixin
    implements FirebasePlatform {
  final FirebaseAppPlatform _app = _MockFirebaseAppPlatform();

  @override
  FirebaseAppPlatform app([String name = defaultFirebaseAppName]) => _app;

  Future<FirebaseAppPlatform> initializeApp({
    String? name,
    FirebaseOptions? options,
  }) =>
      Future.value(_app);
}

class _MockFirebaseAppPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements FirebaseAppPlatform {
  @override
  String get name => defaultFirebaseAppName;
}

class _MockFirebaseCrashlyticsPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements FirebaseCrashlyticsPlatform {
  @override
  final FirebaseApp app = _MockFirebaseApp();
}

class _MockFirebaseCrashlytics extends Mock
    with MockPlatformInterfaceMixin
    implements FirebaseCrashlytics {
  @override
  Future<void> setCrashlyticsCollectionEnabled(bool enabled) => Future.value();
}

class _MockFirebaseAnalyticsPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements FirebaseAnalyticsPlatform {
  @override
  FirebaseAnalyticsPlatform delegateFor(
          {required FirebaseApp app, Map<String, dynamic>? webOptions}) =>
      this;

  @override
  Future<void> setAnalyticsCollectionEnabled(bool enabled) => Future.value();
}

class _MockFirebaseRemoteConfig extends Mock implements FirebaseRemoteConfig {}

class _FakeFirebaseApp extends Fake implements FirebaseApp {}
