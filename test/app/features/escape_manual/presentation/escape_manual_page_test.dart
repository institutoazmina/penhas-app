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
  });

  setUp(() {
    mockController = EscapeManualControllerMock();

    when(() => mockController.load()).thenAnswer((_) => Future.value());
    when(() => mockController.state)
        .thenReturn(const EscapeManualState.initial());
    when(() => mockController.progressState)
        .thenReturn(PageProgressState.initial);
    when(() => mockController.onReaction(any()))
        .thenAnswer((invocation) => ReactionDisposerMock());
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
      'should populate load state',
      (tester) async {
        // arrange
        when(() => mockController.state).thenReturn(
          const EscapeManualState.loaded(
            screen: EscapeManualEntity(
              assistant: EscapeManualAssistantEntity(
                explanation: 'explanation',
                action: EscapeManualAssistantActionEntity(
                  text: 'button',
                  quizSession: QuizSessionEntity(
                    currentMessage: null,
                    sessionId: 'session id',
                    isFinished: false,
                    endScreen: null,
                  ),
                ),
              ),
            ),
          ),
        );

        // act
        await tester.pumpWidget(buildTestableWidget(const EscapeManualPage()));

        // assert
        expect(find.text('explanation'), findsOneWidget);
        expect(find.widgetWithText(OutlinedButton, 'button'), findsOneWidget);
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
            screen: EscapeManualEntity(
              assistant: EscapeManualAssistantEntity(
                explanation: 'explanation',
                action: assistantAction,
              ),
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
      'should show error message when state is error',
      (tester) async {
        // arrange
        when(() => mockController.state)
            .thenReturn(const EscapeManualState.error('error message'));

        // act
        await tester.pumpWidget(buildTestableWidget(const EscapeManualPage()));

        // assert
        expect(find.text('error message'), findsOneWidget);
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
      'should show call snackbar message when reaction is showSnackbar',
      (tester) async {
        // arrange
        await tester.pumpWidget(buildTestableWidget(const EscapeManualPage()));

        final capturedOnReaction =
            verify(() => mockController.onReaction(captureAny())).captured.last;

        // act
        capturedOnReaction
            .call(const EscapeManualReaction.showSnackbar('message'));

        await tester.pump();

        // assert
        expect(find.text('message'), findsOneWidget);
      },
    );
  });
}

class EscapeManualControllerMock extends Mock
    implements EscapeManualController {}

class ReactionDisposerMock extends Mock implements mobx.ReactionDisposer {}
