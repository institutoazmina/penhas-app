import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/main_menu/presentation/account/pages/card_profile_password_page.dart';

import '../../../../../../utils/golden_tests.dart';
import '../../../../../../utils/widget_test_steps.dart';

void main() {
  group(CardProfilePasswordPage, () {
    testWidgets('CardProfilePasswordPage shows modal on edit action',
        (WidgetTester tester) async {
      // Define a mock onChange function
      void mockOnChange(String newPassword, String oldPassword) {}

      await tester.theAppIsRunning(
        Scaffold(
          body: CardProfilePasswordPage(
            content: 'Senha atual',
            onChange: mockOnChange,
          ),
        ),
      );

      iSeeText('Senha');
      iSeeText('Senha atual');
      iSeeWidget(IconButton);
      await tester.iTapWidget(IconButton);

      // Verify if the modal dialog is displayed
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Digite a nova senha'), findsOneWidget);
      expect(find.text('Digite a senha atual'), findsOneWidget);

      // Enter text into the text fields
      await tester.enterText(find.byType(TextFormField).first, 'newPassword');
      await tester.enterText(find.byType(TextFormField).last, 'oldPassword');

      // Tap the 'Enviar' button
      await tester.iTapText(text: 'Enviar');

      // Verify if the modal dialog is closed
      iDontSeeText('Email');
    });

    screenshotTestSimplified(
      'should render correctly',
      fileName: 'card_profile_password_page',
      pageBuilder: () => Scaffold(
        body: CardProfilePasswordPage(
          content: '************',
          onChange: (_, __) {},
        ),
      ),
    );
  });
}
