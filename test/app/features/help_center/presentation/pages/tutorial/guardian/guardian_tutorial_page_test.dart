import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/help_center/presentation/pages/tutorial/guardian/guardian_tutorial_page.dart';

import '../../../../../../../utils/golden_tests.dart';

void main() {
  group(GuardianTutorialPage, () {
    screenshotTestSimplified('should show guardian tutorial page',
        fileName: 'guardian_tutorial_page',
        pageBuilder: () => Scaffold(body: GuardianTutorialPage()));
  });
}
