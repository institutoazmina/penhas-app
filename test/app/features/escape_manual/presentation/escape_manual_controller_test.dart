import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/appstate/data/model/quiz_session_model.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/escape_manual/domain/entity/escape_manual.dart';
import 'package:penhas/app/features/escape_manual/domain/get_escape_manual.dart';
import 'package:penhas/app/features/escape_manual/domain/start_escape_manual.dart';
import 'package:penhas/app/features/escape_manual/presentation/escape_manual_controller.dart';
import 'package:penhas/app/features/escape_manual/presentation/escape_manual_state.dart';

void main() {
  late EscapeManualController sut;

  late GetEscapeManualUseCase mockGetEscapeManual;
  late StartEscapeManualUseCase mockStartEscapeManual;

  late Completer<Either<Failure, EscapeManualEntity>> getEscapeManualCompleter;

  setUp(() {
    mockGetEscapeManual = GetEscapeManualUseCaseMock();
    mockStartEscapeManual = StartEscapeManualUseCaseMock();
    getEscapeManualCompleter = Completer();

    when(() => mockGetEscapeManual())
        .thenAnswer((_) async => getEscapeManualCompleter.future);

    sut = EscapeManualController(
      getEscapeManual: mockGetEscapeManual,
      startEscapeManual: mockStartEscapeManual,
    );
  });

  group(EscapeManualController, () {
    test(
      'should have initial state',
      () async {
        // assert
        expect(sut.state, const EscapeManualState.initial());
      },
    );

    group('load', () {
      test(
        'should call getEscapeManual',
        () async {
          // act
          sut.load();

          // assert
          verify(() => mockGetEscapeManual()).called(1);
        },
      );

      test(
        'should call getEscapeManual once when load is called',
        () async {
          // act
          sut.load();
          sut.load();

          // assert
          verify(() => mockGetEscapeManual()).called(1);
        },
      );

      test(
        'should change progress state to loading',
        () async {
          // act
          sut.load();

          // assert
          expect(sut.progressState, PageProgressState.loading);
        },
      );

      test(
        'should change progress state to loaded when success',
        () async {
          // arrange
          const escapeManual = EscapeManualEntity(
            assistant: EscapeManualAssistantEntity(
              explanation: 'explanation',
              action: EscapeManualAssistantActionEntity(
                text: 'button text',
                quizSession: QuizSessionEntity(
                  sessionId: 'session_id',
                  currentMessage: null,
                  isFinished: false,
                  endScreen: null,
                ),
              ),
            ),
          );

          // act
          getEscapeManualCompleter.complete(right(escapeManual));
          await sut.load();

          // assert
          expect(sut.progressState, PageProgressState.loaded);
        },
      );

      test(
        'should change state to loaded when success',
        () async {
          // arrange
          const escapeManual = EscapeManualEntity(
            assistant: EscapeManualAssistantEntity(
              explanation: 'explanation',
              action: EscapeManualAssistantActionEntity(
                text: 'button text',
                quizSession: QuizSessionEntity(
                  sessionId: 'session_id',
                  currentMessage: null,
                  isFinished: false,
                  endScreen: null,
                ),
              ),
            ),
          );

          // act
          getEscapeManualCompleter.complete(right(escapeManual));
          await sut.load();

          // assert
          expect(
            sut.state,
            const EscapeManualState.loaded(escapeManual),
          );
        },
      );

      test(
        'should change state to error when failed',
        () async {
          // arrange
          final failure = ServerFailure();
          getEscapeManualCompleter.complete(left(failure));

          // act
          await sut.load();

          // assert
          expect(
            sut.state,
            const EscapeManualState.error(
              'O servidor está com problema neste momento, tente novamente.',
            ),
          );
        },
      );
    });

    group('openAssistant', () {
      const assistantAction = EscapeManualAssistantActionEntity(
        text: 'button text',
        quizSession: QuizSessionEntity(
          sessionId: 'session_id',
          currentMessage: null,
          isFinished: false,
          endScreen: null,
        ),
      );

      late Completer<Either<Failure, QuizSessionEntity>>
          startEscapeManualCompleter;
      late IModularNavigator mockNavigator;

      setUpAll(() {
        registerFallbackValue(const QuizSessionModel(sessionId: 'session_id'));
      });

      setUp(() {
        startEscapeManualCompleter = Completer();
        Modular.navigatorDelegate = mockNavigator = MockModularNavigate();

        when(() => mockStartEscapeManual(any()))
            .thenAnswer((_) async => startEscapeManualCompleter.future);
        when(
          () => mockNavigator.pushNamed(
            any(),
            arguments: any(named: 'arguments'),
          ),
        ).thenAnswer((_) async => null);
      });

      test(
        'should call startEscapeManual',
        () async {
          // act
          sut.openAssistant(assistantAction);

          // assert
          verify(() => mockStartEscapeManual(assistantAction.quizSession))
              .called(1);
        },
      );

      test(
        'should change progress state to loading',
        () async {
          // act
          sut.openAssistant(assistantAction);

          // assert
          expect(sut.progressState, PageProgressState.loading);
        },
      );

      test(
        'should change progress state to loaded when success',
        () async {
          // arrange
          startEscapeManualCompleter
              .complete(right(assistantAction.quizSession));

          // act
          sut.openAssistant(assistantAction);
          await startEscapeManualCompleter.future;

          // assert
          expect(sut.progressState, PageProgressState.loaded);
        },
      );

      test(
        'should navigate to /quiz screen when success',
        () async {
          // arrange
          startEscapeManualCompleter
              .complete(right(assistantAction.quizSession));

          // act
          await sut.openAssistant(assistantAction);

          // assert
          verify(
            () => mockNavigator.pushNamed(
              '/quiz',
              arguments: assistantAction.quizSession,
            ),
          ).called(1);
        },
      );

      test(
        'should emit showSnackbar reaction when failed',
        () async {
          // arrange
          final onReactionMock = MockOnEscapeManualReaction();
          final failure = ServerFailure();
          startEscapeManualCompleter.complete(left(failure));
          sut.onReaction(onReactionMock);

          // act
          await sut.openAssistant(assistantAction);

          // assert
          verify(
            () => onReactionMock.call(
              const EscapeManualReaction.showSnackbar(
                'O servidor está com problema neste momento, tente novamente.',
              ),
            ),
          ).called(1);
        },
      );
    });
  });
}

class GetEscapeManualUseCaseMock extends Mock
    implements GetEscapeManualUseCase {}

class StartEscapeManualUseCaseMock extends Mock
    implements StartEscapeManualUseCase {}

class MockModularNavigate extends Mock implements IModularNavigator {}

abstract class IOnEscapeManualReaction {
  void call(EscapeManualReaction? reaction);
}

class MockOnEscapeManualReaction extends Mock
    implements IOnEscapeManualReaction {}
