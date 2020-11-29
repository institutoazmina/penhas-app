import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/quiz/domain/entities/quiz_request_entity.dart';
import 'package:penhas/app/features/quiz/domain/repositories/i_quiz_repository.dart';

part 'quiz_controller.g.dart';

const String ERROR_SERVER_FAILURE =
    "O servidor está com problema neste momento, tente novamente.";
const String ERROR_INTERNET_CONNECTION_FAILURE =
    "O servidor está inacessível, o PenhaS está com acesso à Internet?";

class QuizController extends _QuizControllerBase with _$QuizController {
  QuizController({
    @required QuizSessionEntity quizSession,
    @required IQuizRepository repository,
  }) : super(quizSession, repository);
}

abstract class _QuizControllerBase with Store {
  final QuizSessionEntity _quizSession;
  final IQuizRepository _repository;
  String _sessionId;

  _QuizControllerBase(this._quizSession, this._repository) {
    final reversedCurrent = _quizSession.currentMessage.reversed.toList();
    _sessionId = _quizSession.sessionId;

    messages.addAll(reversedCurrent);
    _parseUserReply(reversedCurrent);
  }

  ObservableList<QuizMessageEntity> messages =
      ObservableList<QuizMessageEntity>();

  @observable
  QuizMessageEntity userReplyMessage;

  @observable
  String errorMessage = '';

  @action
  void onActionReply(Map<String, String> reply) {
    if (messages.isEmpty) {
      return;
    }

    final messageRemoved = messages.removeAt(0);
    final actionMessageResult = _mapInteractionToMessage(messageRemoved, reply);

    userReplyMessage = actionMessageResult;

    messages.insertAll(0, [
      actionMessageResult,
      QuizMessageEntity(
        content: messageRemoved.content,
        type: QuizMessageType.displayText,
      ),
    ]);

    QuizRequestEntity request = QuizRequestEntity(
      sessionId: _sessionId,
      options: reply,
    );

    _sendUserInteraction(request);
  }

  QuizMessageEntity _mapInteractionToMessage(
    QuizMessageEntity messageRemoved,
    Map<String, String> reply,
  ) {
    final message = QuizMessageEntity(
        content: 'Desculpa, não entendi', type: QuizMessageType.displayText);

    switch (messageRemoved.type) {
      case QuizMessageType.yesno:
        return _replyYesNoUserInteraction(reply, messageRemoved);
      case QuizMessageType.showHelpTutorial:
      case QuizMessageType.showStealthTutorial:
        return _replyButtonTutorialUserInteraction(reply, messageRemoved);
      case QuizMessageType.multipleChoices:
        return _replyMultiChoicesInteracton(reply, messageRemoved);
      case QuizMessageType.button:
        return _replySingleButton(reply, messageRemoved);
      default:
        return message;
    }
  }

  QuizMessageEntity _replySingleButton(
    Map<String, String> reply,
    QuizMessageEntity messageRemoved,
  ) {
    return QuizMessageEntity(
      content: messageRemoved.buttonLabel,
      type: QuizMessageType.displayText,
    );
  }

  QuizMessageEntity _replyButtonTutorialUserInteraction(
    Map<String, String> reply,
    QuizMessageEntity messageRemoved,
  ) {
    return QuizMessageEntity(
      content: 'Tutorial visto',
      type: QuizMessageType.displayTextResponse,
    );
  }

  QuizMessageEntity _replyYesNoUserInteraction(
    Map<String, String> reply,
    QuizMessageEntity messageRemoved,
  ) {
    String newMessageContent;

    if (reply[messageRemoved.ref] == 'Y') {
      newMessageContent = "Sim";
    } else {
      newMessageContent = "Não";
    }

    QuizMessageEntity newMessage = QuizMessageEntity(
      content: newMessageContent,
      type: QuizMessageType.displayTextResponse,
    );

    return newMessage;
  }

  QuizMessageEntity _replyMultiChoicesInteracton(
    Map<String, String> reply,
    QuizMessageEntity messageRemoved,
  ) {
    String display = reply[messageRemoved.ref]
        .split(',')
        .map((e) => messageRemoved.options.firstWhere((o) => o.index == e))
        .map((e) => e.display)
        .join(', ');

    return QuizMessageEntity(
      content: display,
      type: QuizMessageType.displayTextResponse,
    );
  }

  void _parseUserReply(List<QuizMessageEntity> messages) {
    userReplyMessage = messages.firstWhere(
      (e) => e.type != QuizMessageType.displayText,
    );
  }

  Future<void> _sendUserInteraction(QuizRequestEntity request) async {
    final response = await _repository.update(quiz: request);

    response.fold(
      (failure) => _mapFailureToMessage(failure),
      (state) => _parseState(state),
    );
  }

  void _parseState(AppStateEntity state) {
    if (state.quizSession?.isFinished ?? true) {
      Modular.to.popAndPushNamed('/');
      return;
    }

    _sessionId = state.quizSession.sessionId;

    if (state?.quizSession?.currentMessage != null) {
      messages.insertAll(0, state.quizSession.currentMessage.reversed);
    }

    _parseUserReply(messages);
  }

  void _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case InternetConnectionFailure:
        _setErrorMessage(ERROR_INTERNET_CONNECTION_FAILURE);
        break;
      case ServerFailure:
        _setErrorMessage(ERROR_SERVER_FAILURE);
        break;
      case ServerSideFormFieldValidationFailure:
        _mapFailureToFields(failure);
        break;
      default:
        throw UnsupportedError;
    }
  }

  void _mapFailureToFields(ServerSideFormFieldValidationFailure failure) {
    _setErrorMessage(failure.message);
  }

  void _setErrorMessage(String message) {
    errorMessage = message;
  }
}
