import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/privacy_policy/privacy_policy_page.dart';

import '../../../../../../utils/golden_tests.dart';
import '../../mocks/webview_mocks.dart';

void main() {
  setUp(() {
    // configure webview mock
    WebViewMocks.init();
  });

  group(PrivacyPolicyPage, () {
    group('golden test', () {
      screenshotTest('looks as expected',
          fileName: 'privacy_policy_page',
          pageBuilder: () => PrivacyPolicyPage(baseUrl: Uri()),
          skip: true);
    });
  });
}
