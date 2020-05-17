import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';

part 'quiz_controller.g.dart';

class QuizController extends _QuizControllerBase with _$QuizController {
  QuizController({
    @required QuizSessionEntity quizSession,
  }) : super(quizSession);
}

abstract class _QuizControllerBase with Store {
  final QuizSessionEntity _quizSession;

  _QuizControllerBase(this._quizSession) {
    final reversedMessages = _quizSession.currentMessage.reversed.toList();
    messages.addAll(reversedMessages.asObservable());
    _parseUserReply(reversedMessages);
  }

  ObservableList<QuizMessageEntity> messages =
      ObservableList<QuizMessageEntity>();

  @observable
  QuizMessageEntity userReplyMessage;

  @action
  void onActionReply(Map<String, String> reply) {
    if (messages.isEmpty) {
      return;
    }

    final messageRemoved = messages.removeAt(0);
    if (messageRemoved.type == QuizMessageType.yesno) {
      String newMessageContent;

      if (reply[messageRemoved.ref] == '1') {
        newMessageContent = "Sim";
      } else {
        newMessageContent = "Não";
      }

      QuizMessageEntity newMessage = QuizMessageEntity(
        content: newMessageContent,
        type: QuizMessageType.displayTextResponse,
      );

      messages.insertAll(0, [
        newMessage,
        QuizMessageEntity(
          content: messageRemoved.content,
          type: QuizMessageType.displayText,
        ),
      ]);

      userReplyMessage = newMessage;
    }
  }

  void _parseUserReply(List<QuizMessageEntity> messages) {
    userReplyMessage = messages.firstWhere(
      (e) => e.type != QuizMessageType.displayText,
    );
  }
}
