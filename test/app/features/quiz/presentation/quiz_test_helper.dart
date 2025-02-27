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
  if(type == QuizMessageType.yesno){
    return controllerYesNo;
  }
  if(type == QuizMessageType.displayTextResponse){
    return controllerTextResponse;
  }
  if (type == QuizMessageType.horizontalButtons) {
    return controllerWithHorizontalButtons;
  }
  if (type == QuizMessageType.multipleChoices) {
    return controllerWithMultipleChoices;
  }
  if (type == QuizMessageType.singleChoice) {
    return controllerSingleChoice;
  }
  if(type == QuizMessageType.button){
    return controllerButton;
  }
  if(type == QuizMessageType.showStealthTutorial){
    return controllerStealthTutorial;
  }
  if(type == QuizMessageType.showHelpTutorial){
    return controllerTutorial;
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
        });
  }
}

void mockQuizArgs([
  List<QuizMessageEntity> messages = const [],
  String sessionId = 'session_id',
]) {
  assert(Modular.navigatorDelegate is Mock,
      'Modular.navigatorDelegate should be a Mock');

  when(() => Modular.navigatorDelegate!.args).thenReturn(
    ModularArguments(
      data: QuizSessionEntity(sessionId: sessionId, currentMessage: messages),
    ),
  );
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
  Future<void> onReplyMessage(UserAnswer answer) async {
    return Future.value();
  }

  @override
  List<QuizMessage> get messages => [
      ];
}

class MockIQuizControllerWithMessages extends Mock implements IQuizController {
  @override
  Future<void> onReplyMessage(UserAnswer answer) async {
    return Future.value();
  }

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
  Future<void> onReplyMessage(UserAnswer answer) async {
    return Future.value();
  }

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
  Future<void> onReplyMessage(UserAnswer answer) async {
    return Future.value();
  }

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
  Future<void> onReplyMessage(UserAnswer answer) async {
    return Future.value();
  }

  @override
  List<QuizMessage> get messages => [
        QuizMessage.text(content: 'text'),
        QuizMessage.button(reference: 'CLICK ME', label: 'CLICK ME', value: 'CLICK ME')
      ];
}

class MockIQuizControllerStealthTutorial extends Mock implements IQuizController {
  @override
  Future<void> onReplyMessage(UserAnswer answer) async {
    return Future.value();
  }

  @override
  List<QuizMessage> get messages => [
        QuizMessage.text(content: 'text'),

        QuizMessage.button(reference: 'SHOW TUTORIAL', label: 'SHOW TUTORIAL', value: 'SHOW TUTORIAL')
      ];
}
class MockIQuizControllerTutorial extends Mock implements IQuizController {
  @override
  Future<void> onReplyMessage(UserAnswer answer) async {
    return Future.value();
  }

  @override
  List<QuizMessage> get messages => [
        QuizMessage.text(content: 'text'),

        QuizMessage.button(reference: 'SHOW TUTORIAL', label: 'SHOW TUTORIAL', value: 'SHOW TUTORIAL')
      ];
}

class MockIQuizControllerTextResponse extends Mock implements IQuizController {
  @override
  Future<void> onReplyMessage(UserAnswer answer) async {
    return Future.value();
  }

  @override
  List<QuizMessage> get messages => [
        QuizMessage.sent(content: 'Just a text response') ,
      ];
}

class MockIQuizControllerYesNo extends Mock implements IQuizController {
  @override
  Future<void> onReplyMessage(UserAnswer answer) async {
    return Future.value();
  }

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