import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
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
        final completer = Completer<EscapeManualEntity>();
        when(() => mockEscapeManualRepository.fetch())
            .thenAnswer((_) => Stream.fromFuture(completer.future));

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
          sections: [],
        );

        when(() => mockEscapeManualRepository.fetch())
            .thenAnswer((_) => Stream.value(escapeManual));

        // act / assert
        expectLater(
          sut(),
          emits(escapeManual),
        );
      },
    );

    test(
      'should sort tasks',
      () async {
        // arrange
        final escapeManual = EscapeManualEntity(
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
          sections: [
            EscapeManualTasksSectionEntity(
              title: 'Section I',
              tasks: unsortedTasks,
            ),
          ],
        );
        final expectedEscapeManual = escapeManual.copyWith(
          sections: [
            EscapeManualTasksSectionEntity(
              title: 'Section I',
              tasks: sortedTasks,
            ),
          ],
        );

        when(() => mockEscapeManualRepository.fetch())
            .thenAnswer((_) => Stream.value(escapeManual));

        // act
        sut();

        // assert
        expectLater(
          sut(),
          emits(expectedEscapeManual),
        );
      },
    );
  });
}

final unsortedTasks = [
  EscapeManualDefaultTaskEntity(
    id: '1',
    description: 'description',
    isDone: false,
  ),
  EscapeManualDefaultTaskEntity(
    id: '2',
    description: 'description',
    isDone: true,
  ),
  EscapeManualDefaultTaskEntity(
    id: '3',
    description: 'description',
    isDone: false,
  ),
  EscapeManualDefaultTaskEntity(
    id: '4',
    description: 'description',
    isDone: true,
  ),
];

final sortedTasks = [
  EscapeManualDefaultTaskEntity(
    id: '1',
    description: 'description',
    isDone: false,
  ),
  EscapeManualDefaultTaskEntity(
    id: '3',
    description: 'description',
    isDone: false,
  ),
  EscapeManualDefaultTaskEntity(
    id: '2',
    description: 'description',
    isDone: true,
  ),
  EscapeManualDefaultTaskEntity(
    id: '4',
    description: 'description',
    isDone: true,
  ),
];

class MockEscapeManualRepository extends Mock
    implements IEscapeManualRepository {}
