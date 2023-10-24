import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/appstate/data/model/quiz_session_model.dart';
import 'package:penhas/app/features/escape_manual/data/datasource/escape_manual_datasource.dart';
import 'package:penhas/app/features/escape_manual/data/model/escape_manual_local.dart';
import 'package:penhas/app/features/escape_manual/data/model/escape_manual_remote.dart';
import 'package:penhas/app/features/escape_manual/data/repository/escape_manual_repository.dart';

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
        'should call datasource updateTask',
        () async {
          // arrange
          final task = escapeManualTaskEntityFixture;
          final localTask = EscapeManualTaskLocalModel(
            id: task.id,
            isDone: task.isDone,
          );
          when(() => mockLocalDatasource.saveTask(any()))
              .thenAnswer((_) async => unit);

          // act
          final result = await sut.updateTask(task);

          // assert
          expect(result.isRight(), isTrue);
          verify(() => mockLocalDatasource.saveTask(localTask)).called(1);
        },
      );

      test(
        'should return failure when datasource updateTask throws',
        () async {
          // arrange
          final task = escapeManualTaskEntityFixture;
          when(() => mockLocalDatasource.saveTask(any()))
              .thenThrow(Exception());

          // act
          final result = await sut.updateTask(task);

          // assert
          expect(result.isLeft(), isTrue);
          expect(result.fold(id, (_) {}), isA<Failure>());
        },
      );
    });

    group('removeTask', () {
      test(
        'should call datasource removeTask',
        () async {
          // arrange
          final task = escapeManualTaskEntityFixture;
          final localTask = EscapeManualTaskLocalModel(
            id: task.id,
            isDone: task.isDone,
          );
          when(() => mockLocalDatasource.removeTask(any()))
              .thenAnswer((_) async => unit);

          // act
          final result = await sut.removeTask(task);

          // assert
          expect(result.isRight(), isTrue);
          verify(() => mockLocalDatasource.removeTask(localTask)).called(1);
        },
      );

      test(
        'should return failure when datasource removeTask throws',
        () async {
          // arrange
          final task = escapeManualTaskEntityFixture;
          when(() => mockLocalDatasource.removeTask(any()))
              .thenThrow(Exception());

          // act
          final result = await sut.removeTask(task);

          // assert
          expect(result.isLeft(), isTrue);
          expect(result.fold(id, (_) {}), isA<Failure>());
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
