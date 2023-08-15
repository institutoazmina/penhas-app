import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/presentation/shared/input_box_style.dart';

import '../../../../../utils/golden_tests.dart';

void main() {
  group(WhiteBoxDecorationStyle, () {
    group('golden tests', () {
      widgetScreenshotTest(
        'looks as expected',
        fileName: 'white_box_decoration_style',
        widgetBuilder: (ctx) => GoldenTestGroup(
          columns: 1,
          columnWidthBuilder: (columns) => const FixedColumnWidth(400.0),
          children: [
            GoldenTestScenario(
              name: 'Label',
              child: TextFormField(
                decoration: WhiteBoxDecorationStyle(labelText: 'Label text'),
              ),
            ),
            GoldenTestScenario(
              name: 'Hint',
              child: TextFormField(
                autofocus: true,
                decoration: WhiteBoxDecorationStyle(
                  labelText: 'Label text',
                  hintText: 'Hint text',
                ),
              ),
            ),
            GoldenTestScenario(
              name: 'Error',
              child: TextFormField(
                decoration: WhiteBoxDecorationStyle(
                  labelText: 'Label text',
                  errorText: 'Error text',
                ),
              ),
            ),
          ],
        ),
      );
    });
  });

  group(PurpleBoxDecorationStyle, () {
    group('golden tests', () {
      widgetScreenshotTest(
        'looks as expected',
        fileName: 'purple_box_decoration_style',
        widgetBuilder: (ctx) => GoldenTestGroup(
          columns: 1,
          columnWidthBuilder: (columns) => const FixedColumnWidth(400.0),
          children: [
            GoldenTestScenario(
              name: 'Label',
              child: TextFormField(
                decoration: PurpleBoxDecorationStyle(labelText: 'Label text'),
              ),
            ),
            GoldenTestScenario(
              name: 'Hint',
              child: TextFormField(
                autofocus: true,
                decoration: PurpleBoxDecorationStyle(
                  labelText: 'Label text',
                  hintText: 'Hint text',
                ),
              ),
            ),
            GoldenTestScenario(
              name: 'Error',
              child: TextFormField(
                decoration: PurpleBoxDecorationStyle(
                  labelText: 'Label text',
                  errorText: 'Error text',
                ),
              ),
            ),
          ],
        ),
      );
    });
  });
}
