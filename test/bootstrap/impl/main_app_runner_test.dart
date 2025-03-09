import 'package:firebase_analytics_platform_interface/firebase_analytics_platform_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_crashlytics_platform_interface/firebase_crashlytics_platform_interface.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:penhas/app/core/remoteconfig/remote_config.dart';
import 'package:penhas/app/shared/logger/crashlytics.dart';
import 'package:penhas/bootstrap/bootstrap.dart';
import 'package:penhas/bootstrap/impl/main_app_runner.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../../utils/mock_callbacks.dart';

void main() {
  group(MainAppRunner, () {
    late MainAppRunner sut;

    late VoidCallback1<Widget> mockRunApp;

    setUpAll(() {
      registerFallbackValue(_FakeFirebaseApp());
      registerFallbackValue(_FakeWidget());
    });

    setUp(() {
      mockRunApp = MockVoidCallback1();
      sut = MainAppRunner.create(mockRunApp);

      FirebasePlatform.instance = _MockFirebasePlatform();
      FirebaseCrashlyticsPlatform.instance = _MockFirebaseCrashlyticsPlatform();
      FirebaseAnalyticsPlatform.instance = _MockFirebaseAnalyticsPlatform();
      CrashlyticsWrapper.crashlytics = _MockFirebaseCrashlytics();
      RemoteConfigService.remoteConfig = _MockFirebaseRemoteConfig();
      PathProviderPlatform.instance = _MockPathProviderPlatform();
    });

    test(
      'should run the application',
      () async {
        // act
        await Bootstrap.instance.withRunner(sut);

        // assert
        verify(() => mockRunApp(any())).called(1);
      },
    );
  });
}

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
  FirebaseAnalyticsPlatform delegateFor({required FirebaseApp app}) => this;

  @override
  Future<void> setAnalyticsCollectionEnabled(bool enabled) => Future.value();
}

class _MockFirebaseRemoteConfig extends Mock implements FirebaseRemoteConfig {}

class _FakeFirebaseApp extends Fake implements FirebaseApp {}

class _FakeWidget extends Fake implements Widget {
  @override
  String toString({DiagnosticLevel? minLevel}) => runtimeType.toString();
}
