import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/help_center/presentation/pages/tutorial/record/record_tutorial_page.dart';

import '../../../../../../../utils/golden_tests.dart';

void main() {
  group(RecordTutorialPage, () {
    screenshotTest('should show record tutorial page',
        fileName: 'record_tutorial_page',
        pageBuilder: () => Scaffold(body: RecordTutorialPage()));
  });
}
