import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/appstate/data/model/quiz_session_model.dart';
import 'package:penhas/app/features/escape_manual/data/datasource/impl/escape_manual_remote_datasource.dart';
import 'package:penhas/app/features/escape_manual/data/model/escape_manual_remote.dart';

import '../../../../../../utils/json_util.dart';
import '../../model/escape_manual_fixtures.dart';

void main() {
  late IEscapeManualRemoteDatasource sut;

  late IApiProvider mockApiProvider;

  setUpAll(() {
    registerFallbackValue(_FakeEscapeManualRemoteModel());
  });

  setUp(() {
    mockApiProvider = _MockApiProvider();

    sut = EscapeManualRemoteDatasource(
      apiProvider: mockApiProvider,
    );
  });

  group(EscapeManualRemoteDatasource, () {
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
          verifyNoMoreInteractions(mockApiProvider);
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
          expect(result, expectedQuiz);
        },
      );

      test(
        'should throws a exception when apiProvider post throws',
        () async {
          // arrange
          when(
            () => mockApiProvider.post(
              path: any(named: 'path'),
              parameters: any(named: 'parameters'),
            ),
          ).thenThrow(Exception());

          // act // assert
          expectLater(
            () async => sut.start('MF1234'),
            throwsA(isA<Exception>()),
          );
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
          verifyNoMoreInteractions(mockApiProvider);
        },
      );

      test(
        'should return apiProvider get',
        () async {
          // arrange
          final response = JsonUtil.getStringSync(
            from: 'escape_manual/escape_manual_response.json',
          );
          final expectedEscapeManual = escapeManualRemoteModelFixture;

          when(
            () => mockApiProvider.get(
              path: any(named: 'path'),
              parameters: any(named: 'parameters'),
            ),
          ).thenAnswer((_) async => response);

          // act
          final result = await sut.fetch();

          // assert
          expect(result, equals(expectedEscapeManual));
        },
      );

      test(
        'should throws a failure when apiProvider get throws',
        () async {
          // arrange
          when(
            () => mockApiProvider.get(
              path: any(named: 'path'),
              parameters: any(named: 'parameters'),
            ),
          ).thenThrow(Exception());

          // act // assert
          expectLater(
            sut.fetch,
            throwsA(isA<Exception>()),
          );
        },
      );
    });
  });
}

class _MockApiProvider extends Mock implements IApiProvider {}

class _FakeEscapeManualRemoteModel extends Fake
    implements EscapeManualRemoteModel {}
