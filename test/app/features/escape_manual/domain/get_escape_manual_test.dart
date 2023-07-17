import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/escape_manual/domain/entity/escape_manual.dart';
import 'package:penhas/app/features/escape_manual/domain/get_escape_manual.dart';
import 'package:penhas/app/features/escape_manual/domain/repository/escape_manual_repository.dart';

void main() {
  late GetEscapeManualUseCase sut;

  late IEscapeManualRepository mockEscapeManualRepository;

  setUp(() {
    mockEscapeManualRepository = MockEscapeManualRepository();

    sut = GetEscapeManualUseCase(
      repository: mockEscapeManualRepository,
    );
  });

  group(GetEscapeManualUseCase, () {
    test(
      'should call repository fetch',
      () async {
        // arrange
        final completer = Completer<Either<Failure, EscapeManualEntity>>();
        when(() => mockEscapeManualRepository.fetch())
            .thenAnswer((_) async => completer.future);

        // act
        sut();

        // assert
        verify(() => mockEscapeManualRepository.fetch()).called(1);
      },
    );

    test(
      'should return repository fetch',
      () async {
        // arrange
        const escapeManual = EscapeManualEntity(
          assistant: EscapeManualAssistantEntity(
            explanation: 'explanation',
            action: EscapeManualAssistantActionEntity(
              text: 'text',
              quizSession: QuizSessionEntity(
                currentMessage: [],
                sessionId: 'sessionId',
                isFinished: false,
                endScreen: null,
              ),
            ),
          ),
        );

        when(() => mockEscapeManualRepository.fetch())
            .thenAnswer((_) async => right(escapeManual));

        // act
        final result = await sut();

        // assert
        expect(result, right(escapeManual));
      },
    );
  });
}

class MockEscapeManualRepository extends Mock
    implements IEscapeManualRepository {}
