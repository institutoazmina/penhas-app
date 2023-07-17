import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/escape_manual/domain/repository/escape_manual_repository.dart';
import 'package:penhas/app/features/escape_manual/domain/start_escape_manual.dart';

void main() {
  late StartEscapeManualUseCase sut;

  late IEscapeManualRepository mockEscapeManualRepository;

  setUp(() {
    mockEscapeManualRepository = MockEscapeManualRepository();

    sut = StartEscapeManualUseCase(
      repository: mockEscapeManualRepository,
    );
  });

  group(StartEscapeManualUseCase, () {
    test(
      'should call repository start when sessionId starts with MF',
      () async {
        // arrange
        const quizSession = QuizSessionEntity(
          currentMessage: [],
          sessionId: 'MF1234',
          isFinished: false,
          endScreen: null,
        );
        when(() => mockEscapeManualRepository.start(any()))
            .thenAnswer((_) async => right(quizSession));

        // act
        await sut(quizSession);

        // assert
        verify(() => mockEscapeManualRepository.start('MF1234')).called(1);
      },
    );

    test(
      'shoult not call repository start when sessionId not starts with MF',
      () async {
        // arrange
        const quizSession = QuizSessionEntity(
          currentMessage: [],
          sessionId: '1234',
          isFinished: false,
          endScreen: null,
        );

        // act
        await sut(quizSession);

        // assert
        verifyZeroInteractions(mockEscapeManualRepository);
      },
    );

    test(
      'should return repository start when sessionId starts with MF',
      () async {
        // arrange
        const expectedQuizSession = QuizSessionEntity(
          currentMessage: [],
          sessionId: 'sessionId',
          isFinished: false,
          endScreen: null,
        );
        when(() => mockEscapeManualRepository.start(any()))
            .thenAnswer((_) async => right(expectedQuizSession));

        // act
        final result = await sut(
          const QuizSessionEntity(
            currentMessage: [],
            sessionId: 'MF4321',
            isFinished: false,
            endScreen: null,
          ),
        );

        // assert
        expect(result, right(expectedQuizSession));
      },
    );

    test(
      'should return same quizSession when sessionId not starts with MF',
      () async {
        // arrange
        const quizSession = QuizSessionEntity(
          currentMessage: [],
          sessionId: 'sessionId',
          isFinished: false,
          endScreen: null,
        );

        // act
        final result = await sut(quizSession);

        // assert
        expect(result, equals(right(quizSession)));
      },
    );
  });
}

class MockEscapeManualRepository extends Mock
    implements IEscapeManualRepository {}
