import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/presentation/shared/password_text_input.dart';

import '../../../../../utils/golden_tests.dart';

void main() {
  group(PasswordInputField, () {
    testWidgets('widget test', (WidgetTester tester) async {
      // Build the PasswordInputField widget.
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: PasswordInputField(
            onChanged: (val) {},
            labelText: 'Password',
            errorText: '',
            hintText: 'Enter password',
          ),
        ),
      ));

      expect(
        find.byType(PasswordInputField),
        findsOneWidget,
        reason: 'PasswordInputField should be present',
      );

      var textField = tester.widget<TextField>(find.byType(TextField));
      expect(
        textField.obscureText,
        true,
        reason: 'The password should be obscured at first',
      );

      expect(
        find.byIcon(Icons.visibility_off),
        findsOneWidget,
        reason: 'The visibility toggle button should be visible with icon off',
      );

      // Tap the visibility toggle button.
      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      textField = tester.widget<TextField>(find.byType(TextField));
      expect(
        textField.obscureText,
        false,
        reason: 'The password should be visible',
      );

      expect(
        find.byIcon(Icons.visibility),
        findsOneWidget,
        reason: 'The visibility toggle button should be visible with icon on',
      );
    });

    group(
      'golden tests',
      () {
        widgetScreenshotTest(
          'shows correctly',
          fileName: 'authentication_shared_password_input_field',
          widgetBuilder: (ctx) => GoldenTestGroup(
              columns: 1,
              columnWidthBuilder: (columns) => const FixedColumnWidth(400.0),
              children: [
                GoldenTestScenario(
                  name: 'hint',
                  child: PasswordInputField(
                    isAutofocus: true,
                    errorText: '',
                    hintText: 'Hint text',
                    labelText: '',
                    onChanged: (val) {},
                  ),
                ),
                GoldenTestScenario(
                  name: 'input value',
                  child: PasswordInputField(
                    errorText: '',
                    hintText: 'Hint text',
                    labelText: 'P4Ssw0rd',
                    onChanged: (val) {},
                  ),
                ),
                GoldenTestScenario(
                  name: 'with error',
                  child: PasswordInputField(
                    errorText: 'error',
                    hintText: 'Hint text',
                    labelText: 'Password',
                    onChanged: (val) {},
                  ),
                ),
              ]),
        );
      },
    );
  });
}
