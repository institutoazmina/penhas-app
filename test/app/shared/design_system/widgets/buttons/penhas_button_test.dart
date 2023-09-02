import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/shared/design_system/widgets/buttons/penhas_button.dart';
import 'package:penhas/app/shared/design_system/widgets/buttons/styles/filled_button_style.dart';
import 'package:penhas/app/shared/design_system/widgets/buttons/styles/rounded_filled_button_style.dart';
import 'package:penhas/app/shared/design_system/widgets/buttons/styles/rounded_outlined_button_style.dart';
import 'package:penhas/app/shared/design_system/widgets/buttons/styles/text_button_style.dart';

import '../../../../../utils/golden_tests.dart';

void main() {
  late Widget buttonWidget;

  setUp(() {
    buttonWidget = const Text('Button Title');
  });

  group(PenhasButton, () {
    group('golden test', () {
      widgetScreenshotTest(
        'looks as expected',
        fileName: 'penhas_button',
        widgetBuilder: (ctx) => GoldenTestGroup(
          columns: 1,
          columnWidthBuilder: (_) => const FixedColumnWidth(600.0),
          children: [
            GoldenTestScenario(
              name: 'PenhasButton/RoundedFilledButtonStyle',
              child: SizedBox(
                width: 250,
                child: PenhasButton(
                  onPressed: () {},
                  child: buttonWidget,
                  style: RoundedFilledButtonStyle(),
                ),
              ),
            ),
            GoldenTestScenario(
              name: 'PenhasButton.roundedFilledButton/RoundedFilledButtonStyle',
              child: SizedBox(
                width: 250,
                child: PenhasButton.roundedFilledButton(
                  onPressed: () {},
                  child: buttonWidget,
                ),
              ),
            ),
            GoldenTestScenario(
              name: 'PenhasButton/RoundedOutlinedButtonStyle',
              child: SizedBox(
                width: 250,
                child: PenhasButton(
                  onPressed: () {},
                  child: buttonWidget,
                  style: RoundedOutlinedButtonStyle(),
                ),
              ),
            ),
            GoldenTestScenario(
              name:
                  'PenhasButton.roundedOutlinedButton/RoundedOutlinedButtonStyle',
              child: SizedBox(
                width: 250,
                child: PenhasButton.roundedOutlinedButton(
                  onPressed: () {},
                  child: buttonWidget,
                ),
              ),
            ),
            GoldenTestScenario(
              name: 'PenhasButton/TextButtonStyle',
              child: SizedBox(
                width: 250,
                child: PenhasButton(
                  onPressed: () {},
                  child: buttonWidget,
                  style: TextButtonStyle(),
                ),
              ),
            ),
            GoldenTestScenario(
              name: 'PenhasButton.textButton/TextButtonStyle',
              child: SizedBox(
                width: 250,
                child: PenhasButton.textButton(
                  onPressed: () {},
                  child: buttonWidget,
                ),
              ),
            ),
            GoldenTestScenario(
              name: 'PenhasButton/FilledButtonStyle',
              child: SizedBox(
                width: 250,
                child: PenhasButton(
                  onPressed: () {},
                  child: buttonWidget,
                  style: FilledButtonStyle(),
                ),
              ),
            ),
            GoldenTestScenario(
              name: 'PenhasButton.filledButton/FilledButtonStyle',
              child: SizedBox(
                width: 250,
                child: PenhasButton.filledButton(
                  onPressed: () {},
                  child: buttonWidget,
                ),
              ),
            ),
          ],
        ),
      );
    });
  });
}
