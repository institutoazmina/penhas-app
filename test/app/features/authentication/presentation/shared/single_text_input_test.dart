import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/presentation/shared/input_box_style.dart';
import 'package:penhas/app/features/authentication/presentation/shared/single_text_input.dart';

import '../../../../../utils/golden_tests.dart';

void main() {
  group(SingleTextInput, () {
    testWidgets('widget loaded', (WidgetTester tester) async {
      String inputText = '';
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SingleTextInput(
            onChanged: (val) => inputText = val,
            boxDecoration: WhiteBoxDecorationStyle(
              labelText: 'Test Input',
            ),
          ),
        ),
      ));

      expect(
        find.byType(SingleTextInput),
        findsOneWidget,
        reason: 'SingleTextInput should be present',
      );

      // Enter text into the TextField.
      await tester.enterText(find.byType(TextField), 'test');
      await tester.pump();

      expect(
        inputText,
        'test',
        reason: 'onChanged should have been called',
      );
    });

    group('golden tests', () {
      widgetScreenshotTest(
        'shows correctly',
        fileName: 'authentication_shared_single_text_input',
        widgetBuilder: (ctx) => GoldenTestGroup(
          columns: 1,
          columnWidthBuilder: (columns) => const FixedColumnWidth(400.0),
          children: [
            GoldenTestScenario(
              name: 'enabled',
              child: SingleTextInput(
                onChanged: (v) {},
                boxDecoration: WhiteBoxDecorationStyle(
                  labelText: 'Label text',
                  hintText: 'Hint text',
                ),
              ),
            ),
          ],
        ),
      );
    });
  });
}
