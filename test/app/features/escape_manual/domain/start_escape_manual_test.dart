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
    mockEscapeManualRepository = _MockEscapeManualRepository();

    sut = StartEscapeManualUseCase(
      repository: mockEscapeManualRepository,
    );
  });

  setUpAll(() {
    registerFallbackValue(_FakeQuizSessionEntity());
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
      'shoult call repository resume when sessionId not starts with MF',
      () async {
        // arrange
        const quizSession = QuizSessionEntity(
          currentMessage: [],
          sessionId: '1234',
          isFinished: false,
          endScreen: null,
        );
        when(() => mockEscapeManualRepository.resume(any()))
            .thenAnswer((_) async => right(quizSession));

        // act
        await sut(quizSession);

        // assert
        verify(() => mockEscapeManualRepository.resume(quizSession)).called(1);
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
      'should return repository resume when sessionId not starts with MF',
      () async {
        // arrange
        const quizSession = QuizSessionEntity(
          currentMessage: [],
          sessionId: 'sessionId',
          isFinished: false,
          endScreen: null,
        );
        when(() => mockEscapeManualRepository.resume(any()))
            .thenAnswer((_) async => right(quizSession));

        // act
        final result = await sut(
          const QuizSessionEntity(
            currentMessage: [],
            sessionId: '4321',
            isFinished: false,
            endScreen: null,
          ),
        );

        // assert
        expect(result, equals(right(quizSession)));
      },
    );
  });
}

class _MockEscapeManualRepository extends Mock
    implements IEscapeManualRepository {}

class _FakeQuizSessionEntity extends Fake implements QuizSessionEntity {}
