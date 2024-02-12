import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/error/failures.dart';
import '../../../../shared/navigation/app_navigator.dart';
import '../../../../shared/navigation/app_route.dart';
import '../../../appstate/domain/entities/app_state_entity.dart';
import '../../../appstate/domain/usecases/app_state_usecase.dart';
import '../../domain/entities/quiz_request_entity.dart';
import '../../domain/repositories/i_quiz_repository.dart';

part 'quiz_controller.g.dart';

const String errorServerFailure =
    'O servidor está com problema neste momento, tente novamente.';
const String errorInternetConnectionFailure =
    'O servidor está inacessível, o PenhaS está com acesso à Internet?';

class QuizController extends _QuizControllerBase with _$QuizController {
  QuizController({
    required QuizSessionEntity quizSession,
    required AppStateUseCase appStateUseCase,
    required IQuizRepository repository,
    required AppNavigator navigator,
  }) : super(quizSession, appStateUseCase, repository, navigator);
}

abstract class _QuizControllerBase with Store {
  _QuizControllerBase(
    this._quizSession,
    this._appStateUseCase,
    this._repository,
    this._navigator,
  ) {
    final reversedCurrent = _quizSession.currentMessage.reversed.toList();
    _sessionId = _quizSession.sessionId;

    messages.addAll(reversedCurrent);
    _parseUserReply(reversedCurrent);
  }

  final IQuizRepository _repository;
  final AppStateUseCase _appStateUseCase;
  final AppNavigator _navigator;

  final QuizSessionEntity _quizSession;
  String? _sessionId;

  ObservableList<QuizMessageEntity> messages =
      ObservableList<QuizMessageEntity>();

  @observable
  QuizMessageEntity? userReplyMessage;

  @observable
  String? errorMessage = '';

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
        ref: messageRemoved.ref,
        content: messageRemoved.content,
        type: messageRemoved.type != QuizMessageType.displayTextResponse
            ? QuizMessageType.displayText
            : messageRemoved.type,
      ),
    ]);

    final QuizRequestEntity request = QuizRequestEntity(
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
      ref: messageRemoved.ref,
      content: 'Desculpa, não entendi',
      type: QuizMessageType.displayText,
    );

    switch (messageRemoved.type) {
      case QuizMessageType.yesno:
        return _replyYesNoUserInteraction(reply, messageRemoved);
      case QuizMessageType.showHelpTutorial:
      case QuizMessageType.showStealthTutorial:
        return _replyButtonTutorialUserInteraction(reply, messageRemoved);
      case QuizMessageType.multipleChoices:
      case QuizMessageType.singleChoice:
      case QuizMessageType.horizontalButtons:
        return _replyChoicesInteraction(reply, messageRemoved);
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
      ref: messageRemoved.ref,
      content: messageRemoved.buttonLabel,
      type: QuizMessageType.displayTextResponse,
    );
  }

  QuizMessageEntity _replyButtonTutorialUserInteraction(
    Map<String, String> reply,
    QuizMessageEntity messageRemoved,
  ) {
    return QuizMessageEntity(
      ref: messageRemoved.ref,
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
      newMessageContent = 'Sim';
    } else {
      newMessageContent = 'Não';
    }

    final QuizMessageEntity newMessage = QuizMessageEntity(
      ref: messageRemoved.ref,
      content: newMessageContent,
      type: QuizMessageType.displayTextResponse,
    );

    return newMessage;
  }

  QuizMessageEntity _replyChoicesInteraction(
    Map<String, String> reply,
    QuizMessageEntity messageRemoved,
  ) {
    final String display = reply[messageRemoved.ref]!
        .split(',')
        .map((e) => messageRemoved.options!.firstWhere((o) => o.index == e))
        .map((e) => e.display)
        .join(', ');

    return QuizMessageEntity(
      ref: messageRemoved.ref,
      content: display,
      type: QuizMessageType.displayTextResponse,
    );
  }

  void _parseUserReply(List<QuizMessageEntity> messages) {
    userReplyMessage = messages.firstWhereOrNull(
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
    final quizSession = state.quizSession;
    if (quizSession == null) return;

    if (quizSession.isFinished) {
      _updateAppStates(
        state,
        (_) => _navigator.pushAndRemoveUntil(
          AppRoute(quizSession.endScreen ?? '/'),
          removeUntil: '/',
        ),
      );
      return;
    }

    _sessionId = quizSession.sessionId;

    if (quizSession.currentMessage.isNotEmpty) {
      messages.insertAll(0, quizSession.currentMessage.reversed);
    }

    _parseUserReply(messages);
  }

  Future<void> _updateAppStates(
    AppStateEntity appStateEntity,
    void Function(AppStateEntity appState) onUpdate,
  ) async {
    final appState = await _appStateUseCase.check();
    appState.fold(
      (_) => {},
      (state) => onUpdate(state),
    );
  }

  void _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case InternetConnectionFailure:
        errorMessage = errorInternetConnectionFailure;
        break;
      case ServerFailure:
        errorMessage = errorServerFailure;
        break;
      case ServerSideFormFieldValidationFailure:
        _mapFailureToFields(failure as ServerSideFormFieldValidationFailure);
        break;
      default:
        throw UnsupportedError;
    }
  }

  void _mapFailureToFields(ServerSideFormFieldValidationFailure failure) {
    errorMessage = failure.message;
  }
}
