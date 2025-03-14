import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/quiz/domain/entities/answer.dart';
import 'package:penhas/app/features/quiz/domain/entities/quiz_message.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_controller.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_page.dart';

import '../../../../utils/golden_tests.dart';

typedef ScopedBody = void Function(QuizMessageTestScope scope);

@isTestGroup
void quizMessageTestGroup(
  Object description,
  QuizMessageEntity message,
  ScopedBody body, {
  bool skip = false,
}) {
  group(
    description,
    () {
      setUp(() {
        mockQuizArgs([message]);
      });

      body(QuizMessageTestScope(message));
    },
    skip: skip,
  );
}

IQuizController returnCorrectController(QuizMessageType type) {
  final controller = MockIQuizController();
  final controllerWithMultipleChoices = MockIQuizControllerWithMessages();
  final controllerWithHorizontalButtons =
      MockIQuizControllerWithHorizontalButtons();
  final controllerSingleChoice = MockIQuizControllerSingleChoice();
  final controllerButton = MockIQuizControllerButton();
  final controllerStealthTutorial = MockIQuizControllerStealthTutorial();
  final controllerTutorial = MockIQuizControllerTutorial();
  final controllerTextResponse = MockIQuizControllerTextResponse();
  final controllerYesNo = MockIQuizControllerYesNo();
  final controllerDisplayText = MockIQuizControllerDisplayText();
  switch (type) {
    case QuizMessageType.displayText:
      return controllerDisplayText;

    case QuizMessageType.button:
      return controllerButton;

    case QuizMessageType.horizontalButtons:
      return controllerWithHorizontalButtons;

    case QuizMessageType.yesno:
      return controllerYesNo;

    case QuizMessageType.showStealthTutorial:
      return controllerStealthTutorial;

    case QuizMessageType.showHelpTutorial:
      return controllerTutorial;

    case QuizMessageType.forceReload:
      break;
    case QuizMessageType.multipleChoices:
      return controllerWithMultipleChoices;

    case QuizMessageType.singleChoice:
      return controllerSingleChoice;

    case QuizMessageType.displayTextResponse:
      return controllerTextResponse;
  }
  return controller;
}

class QuizMessageTestScope {
  QuizMessageTestScope(this.message);

  final QuizMessageEntity message;

  @isTest
  FutureOr<void> screenshotReceived(
    String description, {
    bool skip = false,
  }) {
    final rightController = returnCorrectController(message.type);

    screenshotTest(description,
        fileName: 'quiz_${message.type.name}_received',
        pageBuilder: () => QuizPage(
              controller: rightController,
            ),
        skip: skip,
        setUp: () {
          when(() => rightController.animationDuration)
              .thenReturn(Duration(seconds: 5));
        });
  }

  @isTest
  FutureOr<void> screenshotReplyed(
    String description,
    PumpAction action, {
    bool skip = false,
  }) {
    final rightController = returnCorrectController(message.type);

    screenshotTest(description,
        fileName: 'quiz_${message.type.name}_replyed',
        pageBuilder: () => QuizPage(
              controller: rightController,
            ),
        pumpBeforeTest: action,
        skip: skip,
        setUp: () {
          when(() => rightController.animationDuration)
              .thenReturn(Duration(seconds: 5));
          when(rightController.waitAnimationCompletion)
              .thenAnswer((_) async {});
          when(() => rightController.onReplyMessage(any()))
              .thenAnswer((_) async => Future.value());
        });
  }
}

void mockQuizArgs([
  List<QuizMessageEntity> messages = const [],
  String sessionId = 'session_id',
]) {
  assert(Modular.navigatorDelegate is Mock,
      'Modular.navigatorDelegate should be a Mock');

  Modular.navigatorDelegate = MockIModularNavigator();

  // when(() => Modular.navigatorDelegate!.args).thenReturn(
  //   ModularArguments(
  //     data: QuizSessionEntity(sessionId: sessionId, currentMessage: messages),
  //   ),
  // );
}

