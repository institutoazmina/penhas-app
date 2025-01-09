import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/help_center/presentation/pages/guardian_error_page.dart';

import '../../../../../utils/golden_tests.dart';
import '../../../../../utils/widget_test_steps.dart';

class MockResetAction extends Mock {
  void call();
}

void main() {
  var message;
  var mockAction = MockResetAction();
  setUp(() {
    message =
        'O servidor está inacessível, o PenhaS está com acesso à Internet?';
  });

  group(GuardianErrorPage, () {
    testWidgets('Should show page successfully', (tester) async {
      await theAppIsRunning(
          tester,
          GuardianErrorPage(
            message: message,
            onPressed: mockAction,
          ));

      iSeeText('Ocorreu um erro!');
      iSeeText(message);
      iSeeText('Tentar novamente');
    });

    testWidgets('shoul call void function when click on Tentar Novamente',
        (tester) async {
      when(() => mockAction.call()).thenReturn(null);

      await theAppIsRunning(
          tester,
          GuardianErrorPage(
            message: message,
            onPressed: mockAction,
          ));

      await tester.tap(find.byIcon(Icons.loop));

      verify(() => mockAction.call()).called(1);
    });

    screenshotTest('Should render the page',
        fileName: 'guardian_error_page',
        pageBuilder: () => GuardianErrorPage(
              message: message,
              onPressed: mockAction,
            ));
  });
}
