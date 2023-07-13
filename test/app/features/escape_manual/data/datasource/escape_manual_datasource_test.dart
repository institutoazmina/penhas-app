import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/appstate/data/model/quiz_session_model.dart';
import 'package:penhas/app/features/escape_manual/data/datasource/escape_manual_datasource.dart';
import 'package:penhas/app/features/escape_manual/data/model/escape_manual.dart';

import '../../../../../utils/json_util.dart';

void main() {
  late IEscapeManualDatasource sut;

  late IApiProvider mockApiProvider;

  setUp(() {
    mockApiProvider = MockApiProvider();

    sut = EscapeManualDatasource(
      apiProvider: mockApiProvider,
    );
  });

  group(EscapeManualDatasource, () {
    group('start', () {
      test(
        'should call apiProvider post',
        () async {
          // arrange
          final response = JsonUtil.getStringSync(
            from: 'escape_manual/quiz_session_response.json',
          );
          when(
            () => mockApiProvider.post(
              path: any(named: 'path'),
              parameters: any(named: 'parameters'),
            ),
          ).thenAnswer((_) async => response);

          // act
          await sut.start('MF1234');

          // assert
          verify(
            () => mockApiProvider.post(
              path: '/me/quiz',
              parameters: {'session_id': 'MF1234'},
            ),
          ).called(1);
        },
      );
      test(
        'should return apiProvider post',
        () async {
          // arrange
          final response = JsonUtil.getStringSync(
            from: 'escape_manual/quiz_session_response.json',
          );
          const expectedQuiz = QuizSessionModel(sessionId: 'session_id');
          when(
            () => mockApiProvider.post(
              path: any(named: 'path'),
              parameters: any(named: 'parameters'),
            ),
          ).thenAnswer((_) async => response);

          // act
          final result = await sut.start('MF1234');

          // assert
          expect(result, right(expectedQuiz));
        },
      );
    });

    group('fetch', () {
      test(
        'should call apiProvider get',
        () async {
          // arrange
          final response = JsonUtil.getStringSync(
            from: 'escape_manual/escape_manual_response.json',
          );
          when(
            () => mockApiProvider.get(
              path: any(named: 'path'),
              parameters: any(named: 'parameters'),
            ),
          ).thenAnswer((_) async => response);

          // act
          await sut.fetch();

          // assert
          verify(
            () => mockApiProvider.get(
              path: '/me/tarefas',
              parameters: {
                'modificado_apos': '0',
              },
            ),
          ).called(1);
        },
      );

      test(
        'should return apiProvider get',
        () async {
          // arrange
          final response = JsonUtil.getStringSync(
            from: 'escape_manual/escape_manual_response.json',
          );
          const expectedEscapeManual = EscapeManualModel(
            assistant: EscapeManualAssistantModel(
              explanation: 'Explanation',
              action: EscapeManualAssistantActionModel(
                text: 'action button',
                quizSession: QuizSessionModel(
                  sessionId: 'MF1234',
                ),
              ),
            ),
          );
          when(
            () => mockApiProvider.get(
              path: any(named: 'path'),
              parameters: any(named: 'parameters'),
            ),
          ).thenAnswer((_) async => response);

          // act
          final result = await sut.fetch();

          // assert
          expect(result, right(expectedEscapeManual));
        },
      );
    });
  });
}

class MockApiProvider extends Mock implements IApiProvider {}
