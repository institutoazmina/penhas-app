import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/appstate/data/model/quiz_session_model.dart';
import 'package:penhas/app/features/escape_manual/data/datasource/escape_manual_datasource.dart';
import 'package:penhas/app/features/escape_manual/data/model/escape_manual.dart';
import 'package:penhas/app/features/escape_manual/data/repository/escape_manual_repository.dart';
import 'package:penhas/app/features/escape_manual/domain/repository/escape_manual_repository.dart';

void main() {
  late IEscapeManualRepository sut;

  late IEscapeManualDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockEscapeManualDatasource();

    sut = EscapeManualRepository(
      datasource: mockDatasource,
    );
  });

  group(EscapeManualRepository, () {
    group('fetch', () {
      test(
        'should call datasource fetch',
        () async {
          // arrange
          const escapeManual = EscapeManualModel(
            assistant: EscapeManualAssistantModel(
              explanation: 'explanation',
              action: EscapeManualAssistantActionModel(
                text: 'text',
                quizSession: QuizSessionModel(
                  sessionId: 'sessionId',
                ),
              ),
            ),
          );
          when(() => mockDatasource.fetch())
              .thenAnswer((_) async => right(escapeManual));

          // act
          await sut.fetch();

          // assert
          verify(() => mockDatasource.fetch()).called(1);
        },
      );

      test(
        'should return datasource fetch',
        () async {
          // arrange
          const escapeManual = EscapeManualModel(
            assistant: EscapeManualAssistantModel(
              explanation: 'explanation',
              action: EscapeManualAssistantActionModel(
                text: 'text',
                quizSession: QuizSessionModel(
                  sessionId: 'sessionId',
                ),
              ),
            ),
          );
          when(() => mockDatasource.fetch())
              .thenAnswer((_) async => right(escapeManual));

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
          when(() => mockDatasource.start(any()))
              .thenAnswer((_) async => right(quizSession));

          // act
          await sut.start('MF1234');

          // assert
          verify(() => mockDatasource.start('MF1234')).called(1);
        },
      );

      test(
        'should return datasource start',
        () async {
          // arrange
          const quizSession = QuizSessionModel(
            sessionId: 'sessionId',
          );
          when(() => mockDatasource.start(any()))
              .thenAnswer((_) async => right(quizSession));

          // act
          final result = await sut.start('MF1234');

          // assert
          expect(result, right(quizSession));
        },
      );
    });
  });
}

class MockEscapeManualDatasource extends Mock
    implements IEscapeManualDatasource {}
