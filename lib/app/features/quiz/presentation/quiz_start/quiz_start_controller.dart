import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/extension/mobx.dart';
import '../../../appstate/domain/entities/app_state_entity.dart';
import '../../../authentication/presentation/shared/map_failure_message.dart';
import '../../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../domain/start_quiz.dart';
import 'quiz_start_state.dart';

part 'quiz_start_controller.g.dart';

typedef QuizSessionResult = Either<Failure, QuizSessionEntity>;

class QuizStartController = QuizStartControllerBase with _$QuizStartController;

abstract class QuizStartControllerBase with Store, MapFailureMessage {
  QuizStartControllerBase({
    required String? sessionId,
    required StartQuizUseCase startQuiz,
  })  : _sessionId = sessionId,
        _startQuiz = startQuiz;

  final String? _sessionId;
  final StartQuizUseCase _startQuiz;

  @observable
  QuizStartState state = const QuizStartState.initial();

  @computed
  PageProgressState get progressState => _pageProgress.state;

  @observable
  ObservableFuture<QuizSessionResult>? _pageProgress;

  void load() async {
    if (progressState == PageProgressState.loading) return;

    _pageProgress = ObservableFuture(_startQuiz(_sessionId));
    final result = await _pageProgress!;

    result.fold(_handleFailure, _handleSuccess);
  }

  void _handleFailure(Failure failure) {
    final message = mapFailureMessage(failure);
    state = QuizStartState.error(message);
  }

  void _handleSuccess(QuizSessionEntity session) {
    Modular.to.pushReplacementNamed(
      '/quiz?origin=start-quiz',
      arguments: session,
    );
  }
}
