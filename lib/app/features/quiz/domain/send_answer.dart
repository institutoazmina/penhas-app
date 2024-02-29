import 'package:dartz/dartz.dart';

import '../../../core/types/result.dart';
import '../../appstate/domain/usecases/app_state_usecase.dart';
import 'entities/answer.dart';
import 'entities/quiz.dart';
import 'entities/quiz_message.dart';
import 'repositories/i_quiz_repository.dart';

typedef InteractiveMessage = QuizMessage Function(String id);

class SendAnswerUseCase {
  SendAnswerUseCase({
    required AppStateUseCase appStateUseCase,
    required IQuizRepository repository,
  })  : _appStateUseCase = appStateUseCase,
        _repository = repository;

  final AppStateUseCase _appStateUseCase;
  final IQuizRepository _repository;

  Future<Result<Quiz>> call(String quizId, UserAnswer answer) async {
    final response = await _repository.send(quizId: quizId, answer: answer);

    final quiz = response.fold((l) => null, id);
    if (quiz?.isFinished == true) {
      final appState = await _appStateUseCase.check();
      return appState.fold(left, (_) => right(quiz!));
    }

    return response;
  }
}
