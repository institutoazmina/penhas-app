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
              name: 'PenhasButton.roundedFilled',
              child: SizedBox(
                width: 250,
                child: PenhasButton.roundedFilled(
                  onPressed: () {},
                  child: buttonWidget,
                ),
              ),
            ),
            GoldenTestScenario(
              name: 'PenhasButton.roundedFilled/disabled',
              child: SizedBox(
                width: 250,
                child: PenhasButton.roundedFilled(
                  onPressed: null,
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
              name: 'PenhasButton.roundedOutlined',
              child: SizedBox(
                width: 250,
                child: PenhasButton.roundedOutlined(
                  onPressed: () {},
                  child: buttonWidget,
                ),
              ),
            ),
            GoldenTestScenario(
              name: 'PenhasButton.roundedOutlined/disabled',
              child: SizedBox(
                width: 250,
                child: PenhasButton.roundedOutlined(
                  onPressed: null,
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
              name: 'PenhasButton.text',
              child: SizedBox(
                width: 250,
                child: PenhasButton.text(
                  onPressed: () {},
                  child: buttonWidget,
                ),
              ),
            ),
            GoldenTestScenario(
              name: 'PenhasButton.text/disabled',
              child: SizedBox(
                width: 250,
                child: PenhasButton.text(
                  onPressed: null,
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
              name: 'PenhasButton.filled',
              child: SizedBox(
                width: 250,
                child: PenhasButton.filled(
                  onPressed: () {},
                  child: buttonWidget,
                ),
              ),
            ),
            GoldenTestScenario(
              name: 'PenhasButton.filled/disabled',
              child: SizedBox(
                width: 250,
                child: PenhasButton.filled(
                  onPressed: null,
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
