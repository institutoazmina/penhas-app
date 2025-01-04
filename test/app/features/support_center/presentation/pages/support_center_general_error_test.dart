import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_general_error.dart';
import 'package:penhas/app/shared/design_system/widgets/buttons/penhas_button.dart';

import '../../../../../utils/golden_tests.dart';

void main() {
  group(SupportCenterGeneralError, () {
    testWidgets('should render all elements correctly', (tester) async {
      bool callbackCalled = false;
      const testMessage = 'Test error message';

      await tester.pumpWidget(
        MaterialApp(
          home: SupportCenterGeneralError(
            message: testMessage,
            onPressed: () => callbackCalled = true,
          ),
        ),
      );

      // Verify title text
      expect(find.text('Ocorreu um erro!'), findsOneWidget);

      // Verify warning icon
      expect(find.byIcon(Icons.warning), findsOneWidget);

      // Verify error message
      expect(find.text(testMessage), findsOneWidget);

      // Verify retry button and text
      expect(find.text('Tentar novamente'), findsOneWidget);

      // Test callback
      await tester.tap(find.byType(PenhasButton));
      await tester.pump();
      expect(callbackCalled, true);
    });
  });

  screenshotTest(
    'looks as expected',
    fileName: 'support_center_general_error',
    pageBuilder: () => Scaffold(
      body: SupportCenterGeneralError(
        message: 'Test message',
        onPressed: () {},
      ),
    ),
  );
}
