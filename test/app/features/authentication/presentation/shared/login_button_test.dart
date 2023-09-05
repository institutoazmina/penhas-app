import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/presentation/shared/login_button.dart';

void main() {
  group(LoginButton, () {
    testWidgets(
      'calls onChanged when tapped',
      (WidgetTester tester) async {
        bool wasButtonPressed = false;
        const key = Key('loginButton');

        // Build the LoginButton widget
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoginButton(
                key: key,
                onChanged: () {
                  wasButtonPressed = true;
                },
              ),
            ),
          ),
        );

        // Tap on the RaisedButton widget
        await tester.tap(find.byKey(key));
        await tester.pump();

        // Check if onChanged was called
        expect(wasButtonPressed, isTrue);
      },
    );

    group(
      'Golden Tests',
      () {
        goldenTest(
          'shows correctly',
          fileName: 'authentication_shared_login_button',
          builder: () => GoldenTestGroup(
            columnWidthBuilder: (columns) => const FixedColumnWidth(400.0),
            children: [
              GoldenTestScenario(
                name: 'enabled',
                child: SizedBox(
                  width: 380,
                  child: LoginButton(onChanged: () {}),
                ),
              ),
            ],
          ),
        );
      },
    );
  });
}
