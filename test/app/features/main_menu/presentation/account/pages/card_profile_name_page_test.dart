import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/main_menu/presentation/account/pages/card_profile_name_page.dart';

import '../../../../../../utils/golden_tests.dart';
import '../../../../../../utils/widget_test_steps.dart';

void main() {
  group(CardProfileNamePage, () {
    testWidgets('CardProfileNamePage shows modal on edit action',
        (WidgetTester tester) async {
      await tester.theAppIsRunning(
        Scaffold(
          body: CardProfileNamePage(
            name: 'PenhaS',
            onChange: (String newName) {},
            badges: [],
          ),
        ),
      );

      iSeeText('Apelido');
      iSeeText('PenhaS');
      iSeeWidget(IconButton);
    });

    screenshotTest(
      'should render correctly',
      fileName: 'card_profile_name_page',
      pageBuilder: () => Scaffold(
        body: CardProfileNamePage(
          name: 'PenhaS',
          onChange: (String newName) {},
          badges: [],
        ),
      ),
    );
  });
}
