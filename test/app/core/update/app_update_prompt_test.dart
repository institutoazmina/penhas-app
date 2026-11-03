import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/update/app_update_checker.dart';
import 'package:penhas/app/core/update/app_update_launcher.dart';
import 'package:penhas/app/core/update/app_update_prompt.dart';

void main() {
  late _MockAppUpdateChecker checker;
  late _MockAppUpdateLauncher launcher;

  setUp(() {
    checker = _MockAppUpdateChecker();
    launcher = _MockAppUpdateLauncher();
    when(() => launcher.launch()).thenAnswer((_) async {});
  });

  Future<void> pumpPrompt(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        builder: Asuka.builder,
        home: AppUpdatePrompt(
          checker: checker,
          launcher: launcher,
          child: const Scaffold(body: Text('App content')),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('does not display a prompt when the app is current',
      (tester) async {
    when(() => checker.shouldPrompt()).thenAnswer((_) async => false);

    await pumpPrompt(tester);

    expect(find.text('Atualização disponível'), findsNothing);
    expect(find.text('App content'), findsOneWidget);
  });

  testWidgets('allows the user to continue without updating', (tester) async {
    when(() => checker.shouldPrompt()).thenAnswer((_) async => true);

    await pumpPrompt(tester);
    await tester.tap(find.text('Continuar'));
    await tester.pumpAndSettle();

    expect(find.text('Atualização disponível'), findsNothing);
    verifyNever(() => launcher.launch());
  });

  testWidgets('starts the update when requested', (tester) async {
    when(() => checker.shouldPrompt()).thenAnswer((_) async => true);

    await pumpPrompt(tester);
    await tester.tap(find.text('Atualizar agora'));
    await tester.pumpAndSettle();

    verify(() => launcher.launch()).called(1);
  });
}

class _MockAppUpdateChecker extends Mock implements AppUpdateChecker {}

class _MockAppUpdateLauncher extends Mock implements AppUpdateLauncher {}
