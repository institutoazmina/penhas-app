import 'dart:async';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/background_task_manager.dart';
import 'package:penhas/app/features/appstate/data/model/quiz_session_model.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/escape_manual/domain/delete_escape_manual_task.dart';
import 'package:penhas/app/features/escape_manual/domain/entity/escape_manual.dart';
import 'package:penhas/app/features/escape_manual/domain/get_escape_manual.dart';
import 'package:penhas/app/features/escape_manual/domain/start_escape_manual.dart';
import 'package:penhas/app/features/escape_manual/domain/update_escape_manual_task.dart';
import 'package:penhas/app/features/escape_manual/presentation/escape_manual_controller.dart';
import 'package:penhas/app/features/escape_manual/presentation/escape_manual_state.dart';
import 'package:penhas/app/features/escape_manual/presentation/send_pending_escape_manual_task.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import '../data/model/escape_manual_fixtures.dart';

void main() {
  late EscapeManualController sut;

  late GetEscapeManualUseCase mockGetEscapeManual;
  late StartEscapeManualUseCase mockStartEscapeManual;
  late UpdateEscapeManualTaskUseCase mockUpdateEscapeManualTask;
  late DeleteEscapeManualTaskUseCase mockDeleteEscapeManualTask;
  late IBackgroundTaskManager mockBackgroundTaskManager;

  late Completer<EscapeManualEntity> getEscapeManualCompleter;

  setUp(() {
    mockGetEscapeManual = _MockGetEscapeManualUseCase();
    mockStartEscapeManual = _MockStartEscapeManualUseCase();
    mockUpdateEscapeManualTask = _MockUpdateEscapeManualTaskUseCase();
    mockDeleteEscapeManualTask = _MockDeleteEscapeManualTaskUseCase();
    mockBackgroundTaskManager = _MockBackgroundTaskManager();

    getEscapeManualCompleter = Completer();

    when(() => mockGetEscapeManual())
        .thenAnswer((_) => Stream.fromFuture(getEscapeManualCompleter.future));

    sut = EscapeManualController(
      getEscapeManual: mockGetEscapeManual,
      startEscapeManual: mockStartEscapeManual,
      updateTask: mockUpdateEscapeManualTask,
      deleteTask: mockDeleteEscapeManualTask,
      backgroundTaskManager: mockBackgroundTaskManager,
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

    test('dispose should cancel subscription', () async {
      // arrange
      await sut.load();

      // act
      await sut.dispose();

      // assert
      expect(sut.subscription, null);
    });

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
                  isFinished: false,
                  endScreen: null,
                ),
              ),
            ),
            sections: [],
          );

          // act
          getEscapeManualCompleter.complete(escapeManual);
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
                  isFinished: false,
                  endScreen: null,
                ),
              ),
            ),
            sections: [],
          );

          // act
          getEscapeManualCompleter.complete(escapeManual);
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
          getEscapeManualCompleter.completeError(failure);

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

    group('editTask', () {
      final task = EscapeManualContactsTaskEntity(
        id: 'id',
        description: 'description',
        value: [],
        isDone: Random().nextBool(),
      );

      late IModularNavigator mockNavigator;

      setUp(() {
        mockNavigator = _MockModularNavigator();
        Modular.navigatorDelegate = mockNavigator;

        registerFallbackValue(_FakeEscapeManualEditableTaskEntity());

        when(() => mockUpdateEscapeManualTask(any()))
            .thenAnswer((_) async => right(unit));
      });

      test(
        'should navigate to /edit/trusted_contacts screen',
        () async {
          // arrange
          when(
            () => mockNavigator.pushNamed<List<ContactEntity>>(
              '/edit/trusted_contacts',
              arguments: any(named: 'arguments'),
            ),
          ).thenAnswer((_) async => []);

          // act
          await sut.editTask(task);

          // assert
          verify(
            () => mockNavigator.pushNamed<List<ContactEntity>>(
              '/edit/trusted_contacts',
              arguments: task.value,
            ),
          ).called(1);
        },
      );

      test(
        'should not call UpdateEscapeManualTask if value is not changed',
        () async {
          // arrange
          when(
            () => mockNavigator.pushNamed<List<ContactEntity>>(
              '/edit/trusted_contacts',
              arguments: any(named: 'arguments'),
            ),
          ).thenAnswer((_) async => []);

          // act
          await sut.editTask(task);

          // assert
          verifyNever(() => mockUpdateEscapeManualTask(any()));
        },
      );

      test(
        'should call UpdateEscapeManualTask if value is changed',
        () async {
          // arrange
          final updatedTask = task.copyWith(value: [
            ContactEntity(id: 1, name: 'name', phone: '11 11111-1111'),
          ]);
          when(
            () => mockNavigator.pushNamed<List<ContactEntity>>(
              '/edit/trusted_contacts',
              arguments: any(named: 'arguments'),
            ),
          ).thenAnswer((_) async => updatedTask.value);

          // act
          await sut.editTask(task);

          // assert
          verify(() => mockUpdateEscapeManualTask(updatedTask)).called(1);
        },
      );
    });

    group('updateTask', () {
      final task = EscapeManualContactsTaskEntity(
        id: 'id',
        description: 'description',
        value: null,
        isDone: Random().nextBool(),
      );

      late Completer<Either<Failure, void>> updateTaskCompleter;

      setUp(() {
        updateTaskCompleter = Completer();

        registerFallbackValue(_FakeEscapeManualTaskEntity());

        when(() => mockUpdateEscapeManualTask(any()))
            .thenAnswer((_) async => updateTaskCompleter.future);
      });

      test(
        'should call updateTask',
        () async {
          // act
          sut.updateTask(task);

          // assert
          verify(() => mockUpdateEscapeManualTask(task)).called(1);
        },
      );

      test(
        'should schedule task when failed',
        () async {
          // arrange
          final failure = ServerFailure();
          updateTaskCompleter.complete(left(failure));
          when(() => mockBackgroundTaskManager.schedule(any()))
              .thenAnswer((_) => Future.value());

          // act
          await sut.updateTask(task);

          // assert
          verify(
            () => mockBackgroundTaskManager.schedule(
              sendPendingEscapeManualTask,
            ),
          ).called(1);
        },
      );
    });

    group('deleteTask', () {
      final task = EscapeManualDefaultTaskEntity(
        id: 'id',
        description: 'description',
        isDone: Random().nextBool(),
      );

      late Completer<Either<Failure, void>> deleteTaskCompleter;

      setUp(() {
        deleteTaskCompleter = Completer();

        registerFallbackValue(_FakeEscapeManualTaskEntity());

        when(() => mockDeleteEscapeManualTask(any()))
            .thenAnswer((_) async => deleteTaskCompleter.future);
      });

      test(
        'should call deleteTask',
        () async {
          // act
          sut.deleteTask(task);

          // assert
          verify(() => mockDeleteEscapeManualTask(task)).called(1);
        },
      );

      test(
        'should emit showSnackBar reaction when failed',
        () async {
          // arrange
          final failure = ServerFailure();
          deleteTaskCompleter.complete(left(failure));
          when(() => mockBackgroundTaskManager.schedule(any()))
              .thenAnswer((_) => Future.value());

          // act
          await sut.deleteTask(task);

          // assert
          verify(
            () => mockBackgroundTaskManager.schedule(
              sendPendingEscapeManualTask,
            ),
          ).called(1);
        },
      );
    });

    group('openAssistant', () {
      const assistantAction = EscapeManualAssistantActionEntity(
        text: 'button text',
        quizSession: QuizSessionEntity(
          sessionId: 'session_id',
          isFinished: false,
          endScreen: null,
        ),
      );

      late Completer<Either<Failure, QuizSessionEntity>>
          startEscapeManualCompleter;
      late IModularNavigator mockNavigator;

      setUpAll(() {
        registerFallbackValue(_FakeQuizSessionModel());
      });

      setUp(() {
        startEscapeManualCompleter = Completer();
        Modular.navigatorDelegate = mockNavigator = _MockModularNavigate();

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
              '/quiz?origin=escape-manual',
              arguments: assistantAction.quizSession,
            ),
          ).called(1);
        },
      );

      test(
        'should emit showSnackbar reaction when failed',
        () async {
          // arrange
          final onReactionMock = _MockOnEscapeManualReaction();
          final failure = ServerFailure();
          startEscapeManualCompleter.complete(left(failure));
          sut.onReaction(onReactionMock);

          // act
          await sut.openAssistant(assistantAction);

          // assert
          verify(
            () => onReactionMock.call(
              const EscapeManualReaction.showSnackBar(
                'O servidor está com problema neste momento, tente novamente.',
              ),
            ),
          ).called(1);
        },
      );
    });

    group('onTaskButtonPressed', () {
      late IModularNavigator mockNavigator;

      setUp(() {
        Modular.navigatorDelegate = mockNavigator = _MockModularNavigate();
      });

      test(
        'should navigate to task.button.route',
        () async {
          // arrange
          final task = EscapeManualButtonTaskEntity(
            id: 'id',
            description: 'description',
            button: ButtonEntity(
              label: 'label',
              route: '/route',
              arguments: 'arguments',
            ),
          );

          when(
            () => mockNavigator.pushNamed(
              any(),
              arguments: any(named: 'arguments'),
            ),
          ).thenAnswer((_) => Future.value());

          // act
          await sut.onButtonPressed(task.button);

          // assert
          verify(
            () => mockNavigator.pushNamed(
              task.button.route,
              arguments: task.button.arguments,
            ),
          ).called(1);
        },
      );

      test(
        'should emit showSnackbar reaction when failed',
        () async {
          // arrange
          final onReactionMock = _MockOnEscapeManualReaction();
          final task = EscapeManualButtonTaskEntity(
            id: 'id',
            description: 'description',
            button: ButtonEntity(
              label: 'label',
              route: '/route',
              arguments: 'arguments',
            ),
          );

          when(
            () => mockNavigator.pushNamed(
              any(),
              arguments: any(named: 'arguments'),
            ),
          ).thenAnswer((_) => Future.error('error'));

          sut.onReaction(onReactionMock);

          // act
          await sut.onButtonPressed(task.button);

          // assert
          verify(
            () => onReactionMock.call(
              const EscapeManualReaction.showSnackBar(
                'Oops.. ocorreu um erro inesperado, tente novamente mais tarde.',
              ),
            ),
          ).called(1);
        },
      );

      test(
        'should load when success',
        () async {
          // arrange
          final task = EscapeManualButtonTaskEntity(
            id: 'id',
            description: 'description',
            button: ButtonEntity(
              label: 'label',
              route: '/route',
              arguments: 'arguments',
            ),
          );

          when(
            () => mockNavigator.pushNamed(
              any(),
              arguments: any(named: 'arguments'),
            ),
          ).thenAnswer((_) => Future.value(right<Failure, void>(null)));

          // act
          await sut.onButtonPressed(task.button);
          getEscapeManualCompleter.complete(escapeManualEntityFixture);
          await getEscapeManualCompleter.future;

          // assert
          verify(() => mockGetEscapeManual()).called(1);
        },
      );
    });

    group('callTo', () {
      late UrlLauncherPlatform mockUrlLauncher;

      setUp(() {
        mockUrlLauncher = _MockUrlLauncher();
        UrlLauncherPlatform.instance = mockUrlLauncher;

        registerFallbackValue(_FakeLaunchOptions());
      });

      test(
        'should call launchUrlString with correct url',
        () async {
          // arrange
          const contact = ContactEntity(
            id: 1,
            name: 'name',
            phone: '11 11111-1111',
          );
          when(() => mockUrlLauncher.launchUrl(any(), any()))
              .thenAnswer((_) => Future.value(true));

          // act
          sut.callTo(contact);

          // assert
          verify(
            () => mockUrlLauncher.launchUrl(
              'tel:${contact.phone}',
              any(),
            ),
          ).called(1);
        },
      );
    });
  });
}

