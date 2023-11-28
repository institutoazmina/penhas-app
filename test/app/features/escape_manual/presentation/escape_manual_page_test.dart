import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/escape_manual/domain/entity/escape_manual.dart';
import 'package:penhas/app/features/escape_manual/presentation/escape_manual_controller.dart';
import 'package:penhas/app/features/escape_manual/presentation/escape_manual_page.dart';
import 'package:penhas/app/features/escape_manual/presentation/escape_manual_state.dart';

import '../../../../utils/aditional_bind_module.dart';
import '../../../../utils/golden_tests.dart';
import '../../../../utils/widget_tester_ext.dart';

void main() {
  enableWarnWhenNoObservables = false;

  late EscapeManualController mockController;
  late Module module = AditionalBindModule(
    binds: [
      Bind.factory<EscapeManualController>((_) => mockController),
    ],
  );

  setUpAll(() {
    initModule(module);
    registerFallbackValue(_FakeEscapeManualTaskEntity());
  });

  setUp(() {
    mockController = _MockEscapeManualController();

    when(() => mockController.load()).thenAnswer((_) => Future.value());
    when(() => mockController.state)
        .thenReturn(const EscapeManualState.initial());
    when(() => mockController.progressState)
        .thenReturn(PageProgressState.initial);
    when(() => mockController.onReaction(any()))
        .thenAnswer((invocation) => _MockReactionDisposer());

    when(() => mockController.dispose()).thenAnswer((_) async {});
    when(() => mockController.updateTask(any())).thenAnswer((_) async {});
  });

  tearDownAll(() {
    Modular.removeModule(module);
  });

  group(EscapeManualPage, () {
    testWidgets(
      'should call load',
      (tester) async {
        // act
        await tester.pumpWidget(buildTestableWidget(const EscapeManualPage()));

        // assert
        verify(() => mockController.load()).called(1);
      },
    );

    testWidgets(
      'should show progress indicator when progressState is loading',
      (tester) async {
        // arrange
        when(() => mockController.progressState)
            .thenReturn(PageProgressState.loading);

        // act
        await tester.pumpWidget(buildTestableWidget(const EscapeManualPage()));

        // assert
        expect(find.text('Carregando...'), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'should not show progress indicator when progressState is initial',
      (tester) async {
        // arrange
        when(() => mockController.progressState)
            .thenReturn(PageProgressState.initial);

        // act
        await tester.pumpWidget(buildTestableWidget(const EscapeManualPage()));

        // assert
        expect(find.text('Carregando...'), findsNothing);
        expect(find.byType(CircularProgressIndicator), findsNothing);
      },
    );

    testWidgets(
      'should not show progress indicator when progressState is loaded',
      (tester) async {
        // arrange
        when(() => mockController.progressState)
            .thenReturn(PageProgressState.loaded);

        // act
        await tester.pumpWidget(buildTestableWidget(const EscapeManualPage()));

        // assert
        expect(find.text('Carregando...'), findsNothing);
        expect(find.byType(CircularProgressIndicator), findsNothing);
      },
    );

    testWidgets(
      'should call controller openAssistant when button is pressed',
      (tester) async {
        // arrange
        const assistantAction = EscapeManualAssistantActionEntity(
          text: 'button',
          quizSession: QuizSessionEntity(
            currentMessage: null,
            sessionId: 'session id',
            isFinished: false,
            endScreen: null,
          ),
        );

        when(() => mockController.state).thenAnswer(
          (_) => const EscapeManualState.loaded(
            EscapeManualEntity(
              assistant: EscapeManualAssistantEntity(
                explanation: 'explanation',
                action: assistantAction,
              ),
              sections: [],
            ),
          ),
        );
        when(() => mockController.openAssistant(assistantAction))
            .thenAnswer((_) => Future.value());

        await tester.pumpWidget(buildTestableWidget(const EscapeManualPage()));

        // act
        await tester.tap(find.widgetWithText(OutlinedButton, 'button'));

        // assert
        verify(() => mockController.openAssistant(assistantAction)).called(1);
      },
    );

    testWidgets(
      'should show call controller load when state is error and button is pressed',
      (tester) async {
        // arrange
        when(() => mockController.state)
            .thenReturn(const EscapeManualState.error('error message'));
        await tester.pumpWidget(buildTestableWidget(const EscapeManualPage()));
        clearInteractions(mockController);

        // act
        await tester.tap(find.byIcon(Icons.loop));

        // assert
        verify(() => mockController.load()).called(1);
      },
    );

    testWidgets(
      'should call controller updateTask with done task when checkbox is pressed',
      (tester) async {
        // arrange
        final expectedTask =
            escapeManualEntity.sections[1].tasks[1].copyWith(isDone: true);
        when(() => mockController.state)
            .thenReturn(EscapeManualState.loaded(escapeManualEntity));
        when(() => mockController.updateTask(any()))
            .thenAnswer((_) => Future.value());
        await tester.pumpWidget(buildTestableWidget(const EscapeManualPage()));

        // act
        await tester.tapAll(
          find.widgetWithText(ExpansionTile, 'Section 1'),
        );
        await tester.pumpAndSettle();
        await tester.tap(
          find.descendant(
            of: find.byKey(Key('escape-manual-task-1-1')),
            matching: find.byType(Checkbox),
          ),
        );

        // assert
        verify(() => mockController.updateTask(expectedTask)).called(1);
      },
    );

    testWidgets(
      'should call controller updateTask with not done task when checkbox is pressed',
      (tester) async {
        // arrange
        final expectedTask =
            escapeManualEntity.sections[1].tasks[2].copyWith(isDone: false);
        when(() => mockController.state)
            .thenReturn(EscapeManualState.loaded(escapeManualEntity));
        when(() => mockController.updateTask(any()))
            .thenAnswer((_) => Future.value());
        await tester.pumpWidget(buildTestableWidget(const EscapeManualPage()));

        // act
        await tester.tapAll(
          find.widgetWithText(ExpansionTile, 'Section 1'),
        );
        await tester.pumpAndSettle();
        await tester.tap(
          find.descendant(
            of: find.byKey(Key('escape-manual-task-1-2')),
            matching: find.byType(Checkbox),
          ),
        );

        // assert
        verify(() => mockController.updateTask(expectedTask)).called(1);
      },
    );

    testWidgets(
      'should call controller deleteTask when delete button is pressed',
      (tester) async {
        // arrange
        final expectedTask = escapeManualEntity.sections[1].tasks[1];
        when(() => mockController.state)
            .thenReturn(EscapeManualState.loaded(escapeManualEntity));
        when(() => mockController.deleteTask(any()))
            .thenAnswer((_) => Future.value());
        await tester.pumpWidget(buildTestableWidget(const EscapeManualPage()));

        // act
        await tester.tapAll(
          find.widgetWithText(ExpansionTile, 'Section 1'),
        );
        await tester.pumpAndSettle();
        await tester.tap(
          find.descendant(
            of: find.byKey(Key('escape-manual-task-1-1')),
            matching: find.byType(PopupMenuButton),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(
          find.textContaining('Apagar'),
        );

        // assert
        verify(() => mockController.deleteTask(expectedTask)).called(1);
      },
    );

    group('goldens', () {
      screenshotTest(
        'should populate load state',
        fileName: 'escape_manual_page_loaded',
        setUp: () {
          when(() => mockController.state).thenReturn(
            EscapeManualState.loaded(escapeManualEntity),
          );
        },
        pageBuilder: () => const EscapeManualPage(),
      );

      screenshotTest(
        'should show tasks after open section',
        fileName: 'escape_manual_page_sections',
        setUp: () {
          when(() => mockController.state).thenReturn(
            EscapeManualState.loaded(escapeManualEntity),
          );
        },
        pageBuilder: () => const EscapeManualPage(),
        pumpBeforeTest: (tester) async {
          await tester.tapAll(
            find.widgetWithText(ExpansionTile, 'Section 1'),
          );
        },
      );

      screenshotTest(
        'should check task with opened section',
        fileName: 'escape_manual_page_task_check',
        setUp: () {
          when(() => mockController.state).thenReturn(
            EscapeManualState.loaded(escapeManualEntity),
          );
        },
        pageBuilder: () => const EscapeManualPage(),
        pumpBeforeTest: (tester) async {
          await tester.tapAll(
            find.widgetWithText(ExpansionTile, 'Section 1'),
          );
          await tester.pumpAndSettle();
          await tester.tapAll(
            find.descendant(
              of: find.byKey(Key('escape-manual-task-1-1')),
              matching: find.byType(Checkbox),
            ),
          );
        },
      );

      screenshotTest(
        'should show task options menu',
        fileName: 'escape_manual_page_task_options',
        setUp: () {
          when(() => mockController.state).thenReturn(
            EscapeManualState.loaded(escapeManualEntity),
          );
        },
        pageBuilder: () => const EscapeManualPage(),
        pumpBeforeTest: (tester) async {
          await tester.tapAll(
            find.widgetWithText(ExpansionTile, 'Section 1'),
          );
          await tester.pumpAndSettle();
          await tester.tapAll(
            find.descendant(
              of: find.byKey(Key('escape-manual-task-1-1')),
              matching: find.byType(PopupMenuButton),
            ),
          );
        },
      );

      screenshotTest(
        'should show error message when state is error',
        fileName: 'escape_manual_page_error',
        setUp: () {
          when(() => mockController.state)
              .thenReturn(const EscapeManualState.error('error message'));
        },
        pageBuilder: () => const EscapeManualPage(),
      );

      screenshotTest(
        'should show call snackbar message when reaction is showSnackbar',
        fileName: 'escape_manual_page_reaction_error',
        setUp: () {
          when(() => mockController.state).thenReturn(
            EscapeManualState.loaded(escapeManualEntity),
          );
          when(() => mockController.onReaction(any())).thenAnswer(
            (invocation) {
              final onReaction = invocation.positionalArguments[0];
              final reaction = () async {
                await Future.delayed(const Duration(microseconds: 1));
                onReaction(
                  const EscapeManualReaction.showSnackBar('error message'),
                );
              };
              reaction();
              return _MockReactionDisposer();
            },
          );
        },
        pageBuilder: () => const EscapeManualPage(),
      );
    });
  });
}

class _MockEscapeManualController extends Mock
    implements EscapeManualController {}

class _MockReactionDisposer extends Mock implements mobx.ReactionDisposer {}

class _FakeEscapeManualTaskEntity extends Fake
    implements EscapeManualTaskEntity {}

EscapeManualEntity get escapeManualEntity => EscapeManualEntity(
      assistant: EscapeManualAssistantEntity(
        explanation: 'Explanation text',
        action: EscapeManualAssistantActionEntity(
          text: 'Action text',
          quizSession: QuizSessionEntity(
            sessionId: 'session id',
            currentMessage: null,
            isFinished: false,
            endScreen: null,
          ),
        ),
      ),
      sections: List.generate(
        10,
        (section) => EscapeManualTasksSectionEntity(
          title: 'Section $section',
          tasks: List.generate(
            5,
            (task) => EscapeManualTaskEntity(
              id: '${section}-${task}',
              type: 'checkbox',
              description: 'Task #${task} of section ${section}',
              isDone: task == 2,
              userInputValue: null,
            ),
          ),
        ),
      ),
    );
