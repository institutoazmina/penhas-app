import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/privacy_policy/privacy_policy_page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

import '../../../../../../utils/golden_tests.dart';
import '../tools/webview_mocks.dart';

void main() {
  late MockWebViewPlatform mockWebViewPlatform;
  late MockWebViewPlatformController mockWebViewPlatformController;
  late MockWebViewCookieManagerPlatform mockWebViewCookieManagerPlatform;

  setUpAll(() {
    registerFallbackValue(FakeBuildContext());
    registerFallbackValue(FakeCreationParams());
    registerFallbackValue(FakeWebViewPlatformCallbacksHandler());
    registerFallbackValue(FakeJavascriptChannelRegistry());
    registerFallbackValue(FakeWebSettings());
  });

  setUp(() {
    // configure webview mock
    mockWebViewPlatformController = MockWebViewPlatformController();
    mockWebViewPlatform = MockWebViewPlatform();
    mockWebViewCookieManagerPlatform = MockWebViewCookieManagerPlatform();
    when(() => mockWebViewPlatform.build(
          context: any(named: 'context'),
          creationParams: any(named: 'creationParams'),
          webViewPlatformCallbacksHandler:
              any(named: 'webViewPlatformCallbacksHandler'),
          javascriptChannelRegistry: any(named: 'javascriptChannelRegistry'),
          onWebViewPlatformCreated: any(named: 'onWebViewPlatformCreated'),
          gestureRecognizers: any(named: 'gestureRecognizers'),
        )).thenAnswer((Invocation invocation) {
      final WebViewPlatformCreatedCallback onWebViewPlatformCreated =
          invocation.namedArguments[const Symbol('onWebViewPlatformCreated')]
              as WebViewPlatformCreatedCallback;
      return TestPlatformWebView(
        mockWebViewPlatformController: mockWebViewPlatformController,
        onWebViewPlatformCreated: onWebViewPlatformCreated,
      );
    });
    when(() => mockWebViewPlatformController.updateSettings(any()))
        .thenAnswer((i) => Future.value());

    WebView.platform = mockWebViewPlatform;
    WebViewCookieManagerPlatform.instance = mockWebViewCookieManagerPlatform;
  });

  tearDown(() {
    mockWebViewCookieManagerPlatform.reset();
  });

  group(PrivacyPolicyPage, () {
    group('golden test', () {
      screenshotTest(
        'looks as expected',
        fileName: 'privacy_policy_page',
        pageBuilder: () => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: PrivacyPolicyPage(baseUrl: Uri()),
        ),
      );
    });
  });
}