List<QuizMessageChoiceOption> createOptions(List<String> indexes) {
  return indexes
      .map(
        (index) => QuizMessageChoiceOption(
          display: 'Option $index',
          index: index,
        ),
      )
      .toList();
}

List<QuizMessage> createTextMessages({int count = 1}) {
  return List.generate(
    count,
    (index) => QuizMessage.text(content: 'message $index'),
  );
}

class QuizOkButton extends QuizMessageEntity {
  QuizOkButton()
      : super(
          type: QuizMessageType.button,
          ref: 'REF',
          content: 'please click the button',
          buttonLabel: 'OK',
        );
}

//Mocks
class MockIQuizController extends Mock implements IQuizController {
  @override
  List<QuizMessage> get messages => [];
}

class MockIQuizControllerWithMessages extends Mock implements IQuizController {
  @override
  List<QuizMessage> get messages => [
        QuizMessage.multipleChoices(reference: 'reference', options: [
          MessageOption(label: 'Option 1', value: 'Option 1'),
          MessageOption(label: 'Option 2', value: 'Option 2'),
          MessageOption(label: 'Option 1', value: 'Option 1'),
          MessageOption(label: 'Option 3', value: 'Option 3'),
        ])
      ];
}

class MockIQuizControllerSingleChoice extends Mock implements IQuizController {
  @override
  List<QuizMessage> get messages => [
        QuizMessage.singleChoice(reference: 'reference', options: [
          MessageOption(label: 'Option 1', value: 'Option 1'),
          MessageOption(label: 'Option 2', value: 'Option 2'),
          MessageOption(label: 'Option 1', value: 'Option 1')
        ])
      ];
}

class MockIQuizControllerWithHorizontalButtons extends Mock
    implements IQuizController {
  @override
  List<QuizMessage> get messages => [
        QuizMessage.horizontalButtons(reference: 'reference', buttons: [
          ButtonOption(label: '1', value: '1'),
          ButtonOption(label: 'OPTION 3', value: 'OPTION 3'),
          ButtonOption(label: '2', value: '2')
        ])
      ];
}

class MockIQuizControllerButton extends Mock implements IQuizController {
  @override
  List<QuizMessage> get messages => [
        QuizMessage.text(content: 'text'),
        QuizMessage.button(
          reference: 'REF',
          label: 'CLICK ME',
          value: '1',
        ),
      ];
}

class MockIQuizControllerStealthTutorial extends Mock
    implements IQuizController {
  @override
  List<QuizMessage> get messages => [
        QuizMessage.text(content: 'text'),
        QuizMessage.button(
            reference: 'SHOW TUTORIAL',
            label: 'SHOW TUTORIAL',
            value: 'SHOW TUTORIAL')
      ];
}

class MockIQuizControllerTutorial extends Mock implements IQuizController {
  @override
  List<QuizMessage> get messages => [
        QuizMessage.button(
          reference: 'REF',
          label: 'SHOW TUTORIAL',
          value: '1',
          action: const ButtonAction.navigate(
            route: '/quiz/tutorial/help-center',
            readableResult: 'SHOW TUTORIAL',
          ),
        ),
      ];
}

class MockIQuizControllerTextResponse extends Mock implements IQuizController {
  @override
  List<QuizMessage> get messages => [
        QuizMessage.sent(
          reference: 'REF',
          content: 'Just a text response',
          status: AnswerStatus.sent,
        ),
      ];
}

class MockIQuizControllerDisplayText extends Mock implements IQuizController {
  @override
  List<QuizMessage> get messages => [
        QuizMessage.text(content: 'Just a text'),
      ];
}

class MockIQuizControllerYesNo extends Mock implements IQuizController {
  @override
  List<QuizMessage> get messages => [
        QuizMessage.text(content: 'text'),
        QuizMessage.horizontalButtons(
          reference: 'REF',
          buttons: const [
            ButtonOption(label: 'SIM', value: 'Y'),
            ButtonOption(label: 'NÃO', value: 'N'),
          ],
        ),
      ];
}

class MockIModularNavigator extends Mock implements IModularNavigator {}
