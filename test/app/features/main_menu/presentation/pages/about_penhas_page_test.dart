import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/main_menu/presentation/pages/about_penhas_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../utils/golden_tests.dart';
import '../../../../features/authentication/presentation/mocks/webview_mocks.dart';

void main() {
  setUp(() {
    WebViewPlatform.instance = FakeWebViewPlatform();
  });

  group(AboutPenhasPage, () {
    group('golden test', () {
      screenshotTest(
        'looks as expected',
        fileName: 'about_penhas_page',
        pageBuilder: () => AboutPenhasPage(
          baseUrl: Uri(
            scheme: 'https',
            host: 'www.example.com',
          ),
        ),
      );
    });

    testWidgets('should configure WebView with JavaScript disabled',
        (tester) async {
      final fakePlatform = FakeWebViewPlatform();
      WebViewPlatform.instance = fakePlatform;

      await tester.pumpWidget(
        MaterialApp(
          home: AboutPenhasPage(
            baseUrl: Uri(
              scheme: 'https',
              host: 'www.example.com',
            ),
          ),
        ),
      );

      expect(
        fakePlatform.lastController?.lastJavaScriptMode,
        equals(JavaScriptMode.disabled),
      );
    });
  });
}
