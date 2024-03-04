import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:penhas/app/features/quiz/domain/entities/answer.dart';
import 'package:penhas/app/features/quiz/domain/entities/quiz.dart';
import 'package:penhas/app/features/quiz/domain/entities/quiz_message.dart';
import 'package:penhas/app/features/quiz/domain/repositories/i_quiz_repository.dart';
import 'package:penhas/app/features/quiz/domain/send_answer.dart';

void main() {
  group(SendAnswerUseCase, () {
    late SendAnswerUseCase sut;

    late AppStateUseCase mockAppState;
    late IQuizRepository mockRepository;

    setUpAll(() {
      registerFallbackValue(_FakeUserAnswer());
    });

    setUp(() {
      mockAppState = _MockAppStateUseCase();
      mockRepository = _MockQuizRepository();

      sut = SendAnswerUseCase(
        appStateUseCase: mockAppState,
        repository: mockRepository,
      );
    });

    test(
      'should return quiz when repository returns quiz and quiz is not finished',
      () async {
        // arrange
        final quizId = 'quizId';
        final answer = _FakeUserAnswer();
        final expected = Quiz(
          id: quizId,
          messages: [
            QuizMessage.text(content: 'text message'),
            QuizMessage.button(reference: 'ref', label: 'button', value: '1'),
          ],
        );

        when(
          () => mockRepository.send(
            quizId: any(named: 'quizId'),
            answer: any(named: 'answer'),
          ),
        ).thenAnswer((_) async => right(expected));

        // act
        final actual = await sut(quizId, answer);

        // assert
        expect(actual.isRight(), isTrue);
        expect(actual.fold(id, id), expected);
      },
    );

    test(
      'should return quiz when repository returns quiz and quiz is finished',
      () async {
        // arrange
        final quizId = 'other-quiz-id';
        final answer = _FakeUserAnswer();
        final expected = Quiz(
          id: quizId,
          messages: [],
          redirectTo: 'redirectTo',
        );

        when(
          () => mockRepository.send(
            quizId: any(named: 'quizId'),
            answer: any(named: 'answer'),
          ),
        ).thenAnswer((_) async => right(expected));

        when(
          () => mockAppState.check(),
        ).thenAnswer((_) async => right(_FakeAppStateEntity()));

        // act
        final actual = await sut(quizId, answer);

        // assert
        expect(actual.isRight(), isTrue);
        expect(actual.fold(id, id), expected);
      },
    );

    test(
      'should return error when repository returns error',
      () async {
        // arrange
        final quizId = 'quizId';
        final answer = _FakeUserAnswer();
        final expected = ServerFailure();

        when(
          () => mockRepository.send(
            quizId: any(named: 'quizId'),
            answer: any(named: 'answer'),
          ),
        ).thenAnswer((_) async => left(expected));

        // act
        final actual = await sut(quizId, answer);

        // assert
        expect(actual.isLeft(), isTrue);
        expect(actual.fold(id, id), expected);
      },
    );

    test(
      'should return error when appStateUseCase returns error',
      () async {
        // arrange
        final quizId = 'quizId';
        final answer = _FakeUserAnswer();
        final expected = ServerFailure();

        when(
          () => mockRepository.send(
            quizId: any(named: 'quizId'),
            answer: any(named: 'answer'),
          ),
        ).thenAnswer((_) async => right(Quiz(
              id: quizId,
              messages: [],
              redirectTo: 'redirectTo',
            )));

        when(
          () => mockAppState.check(),
        ).thenAnswer((_) async => left(expected));

        // act
        final actual = await sut(quizId, answer);

        // assert
        expect(actual.isLeft(), isTrue);
        expect(actual.fold(id, id), expected);
      },
    );
  });
}

class _MockAppStateUseCase extends Mock implements AppStateUseCase {}

class _MockQuizRepository extends Mock implements IQuizRepository {}

class _FakeUserAnswer extends Fake implements UserAnswer {}

class _FakeAppStateEntity extends Fake implements AppStateEntity {}
