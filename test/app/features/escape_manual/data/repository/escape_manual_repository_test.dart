import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/appstate/data/model/quiz_session_model.dart';
import 'package:penhas/app/features/escape_manual/data/datasource/escape_manual_datasource.dart';
import 'package:penhas/app/features/escape_manual/data/model/escape_manual_remote.dart';
import 'package:penhas/app/features/escape_manual/data/repository/escape_manual_repository.dart';

import '../model/escape_manual_fixtures.dart';

void main() {
  late IEscapeManualRepository sut;

  late IEscapeManualRemoteDatasource mockRemoteDatasource;

  setUp(() {
    mockRemoteDatasource = _MockEscapeManualRemoteDatasource();

    sut = EscapeManualRepository(
      remoteDatasource: mockRemoteDatasource,
    );
  });

  group(EscapeManualRepository, () {
    group('fetch', () {
      test(
        'should call datasource fetch',
        () async {
          // arrange
          const escapeManual = EscapeManualRemoteModel(
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

          // act
          await sut.fetch();

          // assert
          verify(() => mockRemoteDatasource.fetch()).called(1);
        },
      );

      test(
        'should return datasource fetch',
        () async {
          // arrange
          final escapeManualModel = escapeManualModelFixture;
          const expectedEscapeManual = escapeManualEntityFixture;

          when(() => mockRemoteDatasource.fetch())
              .thenAnswer((_) async => escapeManualModel);

          // act
          final result = await sut.fetch();

          // assert
          expect(result, right(expectedEscapeManual));
        },
      );

      test(
        'should return failure when datasource fetch throws',
        () async {
          // arrange
          when(() => mockRemoteDatasource.fetch()).thenThrow(Exception());

          // act
          final result = await sut.fetch();

          // assert
          expect(result.isLeft(), isTrue);
          expect(result.fold(id, id), isA<Failure>());
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
  });
}

class _MockEscapeManualRemoteDatasource extends Mock
    implements IEscapeManualRemoteDatasource {}
