import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/appstate/data/model/quiz_session_model.dart';
import 'package:penhas/app/features/escape_manual/data/datasource/escape_manual_datasource.dart';
import 'package:penhas/app/features/escape_manual/data/model/escape_manual_remote.dart';
import 'package:penhas/app/features/escape_manual/data/repository/escape_manual_repository.dart';
import 'package:penhas/app/features/escape_manual/domain/repository/escape_manual_repository.dart';

void main() {
  late IEscapeManualRepository sut;

  late IEscapeManualRemoteDatasource mockRemoteDatasource;
  late IEscapeManualLocalDatasource mockLocalDatasource;

  setUp(() {
    mockRemoteDatasource = MockEscapeManualRemoteDatasource();
    mockLocalDatasource = MockEscapeManualLocalDatasource();

    sut = EscapeManualRepository(
      remoteDatasource: mockRemoteDatasource,
      localDatasource: mockLocalDatasource,
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
          final result = await sut.fetch();

          // assert
          expect(result, right(escapeManual));
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
    });
  });
}

class MockEscapeManualRemoteDatasource extends Mock
    implements IEscapeManualRemoteDatasource {}

class MockEscapeManualLocalDatasource extends Mock
    implements IEscapeManualLocalDatasource {}
