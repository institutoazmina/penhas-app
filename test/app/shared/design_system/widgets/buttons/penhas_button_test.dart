import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/shared/design_system/widgets/buttons/penhas_button.dart';
import 'package:penhas/app/shared/design_system/widgets/buttons/styles/flat_button_style.dart';
import 'package:penhas/app/shared/design_system/widgets/buttons/styles/rounded_button_style.dart';
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
          columnWidthBuilder: (_) => const FixedColumnWidth(480.0),
          children: [
            GoldenTestScenario(
              name: 'PenhasButton/RoundedButtonStyle',
              child: SizedBox(
                width: 250,
                child: PenhasButton(
                  onPressed: () {},
                  child: buttonWidget,
                  style: RoundedButtonStyle(),
                ),
              ),
            ),
            GoldenTestScenario(
              name: 'PenhasButton.roundedButton/RoundedButtonStyle',
              child: SizedBox(
                width: 250,
                child: PenhasButton.roundedButton(
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
              name: 'PenhasButton/FlatButtonStyle',
              child: SizedBox(
                width: 250,
                child: PenhasButton(
                  onPressed: () {},
                  child: buttonWidget,
                  style: FlatButtonStyle(),
                ),
              ),
            ),
            GoldenTestScenario(
              name: 'PenhasButton.flatButton/FlatButtonStyle',
              child: SizedBox(
                width: 250,
                child: PenhasButton.flatButton(
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
