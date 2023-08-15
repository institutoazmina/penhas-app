import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/presentation/shared/password_text_input.dart';

import '../../../../../utils/golden_tests.dart';

void main() {
  group(PassordInputField, () {
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
                  child: PassordInputField(
                    isAutofocus: true,
                    errorText: '',
                    hintText: 'Hint text',
                    labelText: '',
                    onChanged: (val) {},
                  ),
                ),
                GoldenTestScenario(
                  name: 'input value',
                  child: PassordInputField(
                    errorText: '',
                    hintText: 'Hint text',
                    labelText: 'P4Ssw0rd',
                    onChanged: (val) {},
                  ),
                ),
                GoldenTestScenario(
                  name: 'with error',
                  child: PassordInputField(
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
