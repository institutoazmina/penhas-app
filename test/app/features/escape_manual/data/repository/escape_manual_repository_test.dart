import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/appstate/data/model/quiz_session_model.dart';
import 'package:penhas/app/features/escape_manual/data/datasource/escape_manual_datasource.dart';
import 'package:penhas/app/features/escape_manual/data/model/escape_manual_local.dart';
import 'package:penhas/app/features/escape_manual/data/model/escape_manual_remote.dart';
import 'package:penhas/app/features/escape_manual/data/repository/escape_manual_repository.dart';

import '../../../../../utils/json_util.dart';
import '../model/escape_manual_fixtures.dart';

void main() {
  late IEscapeManualRepository sut;

  late IEscapeManualRemoteDatasource mockRemoteDatasource;
  late IEscapeManualLocalDatasource mockLocalDatasource;

  setUpAll(() {
    registerFallbackValue(_FakeEscapeManualTaskLocalModel());
  });

  setUp(() {
    mockRemoteDatasource = _MockEscapeManualRemoteDatasource();
    mockLocalDatasource = _MockEscapeManualLocalDatasource();

    sut = EscapeManualRepository(
      localDatasource: mockLocalDatasource,
      remoteDatasource: mockRemoteDatasource,
    );

    when(() => mockLocalDatasource.clearBefore(any()))
        .thenAnswer((_) => Future.value());
  });

  group(EscapeManualRepository, () {
    group('fetch', () {
      test(
        'should call datasource fetch',
        () async {
          // arrange
          final escapeManual = EscapeManualRemoteModel(
            lastModifiedAt: DateTime.now(),
            assistant: EscapeManualAssistantRemoteModel(
              title: 'text',
              subtitle: 'explanation',
              quizSession: QuizSessionModel(
                sessionId: 'sessionId',
              ),
            ),
          );
          when(() => mockRemoteDatasource.fetch())
              .thenAnswer((_) async => escapeManual);
          when(() => mockLocalDatasource.fetchTasks())
              .thenAnswer((_) => Stream.value([]));

          // act
          await sut.fetch().drain();

          // assert
          verify(() => mockRemoteDatasource.fetch()).called(1);
        },
      );

      test(
        'should return remote datasource result when local datasource is empty',
        () async {
          // arrange
          final escapeManualModel = escapeManualModelFixture;
          final expectedEscapeManual = escapeManualEntityFixture;

          when(() => mockRemoteDatasource.fetch())
              .thenAnswer((_) async => escapeManualModel);
          when(() => mockLocalDatasource.fetchTasks())
              .thenAnswer((_) => Stream.value([]));

          // act / assert
          expectLater(
            sut.fetch(),
            emits(expectedEscapeManual),
          );
        },
      );

      test(
        'should return merged datasource result when local datasource is not empty',
        () async {
          // arrange
          final escapeManualModel = escapeManualModelFixture;
          final expectedEscapeManual = updatedEscapeManualEntityFixture;

          when(() => mockRemoteDatasource.fetch())
              .thenAnswer((_) async => escapeManualModel);
          when(() => mockLocalDatasource.fetchTasks()).thenAnswer(
            (_) => Stream.value(escapeManualLocalModelsFixture),
          );

          // act / assert
          expectLater(
            sut.fetch(),
            emits(expectedEscapeManual),
          );
        },
      );

      test(
        'should return result once when local datasource emits the same data twice',
        () async {
          // arrange
          final escapeManualModel = escapeManualModelFixture;
          final expectedEscapeManual = updatedEscapeManualEntityFixture;

          when(() => mockRemoteDatasource.fetch())
              .thenAnswer((_) async => escapeManualModel);
          when(() => mockLocalDatasource.fetchTasks()).thenAnswer(
            (_) => Stream.fromIterable([
              escapeManualLocalModelsFixture,
              escapeManualLocalModelsFixture,
            ]),
          );

          // act / assert
          expectLater(
            sut.fetch(),
            emitsInOrder([expectedEscapeManual, emitsDone]),
          );
        },
      );

      test(
        'should return failure when datasource fetch throws',
        () async {
          // arrange
          when(() => mockRemoteDatasource.fetch()).thenThrow(Exception());

          // act / assert
          expectLater(
            sut.fetch(),
            emitsError(isA<ServerFailure>()),
          );
        },
      );

      test(
        'should not throws on broken response',
        () async {
          // arrange
          final expectedEscapeManual = escapeManualEntityBroken;
          final response = await JsonUtil.getJson(
            from: 'escape_manual/escape_manual_broken_response.json',
          );
          when(() => mockRemoteDatasource.fetch()).thenAnswer(
            (_) async => EscapeManualRemoteModel.fromJson(response),
          );
          when(() => mockLocalDatasource.fetchTasks())
              .thenAnswer((_) => Stream.value([]));

          // act
          final actual = sut.fetch;

          // assert
          expectLater(
            actual(),
            emitsInOrder([expectedEscapeManual, emitsDone]),
          );
        },
      );
    });

    group('start', () {
      test(
        'should call datasource start',
        () async {
          // arrange
          const quizSession = QuizSessionModel(
            sessionId: 'sessionId',
          );
          when(() => mockRemoteDatasource.start(any()))
              .thenAnswer((_) async => quizSession);

          // act
          await sut.start('MF1234');

          // assert
          verify(() => mockRemoteDatasource.start('MF1234')).called(1);
        },
      );

      test(
        'should return datasource start',
        () async {
          // arrange
          const quizSession = QuizSessionModel(
            sessionId: 'sessionId',
          );
          when(() => mockRemoteDatasource.start(any()))
              .thenAnswer((_) async => quizSession);

          // act
          final result = await sut.start('MF1234');

          // assert
          expect(result, right(quizSession));
        },
      );

      test(
        'should return failure when datasource start throws',
        () async {
          // arrange
          when(() => mockRemoteDatasource.start(any())).thenThrow(Exception());

          // act
          final result = await sut.start('MF1234');

          // assert
          expect(result.isLeft(), isTrue);
          expect(result.fold(id, id), isA<Failure>());
        },
      );
    });

    group('updateTask', () {
      test(
        'should call datasources updateTask',
        () async {
          // arrange
          final task = escapeManualEditableTaskEntityFixture;
          final localTask = EscapeManualTaskLocalModel(
            id: task.id,
            type: EscapeManualTaskType.contacts,
            isDone: task.isDone,
            value: task.value,
          );
          when(() => mockLocalDatasource.saveTask(any())).thenAnswer(
            (invocation) async => invocation.positionalArguments[0],
          );
          when(() => mockRemoteDatasource.saveTask(any())).thenAnswer(
            (invocation) async => invocation.positionalArguments[0],
          );

          // act
          final result = await sut.updateTask(task);

          // assert
          expect(result.isRight(), isTrue);
          verifyInOrder([
            () => mockLocalDatasource.saveTask(localTask),
            () => mockRemoteDatasource.saveTask(localTask),
            () => mockLocalDatasource.saveTask(localTask),
          ]);
          verifyNoMoreInteractions(mockLocalDatasource);
          verifyNoMoreInteractions(mockRemoteDatasource);
        },
      );

      test(
        'should return failure when local datasource updateTask throws',
        () async {
          // arrange
          final task = escapeManualEditableTaskEntityFixture;
          when(() => mockLocalDatasource.saveTask(any()))
              .thenThrow(Exception());

          // act
          final result = await sut.updateTask(task);

          // assert
          expect(result.isLeft(), isTrue);
          expect(result.fold(id, (_) {}), isA<Failure>());
          verify(() => mockLocalDatasource.saveTask(any())).called(1);
          verifyNoMoreInteractions(mockLocalDatasource);
          verifyNoMoreInteractions(mockRemoteDatasource);
        },
      );

      test(
        'should return failure when remote datasource updateTask throws',
        () async {
          // arrange
          final task = escapeManualEditableTaskEntityFixture;
          when(() => mockLocalDatasource.saveTask(any())).thenAnswer(
            (invocation) async => invocation.positionalArguments[0],
          );
          when(() => mockRemoteDatasource.saveTask(any()))
              .thenThrow(Exception());

          // act
          final result = await sut.updateTask(task);

          // assert
          expect(result.isLeft(), isTrue);
          expect(result.fold(id, (_) {}), isA<Failure>());
          verifyInOrder([
            () => mockLocalDatasource.saveTask(any()),
            () => mockRemoteDatasource.saveTask(any()),
          ]);
          verifyNoMoreInteractions(mockLocalDatasource);
          verifyNoMoreInteractions(mockRemoteDatasource);
        },
      );
    });

    group('removeTask', () {
      test(
        'should call datasources saveTask with isRemoved true',
        () async {
          // arrange
          final task = escapeManualTaskEntityFixture;
          final localTask = EscapeManualTaskLocalModel(
            id: task.id,
            isDone: task.isDone,
            isRemoved: true,
          );
          when(() => mockLocalDatasource.saveTask(any())).thenAnswer(
            (invocation) async => invocation.positionalArguments[0],
          );
          when(() => mockRemoteDatasource.saveTask(any())).thenAnswer(
            (invocation) async => invocation.positionalArguments[0],
          );

          // act
          final result = await sut.removeTask(task);

          // assert
          expect(result.isRight(), isTrue);
          verifyInOrder([
            () => mockLocalDatasource.saveTask(localTask),
            () => mockRemoteDatasource.saveTask(localTask),
            () => mockLocalDatasource.saveTask(localTask),
          ]);
          verifyNoMoreInteractions(mockLocalDatasource);
          verifyNoMoreInteractions(mockRemoteDatasource);
        },
      );

      test(
        'should return failure when local datasource saveTask throws',
        () async {
          // arrange
          final task = escapeManualTaskEntityFixture;
          when(() => mockLocalDatasource.saveTask(any()))
              .thenThrow(Exception());

          // act
          final result = await sut.removeTask(task);

          // assert
          expect(result.isLeft(), isTrue);
          expect(result.fold(id, (_) {}), isA<Failure>());
          verify(() => mockLocalDatasource.saveTask(any())).called(1);
          verifyNoMoreInteractions(mockLocalDatasource);
          verifyNoMoreInteractions(mockRemoteDatasource);
        },
      );

      test(
        'should return failure when remote datasource saveTask throws',
        () async {
          // arrange
          final task = escapeManualTaskEntityFixture;
          when(() => mockLocalDatasource.saveTask(any())).thenAnswer(
            (invocation) async => invocation.positionalArguments[0],
          );
          when(() => mockRemoteDatasource.saveTask(any()))
              .thenThrow(Exception());

          // act
          final result = await sut.removeTask(task);

          // assert
          expect(result.isLeft(), isTrue);
          expect(result.fold(id, (_) {}), isA<Failure>());
          expect(result.fold(id, (_) {}), isA<Failure>());
          verifyInOrder([
            () => mockLocalDatasource.saveTask(any()),
            () => mockRemoteDatasource.saveTask(any()),
          ]);
          verifyNoMoreInteractions(mockLocalDatasource);
          verifyNoMoreInteractions(mockRemoteDatasource);
        },
      );
    });

    group('sendPendingTasks', () {
      test(
        'should not send tasks if there are no pending tasks',
        () async {
          // arrange
          when(() => mockLocalDatasource.getTasks()).thenAnswer(
            (_) => Future.value([
              EscapeManualTaskLocalModel(
                id: 'id',
                type: EscapeManualTaskType.contacts,
                updatedAt: DateTime.now(),
                isDone: true,
                isRemoved: false,
              ),
            ]),
          );

          // act
          final result = await sut.sendPendingTasks();

          // assert
          expect(result.isRight(), isTrue);
          verify(() => mockLocalDatasource.getTasks()).called(1);
          verifyNoMoreInteractions(mockLocalDatasource);
          verifyNoMoreInteractions(mockRemoteDatasource);
        },
      );

      test(
        'should send only pending tasks',
        () async {
          // arrange
          final tasks = [
            EscapeManualTaskLocalModel(
              id: 'id',
              updatedAt: DateTime.now(),
            ),
            EscapeManualTaskLocalModel(
              id: 'id2',
            ),
            EscapeManualTaskLocalModel(
              id: 'id3',
              updatedAt: DateTime.now(),
            ),
          ];
          when(() => mockLocalDatasource.getTasks()).thenAnswer(
            (_) => Future.value(tasks),
          );
          when(() => mockRemoteDatasource.saveTasks(any())).thenAnswer(
            (invocation) async => invocation.positionalArguments[0],
          );
          when(() => mockLocalDatasource.saveTasks(any())).thenAnswer(
            (invocation) async => invocation.positionalArguments[0],
          );

          // act
          final result = await sut.sendPendingTasks();

          // assert
          expect(result.isRight(), isTrue);
          verifyInOrder([
            () => mockLocalDatasource.getTasks(),
            () => mockRemoteDatasource.saveTasks([tasks[1]]),
            () => mockLocalDatasource.saveTasks([tasks[1]]),
          ]);
          verifyNoMoreInteractions(mockLocalDatasource);
          verifyNoMoreInteractions(mockRemoteDatasource);
        },
      );

      test(
        'should return failure when remote datasource saveTasks throws',
        () async {
          // arrange
          final tasks = [
            EscapeManualTaskLocalModel(
              id: 'id',
            ),
          ];
          when(() => mockLocalDatasource.getTasks()).thenAnswer(
            (_) => Future.value(tasks),
          );
          when(() => mockRemoteDatasource.saveTasks(any()))
              .thenThrow(Exception());

          // act
          final result = await sut.sendPendingTasks();

          // assert
          expect(result.isLeft(), isTrue);
          expect(result.fold(id, (_) {}), isA<Failure>());
          verifyInOrder([
            () => mockLocalDatasource.getTasks(),
            () => mockRemoteDatasource.saveTasks([tasks[0]]),
          ]);
          verifyNoMoreInteractions(mockLocalDatasource);
          verifyNoMoreInteractions(mockRemoteDatasource);
        },
      );
    });
  });
}

class _MockEscapeManualLocalDatasource extends Mock
    implements IEscapeManualLocalDatasource {}

class _MockEscapeManualRemoteDatasource extends Mock
    implements IEscapeManualRemoteDatasource {}

class _FakeEscapeManualTaskLocalModel extends Fake
    implements EscapeManualTaskLocalModel {}
