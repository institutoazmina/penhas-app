import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/help_center/domain/entities/guardian_session_entity.dart';
import 'package:penhas/app/features/help_center/domain/entities/guardian_tile_entity.dart';
import 'package:penhas/app/features/help_center/presentation/pages/guardian_tile_action_card.dart';

import '../../../../../utils/golden_tests.dart';
import '../../../../../utils/widget_test_steps.dart';

class MockOnEditPressed extends Mock {
  void call(String name);
}

class MockOnDeletePressed extends Mock {
  void call();
}

class MockonResendPressed extends Mock {
  void call();
}

void main() {
  late GuardianTileCardEntity card;
  late MockOnEditPressed mockOnEditPressed;
  late MockOnDeletePressed mockOnDeletePressed;
  late MockonResendPressed mockOnResendPressed;

  setUp((){
    mockOnEditPressed = MockOnEditPressed();
    mockOnDeletePressed = MockOnDeletePressed();
    mockOnResendPressed = MockonResendPressed();
    card = GuardianTileCardEntity(deleteWarning: 'warning', onEditPressed: mockOnEditPressed, guardian: GuardianContactEntity(id: 1, mobile: 'mobile', name: 'name', status: 'status'));
  });

  group(GuardianTileActionCard, (){
    testWidgets('Should show page successfully', (tester) async {

      await theAppIsRunning(tester, GuardianTileActionCard(card: card,));

      iSeeText('name');
      iSeeText('mobile');
      iSeeText('status');
    });

    testWidgets('Should show page with edit button', (tester) async {

      when(() => mockOnEditPressed.call(any())).thenReturn(null);

      await theAppIsRunning(tester, GuardianTileActionCard(card: card,));

      final iconButtonFinder = find.byType(IconButton);

    expect(iconButtonFinder, findsOneWidget);
    });

    testWidgets('Should show page with delete button', (tester) async {

     final cardWithDelete = GuardianTileCardEntity(deleteWarning: 'warning', onDeletePressed: mockOnDeletePressed, guardian: GuardianContactEntity(id: 1, mobile: 'mobile', name: 'name', status: 'status'));

      when(() => mockOnDeletePressed.call()).thenReturn(null);

      await theAppIsRunning(tester, GuardianTileActionCard(card: cardWithDelete,));

      final iconButtonFinder = find.byType(IconButton);

    expect(iconButtonFinder, findsOneWidget);
    });

    testWidgets('Should show page with resend button', (tester) async {

     final cardWithResend = GuardianTileCardEntity(deleteWarning: 'warning', onResendPressed: mockOnResendPressed, guardian: GuardianContactEntity(id: 1, mobile: 'mobile', name: 'name', status: 'status'));

      when(() => mockOnDeletePressed.call()).thenReturn(null);

      await theAppIsRunning(tester, GuardianTileActionCard(card: cardWithResend,));

      final iconButtonFinder = find.byType(IconButton);

    expect(iconButtonFinder, findsOneWidget);
    });

    screenshotTest('Should render page', fileName: 'guardian_tile_action', pageBuilder: ()=> GuardianTileActionCard(card: card,));
  });
}