import '../../appstate/domain/entities/app_state_entity.dart';
import 'entities/answer.dart';
import 'entities/quiz.dart';
import 'entities/quiz_message.dart';
import 'entities/quiz_request_entity.dart';

class QuizMapper {
  static QuizRequestEntity toRequest(Quiz quiz, UserAnswer answer) {
    return QuizRequestEntity(
      sessionId: quiz.id,
      options: const {},
    );
  }

  static Quiz fromLegacy(QuizSessionEntity quizSession) {
    return Quiz(
      id: quizSession.sessionId,
      redirectTo: quizSession.isFinished ? quizSession.endScreen ?? '/' : null,
      messages: quizSession.currentMessage
          .expand(
            QuizMessageMapper.fromLegacy,
          )
          .toList(),
    );
  }
}

class QuizMessageMapper {
  static Iterable<QuizMessage> fromLegacy(QuizMessageEntity message) sync* {
    if (message.type == QuizMessageType.displayTextResponse) {
      yield QuizMessage.sent(
        reference: message.ref,
        content: message.content!,
        status: AnswerStatus.sent,
      );
      return;
    }
    if (message.content != null) {
      yield QuizMessage.text(
        reference: message.ref,
        content: message.content!,
      );
    }
    switch (message.type) {
      case QuizMessageType.button:
        yield QuizMessage.button(
          reference: message.ref,
          label: message.buttonLabel!,
          value: '1',
        );
        break;
      case QuizMessageType.horizontalButtons:
        yield QuizMessage.horizontalButtons(
          reference: message.ref,
          buttons: message.options!
              .map(
                (option) => ButtonOption(
                  label: option.display,
                  value: option.index,
                ),
              )
              .toList(),
        );
        break;
      case QuizMessageType.yesno:
        yield QuizMessage.horizontalButtons(
          reference: message.ref,
          buttons: const [
            ButtonOption(label: 'Sim', value: 'Y'),
            ButtonOption(label: 'Não', value: 'N'),
          ],
        );
        break;
      case QuizMessageType.showStealthTutorial:
        yield QuizMessage.button(
          reference: message.ref,
          label: message.buttonLabel!,
          value: '1',
          action: const ButtonAction.navigate(
            route: '/quiz/tutorial/stealth',
            readableResult: 'Tutorial visto',
          ),
        );
        break;
      case QuizMessageType.showHelpTutorial:
        yield QuizMessage.button(
          reference: message.ref,
          label: message.buttonLabel!,
          value: '1',
          action: const ButtonAction.navigate(
            route: '/quiz/tutorial/help-center',
            readableResult: 'Tutorial visto',
          ),
        );
        break;
      case QuizMessageType.multipleChoices:
        yield QuizMessage.multipleChoices(
          reference: message.ref,
          options: message.options!
              .map(
                (option) => MessageOption(
                  label: option.display,
                  value: option.index,
                ),
              )
              .toList(),
        );
        break;
      case QuizMessageType.singleChoice:
        yield QuizMessage.singleChoice(
          reference: message.ref,
          options: message.options!
              .map(
                (option) => MessageOption(
                  label: option.display,
                  value: option.index,
                ),
              )
              .toList(),
        );
        break;
      case QuizMessageType.displayText:
      case QuizMessageType.displayTextResponse:
      case QuizMessageType.forceReload:
        // do nothing
        break;
    }
  }
}
