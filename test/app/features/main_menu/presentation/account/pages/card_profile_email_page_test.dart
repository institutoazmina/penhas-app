import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/main_menu/presentation/account/pages/card_profile_email_page.dart';

import '../../../../../../utils/golden_tests.dart';

void main() {
  group(CardProfileEmailPage, () {
    screenshotTestSimplified(
      'should render correctly',
      fileName: 'card_profile_email_page',
      pageBuilder: () => Scaffold(
        body: CardProfileEmailPage(
          content: 'penhas@gmail.com',
          onChange: (String newEmail, String oldEmail) {},
        ),
      ),
    );
  });
}