class _MockGetEscapeManualUseCase extends Mock
    implements GetEscapeManualUseCase {}

class _MockStartEscapeManualUseCase extends Mock
    implements StartEscapeManualUseCase {}

class _MockUpdateEscapeManualTaskUseCase extends Mock
    implements UpdateEscapeManualTaskUseCase {}

class _MockDeleteEscapeManualTaskUseCase extends Mock
    implements DeleteEscapeManualTaskUseCase {}

class _MockModularNavigate extends Mock implements IModularNavigator {}

class _MockUrlLauncher extends Mock
    with MockPlatformInterfaceMixin
    implements UrlLauncherPlatform {}

class _MockOnEscapeManualReaction extends Mock
    implements _IOnEscapeManualReaction {}

class _MockModularNavigator extends Mock implements IModularNavigator {}

class _MockBackgroundTaskManager extends Mock
    implements IBackgroundTaskManager {}

class _FakeEscapeManualTaskEntity extends Fake
    implements EscapeManualTaskEntity {}

class _FakeEscapeManualEditableTaskEntity extends Fake
    implements EscapeManualEditableTaskEntity {}

class _FakeQuizSessionModel extends Fake implements QuizSessionModel {}

class _FakeLaunchOptions extends Fake implements LaunchOptions {}

abstract class _IOnEscapeManualReaction {
  void call(EscapeManualReaction? reaction);
}
