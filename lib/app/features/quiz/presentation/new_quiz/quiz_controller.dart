import 'dart:async';

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/extension/list.dart';
import '../../../../core/types/result.dart';
import '../../../../shared/navigation/app_navigator.dart';
import '../../../../shared/navigation/app_route.dart';
import '../../../appstate/domain/entities/app_state_entity.dart';
import '../../../authentication/presentation/shared/map_failure_message.dart';
import '../../domain/entities/answer.dart';
import '../../domain/entities/quiz.dart';
import '../../domain/entities/quiz_message.dart';
import '../../domain/quiz_mapper.dart';
import '../../domain/quiz_remote_config.dart';
import '../../domain/send_answer.dart';

part 'quiz_controller.g.dart';

class _QuizController = IQuizController with _$_QuizController;

abstract class IQuizController with Store, MapFailureMessage {
  IQuizController({
    required SendAnswerUseCase sendAnswer,
    required QuizRemoteConfig remoteConfig,
    required AppNavigator navigator,
    required Quiz quiz,
  })  : _sendAnswer = sendAnswer,
        _remoteConfig = remoteConfig,
        _navigator = navigator,
        _quizId = quiz.id,
        _messages = ObservableList.of(quiz.messages);

  factory IQuizController.legacy({
    required SendAnswerUseCase sendAnswer,
    required QuizRemoteConfig remoteConfig,
    required AppNavigator navigator,
    required QuizSessionEntity quiz,
  }) =>
      _QuizController(
        sendAnswer: sendAnswer,
        remoteConfig: remoteConfig,
        navigator: navigator,
        quiz: QuizMapper.fromLegacy(quiz),
      );

  factory IQuizController.create({
    required SendAnswerUseCase sendAnswer,
    required QuizRemoteConfig remoteConfig,
    required AppNavigator navigator,
    required Quiz quiz,
  }) = _QuizController;

  final SendAnswerUseCase _sendAnswer;
  final QuizRemoteConfig _remoteConfig;
  final AppNavigator _navigator;
  String _quizId;

  @observable
  String? errorMessage;

  List<QuizMessage> get messages =>
      _messages.takeWhile((value) => !value.isInteractive).toList();

  QuizMessage? get interactiveMessage => _messages.lastWhereOrNull(
        (message) => message.isInteractive,
      );

  final List<QuizMessage> _messages;
  UserAnswer? _answerPendingToSend;

  late Duration animationDuration = _remoteConfig.animationDuration;

  @action
  Future<void> onReplyMessage(UserAnswer reply) async {
    if (_answerPendingToSend != null) return;
    errorMessage = null;

    _answerPendingToSend = reply;
    await _sendUserAnswer(reply);
    _answerPendingToSend = null;
  }

  Future<void> waitAnimationCompletion([
    Duration? duration,
  ]) =>
      Future.delayed(duration ?? animationDuration);
}

extension _HelperMethods on IQuizController {
  Future<void> _sendUserAnswer(UserAnswer answer) async {
    answer = await _maybeHandleButtonAction(answer);
    _markAnswerAsSending(answer);

    final result = await Future.wait<dynamic>(
      [
        _sendAnswer(_quizId, answer),
        // give time to complete the animation
        waitAnimationCompletion(animationDuration * 1.5),
      ],
    ).then<Result<Quiz>>((value) => value.first);

    result.fold(
      (failure) => _onSendAnswerFailed(answer, failure),
      (success) => _onSendAnswerSuccessful(answer, success),
    );
  }

  Future<UserAnswer> _maybeHandleButtonAction(UserAnswer answer) async {
    final button = answer.message.findButtonWithValue(answer.value);

    if (button?.action == null) return answer;

    final newAnswerValue = await button!.action!.when(
      navigate: _navigationResult,
    );

    return UserAnswer(
      value: newAnswerValue,
      // remove button action
      // to avoid run the same action again in case of send failures
      message: answer.message.clearActions(),
    );
  }

  Future<AnswerValue> _navigationResult(
    String route,
    String readableResult,
  ) async {
    final result = await _navigator.navigateTo(AppRoute(route));
    return AnswerValue(
      result == true ? '1' : '0',
      readable: readableResult,
    );
  }

  Future<void> _onSendAnswerSuccessful(UserAnswer userAnswer, Quiz quiz) async {
    _quizId = quiz.id;
    _markAnswerAsSent(userAnswer);
    await waitAnimationCompletion();
    _messages.addAll(quiz.messages);
    _redirectIfFinished(quiz);
  }

  void _onSendAnswerFailed(
    UserAnswer userAnswer,
    Failure failure,
  ) {
    _markAnswerAsNotSent(userAnswer);
    errorMessage = mapFailureMessage(failure);
  }

  void _markAnswerAsSending(UserAnswer answer) {
    _messages.replaceLast(
      QuizMessage.sent(
        reference: '${messages.length - 1}',
        content: answer.value.readable,
        answer: answer,
        status: AnswerStatus.sending,
      ),
    );
  }

  void _markAnswerAsSent(UserAnswer answer) {
    _updateSentMessage(AnswerStatus.sent);
  }

  void _markAnswerAsNotSent(UserAnswer answer) {
    _updateSentMessage(AnswerStatus.failed);
  }

  void _updateSentMessage(AnswerStatus status) {
    final message = _messages.last.maybeChangeStatus(status);
    _messages.replaceLast(message);
  }

  void _redirectIfFinished(Quiz quiz) {
    final redirectTo = quiz.redirectTo;
    if (redirectTo == null) return;

    _navigator.pushAndRemoveUntil(
      AppRoute(redirectTo),
      removeUntil: '/',
    );
  }
}
