import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/terms_of_use/terms_of_use_page.dart';

import '../../../../../../utils/golden_tests.dart';
import '../../mocks/webview_mocks.dart';

void main() {
  setUp(() {
    // configure webview mock
    WebViewMocks.init();
  });

  group(TermsOfUsePage, () {
    group('golden test', () {
      screenshotTest(
        'looks as expected',
        fileName: 'terms_of_use_page',
        pageBuilder: () => TermsOfUsePage(baseUrl: Uri()),
        skip: true,
      );
    });
  });
}
