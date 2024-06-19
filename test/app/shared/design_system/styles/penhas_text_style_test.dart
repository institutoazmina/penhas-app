import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/shared/design_system/styles/penhas_text_style.dart';

import '../../../../utils/golden_tests.dart';

void main() {
  group(PenhasTextStyle, () {
    group('golden test', () {
      widgetScreenshotTest(
        'looks as expected',
        fileName: 'penhas_text_style',
        widgetBuilder: (ctx) => GoldenTestGroup(
          columns: 1,
          columnWidthBuilder: (_) => const FixedColumnWidth(400.0),
          children: [
            GoldenTestScenario(
              name: 'Display Large',
              child: const Text(
                'Display Large',
                style: PenhasTextStyle.displayLarge,
              ),
            ),
            GoldenTestScenario(
              name: 'Display Medium',
              child: const Text(
                'Display Medium',
                style: PenhasTextStyle.displayMedium,
              ),
            ),
            GoldenTestScenario(
              name: 'Display Small',
              child: const Text(
                'Display Small',
                style: PenhasTextStyle.displaySmall,
              ),
            ),
            GoldenTestScenario(
              name: 'Headline Large',
              child: const Text(
                'Headline Large',
                style: PenhasTextStyle.headlineLarge,
              ),
            ),
            GoldenTestScenario(
              name: 'Headline Medium',
              child: const Text(
                'Headline Medium',
                style: PenhasTextStyle.headlineMedium,
              ),
            ),
            GoldenTestScenario(
              name: 'Headline Small',
              child: const Text(
                'Headline Small',
                style: PenhasTextStyle.headlineSmall,
              ),
            ),
            GoldenTestScenario(
              name: 'Title Large',
              child: const Text(
                'Title Large',
                style: PenhasTextStyle.titleLarge,
              ),
            ),
            GoldenTestScenario(
              name: 'Title Medium',
              child: const Text(
                'Title Medium',
                style: PenhasTextStyle.titleMedium,
              ),
            ),
            GoldenTestScenario(
              name: 'Title Small',
              child: const Text(
                'Title Small',
                style: PenhasTextStyle.titleSmall,
              ),
            ),
            GoldenTestScenario(
              name: 'Label Large',
              child: const Text(
                'Label Large',
                style: PenhasTextStyle.labelLarge,
              ),
            ),
            GoldenTestScenario(
              name: 'Label Medium',
              child: const Text(
                'Label Medium',
                style: PenhasTextStyle.labelMedium,
              ),
            ),
            GoldenTestScenario(
              name: 'Label Small',
              child: const Text(
                'Label Small',
                style: PenhasTextStyle.labelSmall,
              ),
            ),
            GoldenTestScenario(
              name: 'Body Large',
              child: const Text(
                'Body Large',
                style: PenhasTextStyle.bodyLarge,
              ),
            ),
            GoldenTestScenario(
              name: 'Body Medium',
              child: const Text(
                'Body Medium',
                style: PenhasTextStyle.bodyMedium,
              ),
            ),
            GoldenTestScenario(
              name: 'Body Small',
              child: const Text(
                'Body Small',
                style: PenhasTextStyle.bodySmall,
              ),
            ),
          ],
        ),
      );
    });
  });
}
