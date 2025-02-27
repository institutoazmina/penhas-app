import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/remoteconfig/i_remote_config.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/quiz/domain/entities/answer.dart';
import 'package:penhas/app/features/quiz/domain/entities/quiz.dart';
import 'package:penhas/app/features/quiz/domain/entities/quiz_message.dart';
import 'package:penhas/app/features/quiz/domain/quiz_remote_config.dart';
import 'package:penhas/app/features/quiz/domain/send_answer.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_controller.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_page.dart';
import 'package:penhas/app/shared/navigation/app_navigator.dart';
import 'package:penhas/app/shared/navigation/app_route.dart';

import '../../../../../utils/golden_tests.dart';
import '../../../../../utils/mocktail_extension.dart';
import '../../../../../utils/widget_tester_ext.dart';
import '../quiz_test_helper.dart';

void main() {
  group(QuizPage, () {
    late AppNavigator mockAppNavigator;
    late SendAnswerUseCase mockSendAnswer;
    late IRemoteConfigService mockRemoteConfig;
    late QuizRemoteConfig mockRemoteConfigQuiz;
    late IQuizController controller;

    setUpAll(() {
      registerFallbackValue(_FakeUserAnswer());
      registerFallbackValue(_FakeAppRoute());
      registerFallbackValue(Duration(seconds: 5));
    });

    setUp(() {
      mockAppNavigator = _MockAppNavigator();
      mockSendAnswer = _MockSendAnswerUseCase();
      mockRemoteConfig = _MockRemoteConfigService();
      mockRemoteConfigQuiz = _MockQuizRemoteConfig();
      controller = IQuizController.legacy(
          navigator: mockAppNavigator,
          quiz: QuizSessionEntity(sessionId: 'session_id', currentMessage: [
            QuizMessageEntity(
              type: QuizMessageType.button,
              ref: 'REF',
              content: 'please click the button',
              buttonLabel: 'OK',
            )
          ]),
          remoteConfig: mockRemoteConfigQuiz,
          sendAnswer: mockSendAnswer);
      Modular.navigatorDelegate = _MockModularNavigate();

      when(() => mockSendAnswer(any(), any())).thenSuccess(
        (_) => Quiz(
          id: 'session-id',
          messages: [QuizMessage.text(content: 'Thanks for your answer')],
        ),
      );

      when(
        () => mockRemoteConfig.getInt(
          RemoteConfigKeys.configQuizAnimationDuration,
        ),
      ).thenReturn(100);
    });

    screenshotTest(
      'empty state should looks as expected',
      fileName: 'quiz_empty_state',
      setUp: () {
        mockQuizArgs();
        controller = IQuizController.legacy(
            navigator: mockAppNavigator,
            quiz:
                QuizSessionEntity(sessionId: 'session_id', currentMessage: []),
            remoteConfig: mockRemoteConfigQuiz,
            sendAnswer: mockSendAnswer);
      },
      pageBuilder: () => QuizPage(
        controller: controller,
      ),
    );

    screenshotTest(
      'error state should looks as expected',
      fileName: 'quiz_error_state',
      setUp: () {
        mockQuizArgs([QuizOkButton()]);
      },
      pageBuilder: () => QuizPage(controller: controller),
      pumpBeforeTest: (tester) async {
        when(
          () => mockSendAnswer(any(), any()),
        ).thenFailure((_) => ServerFailure());

        await tester.tapAll(find.text('OK'));
        await tester.pumpAndSettle();
      },
    );

    screenshotTest(
      'error state when retry button is pressed should looks as expected',
      fileName: 'quiz_error_state_retry',
      setUp: () {
        mockQuizArgs([QuizOkButton()]);
      },
      pageBuilder: () => QuizPage(controller: controller),
      pumpBeforeTest: (tester) async {
        when(
          () => mockSendAnswer(any(), any()),
        ).thenFailure((_) => ServerFailure());

        await tester.tapAll(find.text('OK'));
        await tester.pumpAndSettle();

        when(() => mockSendAnswer(any(), any())).thenSuccess(
          (_) => Quiz(
            id: 'session-id',
            messages: [QuizMessage.text(content: 'Thanks for retry')],
          ),
        );

        await tester.tapAll(find.textContaining('tentar novamente'));
        await tester.pumpAndSettle(Duration(seconds: 5));
      },
    );

    testWidgets(
      'should navigate to end screen when quiz is finished',
      (tester) async {
        // arrange
        mockQuizArgs([QuizOkButton()]);
        when(() => mockSendAnswer(any(), any())).thenSuccess(
          (_) => Quiz(id: 'session-id', messages: [], redirectTo: '/end'),
        );
        when(
          () => mockAppNavigator.pushAndRemoveUntil(
            any(),
            removeUntil: any(named: 'removeUntil'),
          ),
        ).thenAnswer((_) => Future.value());

        await tester
            .pumpWidget(buildTestableWidget(QuizPage(controller: controller)));

        // act
        await tester.tapAll(find.text('OK'));
        await tester.pumpAndSettle(Duration(seconds: 5));

        // assert
        verify(() => mockSendAnswer(any(), any())).called(1);

        verifyNoMoreInteractions(mockSendAnswer);
      },
    );

    quizMessageTestGroup(
        'given message of type yesno',
        QuizMessageEntity(
          ref: 'REF',
          type: QuizMessageType.yesno,
          content: 'yes or no?',
        ), (scope) {
      scope.screenshotReceived('should display received yesno message');

      scope.screenshotReplyed(
        'should display replyed yesno message',
        (tester) async {
          await tester.tapAll(find.text('SIM'));
        },
      );
    });

    quizMessageTestGroup(
        'given message of type displayText',
        QuizMessageEntity(
          type: QuizMessageType.displayText,
          content: 'Just a text',
        ), (scope) {
      scope.screenshotReceived(
        'should display received displayText message',
      );
    });

    quizMessageTestGroup(
        'given message of type displayTextResponse',
        QuizMessageEntity(
          type: QuizMessageType.displayTextResponse,
          content: 'Just a text response',
        ), (scope) {
      scope.screenshotReceived(
        'should display received displayTextResponse message',
      );
    },
    skip: true);

    quizMessageTestGroup(
        'given message of type showHelpTutorial',
        QuizMessageEntity(
          type: QuizMessageType.showHelpTutorial,
          ref: 'REF',
          content: 'show help tutorial',
          buttonLabel: 'Show Tutorial',
        ), (scope) {
      setUp(() {
        when(() => mockAppNavigator.navigateTo(any()))
            .thenAnswer((_) async => true);
      });

      scope.screenshotReceived(
        'should display received showHelpTutorial message',
      );

      testWidgets(
        'should navigate to /quiz/tutorial/help-center when Show Tutorial button is pressed',
        (tester) async {
          // arrange

          await tester.pumpWidget(
              buildTestableWidget(QuizPage(controller: controller)));

          // act
          await tester.tap(find.text('SHOW TUTORIAL'));
          await tester.pumpAndSettle();

          // assert
          verify(
            () => mockAppNavigator.navigateTo(
              AppRoute('/quiz/tutorial/help-center'),
            ),
          ).called(1);
        },
        skip: true,
      );

      scope.screenshotReplyed(
        'should display replyed showHelpTutorial message',
        (tester) async {
          await tester.tapAll(find.text('SHOW TUTORIAL'));
          await tester.pumpAndSettle();
        },
      );
    });

    quizMessageTestGroup(
      'given message of type showStealthTutorial',
      QuizMessageEntity(
        type: QuizMessageType.showStealthTutorial,
        ref: 'REF',
        content: 'show stealth tutorial',
        buttonLabel: 'Show Tutorial',
      ),
      (scope) {
        // setUp(() {
        //   when(() => mockAppNavigator.navigateTo(any()))
        //       .thenAnswer((_) async => true);
        // });

        scope.screenshotReceived(
          'should display received showStealthTutorial message',
        );

        testWidgets(
          'should navigate to /quiz/tutorial/stealth when Show Tutorial button is pressed',
          (tester) async {
            // arrange
   

            controller = IQuizController.legacy(
          navigator: mockAppNavigator,
          quiz: QuizSessionEntity(sessionId: 'session_id', currentMessage: [
            QuizMessageEntity(
              type: QuizMessageType.button,
              ref: 'REF',
              content: 'SHOW TUTORIAL',
              buttonLabel: 'SHOW TUTORIAL',
            )
          ]),
          remoteConfig: mockRemoteConfigQuiz,
          sendAnswer: mockSendAnswer);
            await tester.pumpWidget(
                buildTestableWidget(QuizPage(controller: controller)));

            // act
            await tester.tap(find.text('SHOW TUTORIAL'));
            await tester.pumpAndSettle(Duration(seconds: 5));

            // assert
            verify(
              () => mockAppNavigator.navigateTo(
                AppRoute('/quiz/tutorial/stealth'),
              ),
            ).called(1);
          },
          skip: true,
        );

        scope.screenshotReplyed(
          'should display replyed showStealthTutorial message',
          (tester) async {
            await tester.tapAll(find.text('SHOW TUTORIAL'));
          },
        );
      },
    );

    quizMessageTestGroup(
        'given message of type button',
        QuizMessageEntity(
          type: QuizMessageType.button,
          ref: 'REF',
          content: 'please click the button',
          buttonLabel: 'Click Me',
        ), (scope) {
      scope.screenshotReceived('should display received button message');

      scope.screenshotReplyed(
        'should display replyed button message',
        (tester) async {
          await tester.tapAll(find.text('CLICK ME'));
        },
      );
    },);

    quizMessageTestGroup(
      'given message of type horizontalButtons',
      QuizMessageEntity(
        type: QuizMessageType.horizontalButtons,
        ref: 'REF',
        content: 'click one of the options',
        options: createOptions(['1', '3', '2']),
      ),
      (scope) {
        scope.screenshotReceived(
          'should display received horizontalButtons message',
        );

        scope.screenshotReplyed(
          'should display replyed horizontalButtons message',
          (tester) async {
            await tester.tapAll(find.text('OPTION 3'));
          },
        );
      },
    );

    quizMessageTestGroup(
      'given message of type singleChoice',
      QuizMessageEntity(
        type: QuizMessageType.singleChoice,
        ref: 'REF',
        content: 'witch one?',
        options: createOptions(['1', '3', '2', '4']),
      ),
      (scope) {
        scope.screenshotReceived(
          'should display received singleChoice message',
        );

        scope.screenshotReplyed(
          'should display replyed singleChoice message',
          (tester) async {
            final texts = ['Option 1', 'Option 2', 'Option 1'];
            for (final text in texts) {
              await tester.tapAll(find.text(text));
              await tester.pumpAndSettle();
            }
            await tester.tapAll(find.text('ENVIAR'));
          },
        );
      },
    );

    quizMessageTestGroup(
      'given message of type multipleChoices',
      QuizMessageEntity(
        type: QuizMessageType.multipleChoices,
        ref: 'REF',
        content: 'you can select multiple options',
        options: createOptions(['1', '3', '4', '2', '5']),
      ),
      (scope) {
        scope.screenshotReceived(
          'should display received multipleChoices message',
        );

        scope.screenshotReplyed(
          'should display replyed multipleChoices message',
          (tester) async {
            final texts = ['Option 1', 'Option 2', 'Option 1', 'Option 3'];
            for (final text in texts) {
              await tester.tapAll(find.text(text));
              await tester.pumpAndSettle();
            }
            await tester.tapAll(find.text('ENVIAR'));
          },
        );
      },
    );

    screenshotTest(
      'when received many messages should display float button',
      fileName: 'quiz_received_many_messages',
      devices: testDevices.sublist(0, 1),
      setUp: () {
        mockQuizArgs([QuizOkButton()]);

        when(
          () => mockSendAnswer(any(), any()),
        ).thenSuccess(
          (_) => Quiz(
            id: 'session-id',
            messages: createTextMessages(count: 14),
          ),
        );
      },
      pageBuilder: () => QuizPage(controller: controller),
      pumpBeforeTest: (tester) async {
        await tester.tapAll(find.text('OK'));
        await tester.pumpAndSettle(Duration(seconds: 5));
      },
    );

    screenshotTest(
      'given many messages when tap on float button should scroll to the end',
      fileName: 'quiz_scroll_to_end',
      devices: testDevices.sublist(0, 1),
      setUp: () {
        mockQuizArgs([QuizOkButton()]);

        when(
          () => mockSendAnswer(any(), any()),
        ).thenSuccess(
          (_) => Quiz(
            id: 'session-id',
            messages: createTextMessages(count: 13),
          ),
        );
      },
      pageBuilder: () => QuizPage(controller: controller),
      pumpBeforeTest: (tester) async {
        await tester.tapAll(find.text('OK'));
        await tester.pumpAndSettle(Duration(seconds: 5));

        await tester.tapAll(
          find.bySemanticsLabel('Ir para o final da conversa'),
        );
        await tester.pumpAndSettle();
      },
    );
  });
}

class _MockModularNavigate extends Mock implements IModularNavigator {}

class _MockAppNavigator extends Mock implements AppNavigator {}

class _MockSendAnswerUseCase extends Mock implements SendAnswerUseCase {}

class _MockQuizRemoteConfig extends Mock implements QuizRemoteConfig {
  Duration get animationDuration => Duration(seconds: 5);
}

class _MockRemoteConfigService extends Mock implements IRemoteConfigService {}

class _FakeUserAnswer extends Fake implements UserAnswer {}

class _FakeAppRoute extends Fake implements AppRoute {}
