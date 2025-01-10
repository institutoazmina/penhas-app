import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/main_menu/presentation/account/pages/card_profile_bio_page.dart';

import '../../../../../../utils/golden_tests.dart';

void main() {
  group(CardProfileBioPage, () {
    screenshotTest(
      'should render correctly',
      fileName: 'card_profile_bio_page',
      pageBuilder: () => Scaffold(
        body: CardProfileBioPage(content: 'Bio', onChange: (String) {}),
      ),
    );
  });
}
