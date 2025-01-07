import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_help_alert.dart';

import '../../../../../utils/golden_tests.dart';
import '../../../../../utils/widget_test_steps.dart';

void main() {
  group('SupportCenterHelpAlert', () {
    testWidgets('should render alert with correct text and button',
        (WidgetTester tester) async {
      // arrange
      await tester.theAppIsRunning(
        const Scaffold(body: SupportCenterHelpAlert()),
      );
      // assert
      iSeeWidget(AlertDialog);
      iSeeText(
        'Pontos de apoio são serviços que integram toda a rede de acolhimento a mulheres vítimas de violência, como por exemplo delegacia da mulher, hospital, centro de atendimento à mulher em situação de violência, entre outros.',
      );
      iSeeText('Entendi');
    });

    testWidgets('should close alert when clicking on Understand button',
        (WidgetTester tester) async {
      // arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (_) => const SupportCenterHelpAlert(),
                );
              },
              child: const Text('Open Alert'),
            ),
          ),
        ),
      );
      // act
      await tester.iTapText(text: 'Open Alert');
      // assert alert is visible
      iSeeWidget(AlertDialog);
      // Act - tap on Understand button
      await tester.iTapText(text: 'Entendi');
      // Assert alert is closed
      iDontSeeWidget(AlertDialog);
    });
  });

  screenshotTest(
    'looks as expected',
    fileName: 'support_center_help_alert',
    pageBuilder: () => const Scaffold(
      body: SupportCenterHelpAlert(),
    ),
  );
}
