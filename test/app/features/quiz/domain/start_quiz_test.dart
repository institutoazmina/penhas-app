import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/quiz/domain/repositories/i_quiz_repository.dart';
import 'package:penhas/app/features/quiz/domain/start_quiz.dart';

class _MockQuizRepository extends Mock implements IQuizRepository {}

class _FakeQuizSessionEntity extends Fake implements QuizSessionEntity {}

void main() {
  group(StartQuizUseCase, () {
    late StartQuizUseCase sut;

    late IQuizRepository mockRepository;

    setUp(() {
      mockRepository = _MockQuizRepository();

      sut = StartQuizUseCase(
        repository: mockRepository,
      );
    });

    test(
      'should return a valid session for a valid start',
      () async {
        // arrange
        final sessionId = '200';
        final expectedSession = _FakeQuizSessionEntity();

        when(() => mockRepository.start(any())).thenAnswer(
          (_) async => right(expectedSession),
        );

        // act
        final receivedSession = await sut(sessionId);

        // assert
        expect(receivedSession, right(expectedSession));
      },
    );

    test(
      'should return a failure when the repository fails',
      () async {
        // arrange
        final sessionId = '200';
        final expectedFailure = ServerFailure();

        when(
          () => mockRepository.start(any()),
        ).thenAnswer((_) async => left(expectedFailure));

        // act
        final receivedSession = await sut(sessionId);

        // assert
        expect(receivedSession, left(expectedFailure));
      },
    );

    test(
      'should return a InvalidArgumentsFailure for a null sessionId',
      () async {
        // arrange
        final sessionId = null;
        final expectedFailure = InvalidArgumentsFailure();

        // act
        final receivedSession = await sut(sessionId);

        // assert
        expect(receivedSession, left(expectedFailure));
      },
    );
  });
}
