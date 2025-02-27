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

class MockIQuizController extends Mock implements IQuizController {
  @override
  Future<void> onReplyMessage(UserAnswer answer) async {
    return Future.value(); 
  }

   @override
  List<QuizMessage> get messages => [QuizMessage.button(reference: 'SIM', label: 'SIM', value: 'SIM'), QuizMessage.button(reference: 'NAO', label: 'NAO', value: 'NAO'), QuizMessage.text(content: 'text')];
}

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

class QuizMessageTestScope {
  QuizMessageTestScope(this.message);

  final QuizMessageEntity message;

  final controller = MockIQuizController();

  @isTest
  FutureOr<void> screenshotReceived(
    String description, {
    bool skip = false,
  }) {
    screenshotTest(description,
        fileName: 'quiz_${message.type.name}_received',
        pageBuilder: () => QuizPage(
              controller: controller,
            ),
        skip: skip,
        setUp: () {

          when(() => controller.animationDuration)
              .thenReturn(Duration(seconds: 5));

          if (message.type == QuizMessageType.displayText) {
            when(() => controller.messages).thenReturn([
              QuizMessage.text(
                content: 'test',
                reference: '',
              ),
            ]);
          }

          if (message.type == QuizMessageType.button) {
            when(() => controller.messages).thenReturn([
              QuizMessage.text(
                content: 'test',
                reference: '',
              ),
              QuizMessage.button(
                  reference: 'reference', label: 'label', value: 'value')
            ]);
          }

          if (message.type == QuizMessageType.displayTextResponse) {
            when(() => controller.messages).thenReturn([
              QuizMessage.sent(
                content: 'test',
                reference: '',
                status: AnswerStatus.sent,
              ),
            ]);
          }

          if (message.type == QuizMessageType.showStealthTutorial) {
            when(() => controller.messages).thenReturn([
              QuizMessage.text(content: 'test', reference: ''),
              QuizMessage.button(
                reference: message.ref,
                label: message.buttonLabel!,
                value: '1',
                action: const ButtonAction.navigate(
                  route: '/quiz/tutorial/stealth',
                  readableResult: 'Tutorial visto',
                ),
              ),
            ]);
          }

          if (message.type == QuizMessageType.singleChoice) {
            when(() => controller.messages).thenReturn([
              QuizMessage.text(content: 'test', reference: ''),
              QuizMessage.singleChoice(
                reference: message.ref,
                options: message.options!
                    .map(
                      (option) => MessageOption(
                        label: option.display,
                        value: option.index,
                      ),
                    )
                    .toList(),
              ),
            ]);
          }

          if (message.type == QuizMessageType.yesno) {
            when(() => controller.messages).thenReturn([
              QuizMessage.text(content: 'test', reference: ''),
              QuizMessage.horizontalButtons(
                reference: message.ref,
                buttons: const [
                  ButtonOption(label: 'Sim', value: 'Y'),
                  ButtonOption(label: 'Não', value: 'N'),
                ],
              ),
            ]);
          }

          if (message.type == QuizMessageType.multipleChoices) {
            when(() => controller.messages).thenReturn([
              QuizMessage.text(
                content: 'test',
                reference: '',
              ),
              QuizMessage.multipleChoices(
                reference: message.ref,
                options: message.options!
                    .map(
                      (option) => MessageOption(
                        label: option.display,
                        value: option.index,
                      ),
                    )
                    .toList(),
              ),
            ]);
          }

          if (message.type == QuizMessageType.horizontalButtons) {
            when(() => controller.messages).thenReturn([
              QuizMessage.text(
                content: 'test',
                reference: '',
              ),
              QuizMessage.horizontalButtons(
                reference: message.ref,
                buttons: message.options!
                    .map(
                      (option) => ButtonOption(
                        label: option.display,
                        value: option.index,
                      ),
                    )
                    .toList(),
              ),
            ]);
          }
        });
  }

  @isTest
  FutureOr<void> screenshotReplyed(
    String description,
    PumpAction action, {
    bool skip = false,
  }) {
    screenshotTest(description,
        fileName: 'quiz_${message.type.name}_replyed',
        pageBuilder: () => QuizPage(
              controller: controller,
            ),
        pumpBeforeTest: action,
        skip: skip,
        setUp: () {
           when(() => controller.animationDuration)
              .thenReturn(Duration(seconds: 5));
            when(controller.waitAnimationCompletion).thenAnswer((_) async {});



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
