import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/escape_manual/domain/entity/escape_manual.dart';
import 'package:penhas/app/features/escape_manual/presentation/escape_manual_controller.dart';
import 'package:penhas/app/features/escape_manual/presentation/escape_manual_page.dart';
import 'package:penhas/app/features/escape_manual/presentation/escape_manual_state.dart';
import 'package:penhas/app/shared/design_system/widgets/buttons/penhas_button.dart';

import '../../../../utils/golden_tests.dart';
import '../../../../utils/test_utils.dart';
import '../../../../utils/widget_tester_ext.dart';

void main() {
  late EscapeManualController mockController;

  setUpAll(() {
    registerFallbackValue(_FakeEscapeManualTaskEntity());
    registerFallbackValue(_FakeEscapeManualContactsTaskEntity());
    registerFallbackValue(_FakeButtonEntity());
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

  group(EscapeManualPage, skip: true, () {
    testWidgets(
      'should call load',
      (tester) async {
        // act
        await tester.pumpWidget(buildTestableWidget(EscapeManualPage(
          controller: mockController,
        )));

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
        await tester.pumpWidget(
            buildTestableWidget(EscapeManualPage(controller: mockController)));

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
        await tester.pumpWidget(
            buildTestableWidget(EscapeManualPage(controller: mockController)));

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
        await tester.pumpWidget(
            buildTestableWidget(EscapeManualPage(controller: mockController)));

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

        await tester.pumpWidget(
            buildTestableWidget(EscapeManualPage(controller: mockController)));

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
        await tester.pumpWidget(
            buildTestableWidget(EscapeManualPage(controller: mockController)));
        clearInteractions(mockController);

        // act
        await tester.tap(find.byType(PenhasButton));

        // assert
        verify(() => mockController.load()).called(1);
      },
    );

    testWidgets(
      'should call controller updateTask with done task when checkbox is pressed',
      (tester) async {
        // arrange
        final expectedTask = (escapeManualEntity.sections[1].tasks[4]
                as EscapeManualTodoTaskEntity)
            .copyWith(isDone: true);

        when(() => mockController.state)
            .thenReturn(EscapeManualState.loaded(escapeManualEntity));
        when(() => mockController.updateTask(any()))
            .thenAnswer((_) => Future.value());

        await tester.pumpWidget(
          buildTestableWidget(EscapeManualPage(controller: mockController)),
        );

        // act
        await tester.tap(find.widgetWithText(ExpansionTile, 'Section 1'));
        await tester.pumpAndSettle();

        final checkboxFinder = find.descendant(
          of: find.byKey(Key('escape-manual-task-1-4')),
          matching: find.byType(Checkbox),
        );

        await tester.ensureVisible(checkboxFinder);
        await tester.pumpAndSettle();

        await tester.tap(checkboxFinder);
        await tester.pumpAndSettle();

        // assert
        verify(() => mockController.updateTask(expectedTask)).called(1);
      },
    );

    testWidgets(
      'should call controller updateTask with not done task when checkbox is pressed',
      (tester) async {
        // arrange
        final expectedTask = (escapeManualEntity.sections[1].tasks[2]
                as EscapeManualTodoTaskEntity)
            .copyWith(isDone: false);

        when(() => mockController.state)
            .thenReturn(EscapeManualState.loaded(escapeManualEntity));
        when(() => mockController.updateTask(any()))
            .thenAnswer((_) => Future.value());
        await tester.pumpWidget(
            buildTestableWidget(EscapeManualPage(controller: mockController)));

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
        final expectedTask = escapeManualEntity.sections[1].tasks[1]
            as EscapeManualTodoTaskEntity;
        when(() => mockController.state)
            .thenReturn(EscapeManualState.loaded(escapeManualEntity));
        when(() => mockController.deleteTask(any()))
            .thenAnswer((_) => Future.value());
        await tester.pumpWidget(
            buildTestableWidget(EscapeManualPage(controller: mockController)));

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

    testWidgets(
      skip: true,
      'should call controller editTask when edit button is pressed',
      (tester) async {
        // arrange
        final expectedTask = escapeManualEntity.sections[1].tasks[4];
        when(() => mockController.state)
            .thenReturn(EscapeManualState.loaded(escapeManualEntity));
        when(() => mockController.editTask(any()))
            .thenAnswer((_) => Future.value());

        await tester.pumpWidget(
          buildTestableWidget(EscapeManualPage(controller: mockController)),
        );

        // act
        // Ensure section 1 is expanded and settled
        await tester.tap(find.widgetWithText(ExpansionTile, 'Section 1'));
        await tester.pumpAndSettle(); // Wait for expansion to complete

        // Locate the task widget by its key
        final taskKey = find.byKey(Key('escape-manual-task-1-4'));

        // Use the descendant finder to get the PopupMenuButton inside the specific task
        final popupMenuButtonFinder = find.descendant(
          of: taskKey,
          matching: find.byType(PopupMenuButton),
        );

        // Ensure that exactly one PopupMenuButton is found
        expect(popupMenuButtonFinder, findsOneWidget);

        // Tap on the PopupMenuButton to show the menu
        await tester.tap(popupMenuButtonFinder);
        await tester.pumpAndSettle(); // Wait for the menu to appear

        // Debug: Print the widget tree to see the available PopupMenuItems
        final popupMenuItems = tester.widgetList(find.byType(PopupMenuItem));
        print('PopupMenuItems found: $popupMenuItems');

        // Tap the 'Editar' option from the popup menu
        await tester.tap(find.textContaining('Editar'));
        await tester.pumpAndSettle(); // Wait for the interaction to settle

        // assert
        verify(
          () => mockController.editTask(
            expectedTask as EscapeManualContactsTaskEntity,
          ),
        ).called(1);
      },
    );

    testWidgets(
      skip: true,
      'should call controller callTo when call button is pressed',
      (tester) async {
        // arrange
        final task = escapeManualEntity.sections[1].tasks[4]
            as EscapeManualContactsTaskEntity;
        final expectedContact = task.value![1];
        when(() => mockController.state)
            .thenReturn(EscapeManualState.loaded(escapeManualEntity));
        await tester.pumpWidget(
            buildTestableWidget(EscapeManualPage(controller: mockController)));

        // act
        await tester.tap(
          find.widgetWithText(ExpansionTile, 'Section 1'),
        );
        await tester.pumpAndSettle();
        await tester.tap(
          find
              .descendant(
                of: find.byKey(Key('escape-manual-task-1-4')),
                matching: find.textContaining('Ligar'),
              )
              .first,
        );

        // assert
        verify(() => mockController.callTo(expectedContact)).called(1);
      },
    );

    testWidgets(
      'should call controller onButtonPressed when task button is pressed',
      (tester) async {
        // arrange
        final task = escapeManualEntity.sections[1].tasks[0]
            as EscapeManualButtonTaskEntity;
        final expectedButton = task.button;

        when(() => mockController.state)
            .thenReturn(EscapeManualState.loaded(escapeManualEntity));
        when(() => mockController.onButtonPressed(any()))
            .thenAnswer((_) => Future.value());

        await tester.pumpWidget(
            buildTestableWidget(EscapeManualPage(controller: mockController)));

        // act
        await tester.tap(
          find.widgetWithText(ExpansionTile, 'Section 1'),
        );
        await tester.pumpAndSettle();
        await tester.tap(
          find
              .descendant(
                of: find.byKey(Key('escape-manual-task-1-0')),
                matching: find.textContaining('Task button'),
              )
              .first,
        );

        // assert
        verify(() => mockController.onButtonPressed(expectedButton)).called(1);
      },
    );

    group('goldens', () {
      screenshotTest(
        'should populate load state',
        fileName: 'escape_manual_page_loaded',
        setUp: () {
          when(() => mockController.isDataFresh).thenReturn(true);

          when(() => mockController.state).thenReturn(
            EscapeManualState.loaded(escapeManualEntity),
          );
        },
        pageBuilder: () => EscapeManualPage(controller: mockController),
      );

      screenshotTest(
        'should show tasks after open section',
        fileName: 'escape_manual_page_sections',
        setUp: () {
          when(() => mockController.isDataFresh).thenReturn(true);

          when(() => mockController.state).thenReturn(
            EscapeManualState.loaded(escapeManualEntity),
          );
        },
        pageBuilder: () => EscapeManualPage(controller: mockController),
        pumpBeforeTest: (tester) async {
          await tester.tapAll(
            find.widgetWithText(ExpansionTile, 'Section 1'),
          );
        },
      );

      screenshotTest(
        'should check task with opened section',
        fileName: 'escape_manual_page_task_check',
        setUp: () async {
          when(() => mockController.isDataFresh).thenReturn(true);

          when(() => mockController.state).thenReturn(
            EscapeManualState.loaded(escapeManualEntity),
          );
        },
        pageBuilder: () => EscapeManualPage(controller: mockController),
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

      screenshotTestSimplified(
        'should show task options menu',
        fileName: 'escape_manual_page_task_options',
        setUp: () {
          when(() => mockController.state).thenReturn(
            EscapeManualState.loaded(escapeManualEntity),
          );
        },
        pageBuilder: () => EscapeManualPage(controller: mockController),
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

      screenshotTestSimplified(
        'should show task options menu with edit option',
        fileName: 'escape_manual_page_task_options_edit',
        setUp: () {
          when(() => mockController.state).thenReturn(
            EscapeManualState.loaded(escapeManualEntity),
          );
        },
        pageBuilder: () => EscapeManualPage(controller: mockController),
        pumpBeforeTest: (tester) async {
          await tester.tapAll(
            find.widgetWithText(ExpansionTile, 'Section 1'),
          );
          await tester.pumpAndSettle();
          await tester.tapAll(
            find.descendant(
              of: find.byKey(Key('escape-manual-task-1-4')),
              matching: find.byType(PopupMenuButton),
            ),
          );
        },
      );

      screenshotTest(
        'should show error message when state is error',
        fileName: 'escape_manual_page_error',
        setUp: () {
          when(() => mockController.isDataFresh).thenReturn(true);

          when(() => mockController.state)
              .thenReturn(const EscapeManualState.error('error message'));
        },
        pageBuilder: () => EscapeManualPage(controller: mockController),
      );

      screenshotTest(
        'should show call snackbar message when reaction is showSnackbar',
        fileName: 'escape_manual_page_reaction_error',
        setUp: () async {
          when(() => mockController.isDataFresh).thenReturn(true);

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
        pageBuilder: () => EscapeManualPage(controller: mockController),
      );
    });
  });
}

class _MockEscapeManualController extends Mock
    implements EscapeManualController {}

class _MockReactionDisposer extends Mock implements mobx.ReactionDisposer {}

class _FakeEscapeManualTaskEntity extends Fake
    implements EscapeManualTaskEntity {
  @override
  String get id => 'id';
}

class _FakeEscapeManualContactsTaskEntity extends Fake
    implements EscapeManualContactsTaskEntity {}

class _FakeButtonEntity extends Fake implements ButtonEntity {}

EscapeManualEntity get escapeManualEntity => EscapeManualEntity(
      assistant: EscapeManualAssistantEntity(
        explanation: 'Explanation text',
        action: EscapeManualAssistantActionEntity(
          text: 'Action text',
          quizSession: QuizSessionEntity(
            sessionId: 'session id',
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
            6,
            (task) => _fakeTaskGenerator(section, task),
          ),
        ),
      ),
    );

EscapeManualTaskEntity _fakeTaskGenerator(int section, int task) {
  switch (task) {
    case 0:
      return EscapeManualButtonTaskEntity(
        id: '${section}-${task}',
        description: 'Task #${task} of section ${section}',
        button: ButtonEntity(
          label: 'Task button',
          route: '/route',
          arguments: null,
        ),
      );
    case 4:
      return EscapeManualContactsTaskEntity(
        id: '${section}-${task}',
        description: 'Task #${task} of section ${section}',
        value: [
          ContactEntity(
            id: 2,
            name: 'Contact name 2',
            phone: '(11) 22222-2222',
          ),
          ContactEntity(
            id: 1,
            name: 'Contact name',
            phone: '(11) 1111-1111',
          ),
        ],
      );
    case 5:
      return _FakeEscapeManualTaskEntity();
    default:
      return EscapeManualDefaultTaskEntity(
        id: '${section}-${task}',
        description: 'Task #${task} of section ${section}',
        isDone: task == 2,
      );
  }
}
