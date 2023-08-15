import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';

void main() {
  group(PageProgressIndicator, () {
    testWidgets('shows and hides loading correctly',
        (WidgetTester tester) async {
      // Build the PageProgressIndicator in the initial state.
      await tester.pumpWidget(const MaterialApp(
        home: PageProgressIndicator(
          child: Text('Child'),
          progressState: PageProgressState.initial,
          progressMessage: 'Loading',
        ),
      ));

      expect(
        find.byType(CircularProgressIndicator),
        findsNothing,
        reason:
            'The CircularProgressIndicator should not be shown in the initial state.',
      );

      // Update the state to loading.
      await tester.pumpWidget(const MaterialApp(
        home: PageProgressIndicator(
          child: Text('Child'),
          progressState: PageProgressState.loading,
          progressMessage: 'Loading',
        ),
      ));

      // Pump the widget tree to let the animations finish.
      await tester.pump(const Duration(seconds: 1));

      expect(
        find.byType(CircularProgressIndicator),
        findsOneWidget,
        reason:
            'The CircularProgressIndicator should be shown in the loading state.',
      );

      // Update the state to loaded.
      await tester.pumpWidget(const MaterialApp(
        home: PageProgressIndicator(
          child: Text('Child'),
          progressState: PageProgressState.loaded,
          progressMessage: 'Loading',
        ),
      ));

      // Pump the widget tree to let the animations finish.
      await tester.pump(const Duration(seconds: 1));

      expect(
        find.byType(CircularProgressIndicator),
        findsNothing,
        reason:
            'The CircularProgressIndicator should not be shown in the loaded state.',
      );
    });
  });
}
