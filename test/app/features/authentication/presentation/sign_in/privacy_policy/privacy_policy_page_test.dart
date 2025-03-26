import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/privacy_policy/privacy_policy_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../../utils/golden_tests.dart';
import '../../mocks/webview_mocks.dart';

void main() {
  setUp(() {
    WebViewPlatform.instance = FakeWebViewPlatform();
  });

  group(PrivacyPolicyPage, skip: true, () {
    group('golden test', () {
      screenshotTest(
        'looks as expected',
        fileName: 'privacy_policy_page',
        pageBuilder: () => PrivacyPolicyPage(
          baseUrl: Uri(
            scheme: 'https',
            host: 'www.example.com',
            path: 'web/politica-privacidade',
          ),
        ),
      );
    });
  });
}
