import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_gps_error.dart';

import '../../../../../utils/golden_tests.dart';
import '../../../../../utils/widget_test_steps.dart';

void main() {
  const testMessage =
      'Não foi possível identificar sua localização atual. Por favor, verifique se o GPS do seu dispositivo está ativado e tente novamente.';

  group(SupportCenterGpsError, () {
    testWidgets('should render all components correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SupportCenterGpsError(
            message: testMessage,
            onPressed: () {},
          ),
        ),
      );

      // Verify title text
      iSeeText('Localização inválida');

      // Verify error message
      iSeeText(testMessage);

      // Verify icons
      expect(find.byIcon(Icons.location_off), findsOneWidget);
      expect(find.byIcon(Icons.location_on), findsOneWidget);

      // Verify "Nova localização" text
      iSeeText('Nova localização');
    });

    screenshotTest(
      'support_center_gps_error',
      fileName: 'support_center_gps_error',
      pageBuilder: () => Scaffold(
        body: SizedBox.expand(
          child: SupportCenterGpsError(
            message: testMessage,
            onPressed: () {},
          ),
        ),
      ),
    );
  });
}
