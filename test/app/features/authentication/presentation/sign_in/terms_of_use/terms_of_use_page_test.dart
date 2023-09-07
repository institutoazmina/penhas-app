import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/terms_of_use/terms_of_use_page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

import '../../../../../../utils/golden_tests.dart';
import '../../mocks/webview_mocks.dart';

void main() {
  setUp(() {
    // configure webview mock
    WebViewMocks.init();

    when(() => WebViewMocks.webViewPlatform.build(
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
        mockWebViewPlatformController: WebViewMocks.webViewPlatformController,
        onWebViewPlatformCreated: onWebViewPlatformCreated,
      );
    });
    when(() => WebViewMocks.webViewPlatformController.updateSettings(any()))
        .thenAnswer((i) => Future.value());

    WebView.platform = WebViewMocks.webViewPlatform;
    WebViewCookieManagerPlatform.instance =
        WebViewMocks.webViewCookieManagerPlatform;
  });

  tearDown(() {
    WebViewMocks.webViewCookieManagerPlatform.reset();
  });

  group(TermsOfUsePage, () {
    group('golden test', () {
      screenshotTest(
        'looks as expected',
        fileName: 'terms_of_use_page',
        pageBuilder: () => TermsOfUsePage(baseUrl: Uri()),
      );
    });
  });
}
