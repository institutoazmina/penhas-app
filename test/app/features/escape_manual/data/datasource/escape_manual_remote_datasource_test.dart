import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/appstate/data/model/quiz_session_model.dart';
import 'package:penhas/app/features/escape_manual/data/datasource/escape_manual_datasource.dart';
import 'package:penhas/app/features/escape_manual/data/datasource/impl/escape_manual_remote_datasource.dart';
import 'package:penhas/app/features/escape_manual/data/model/escape_manual_remote.dart';

import '../../../../../utils/json_util.dart';

void main() {
  late IEscapeManualRemoteDatasource sut;

  late IApiProvider mockApiProvider;

  setUp(() {
    mockApiProvider = MockApiProvider();

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

          // assert
          expectLater(
            () async => await sut.start('MF1234'),
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
          final expectedEscapeManual = EscapeManualRemoteModel(
            assistant: const EscapeManualAssistantRemoteModel(
              title: 'action button',
              subtitle: 'Explanation',
              quizSession: QuizSessionModel(
                sessionId: 'MF1234',
              ),
            ),
            tasks: Iterable.castFrom(const [
              EscapeManualTaskRemoteModel(
                id: '71',
                type: 'checkbox',
                group: 'Itens Básicos',
                title: '',
                description:
                    'Organize uma mochila com roupas. Se achar que a mochila levantará suspeita, separe em sacolas plásticas algumas mudas de roupa. Você pode ir separando as peças de roupas no decorrer dos dias para não levantar suspeitas.',
                isEditable: false,
                isDone: false,
                updatedAt: 1689701023,
              ),
              EscapeManualTaskRemoteModel(
                id: '72',
                type: 'checkbox',
                group: 'Itens Básicos',
                title: '',
                description:
                    'Ponha na mochila medicamentos básicos e de uso contínuo',
                isEditable: false,
                isDone: false,
                updatedAt: 1689701023,
              ),
              EscapeManualTaskRemoteModel(
                id: '73',
                type: 'checkbox',
                group: 'Passos para fuga',
                title: '',
                description:
                    'Cadastre-se e/ou verifique se o seu Cadastro Único (CadÚnico) está ativo.',
                isEditable: false,
                isDone: false,
                updatedAt: 1689701023,
              ),
              EscapeManualTaskRemoteModel(
                id: '75',
                type: 'checkbox',
                group: 'Segurança pessoal',
                title: '',
                description:
                    'Busque o Centro de Referência de Assistência Social (CRAS).',
                isEditable: false,
                isDone: false,
                updatedAt: 1689701025,
              ),
              EscapeManualTaskRemoteModel(
                id: '76',
                type: 'checkbox',
                group: 'Passos para fuga',
                title: '',
                description:
                    'Leve ao CRAS toda documentação necessária, tanto sua, quanto das crianças, se houver.',
                isEditable: false,
                isDone: false,
                updatedAt: 1689701025,
              ),
            ]),
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

          // assert
          expectLater(
            sut.fetch,
            throwsA(isA<Exception>()),
          );
        },
      );
    });
  });
}

class MockApiProvider extends Mock implements IApiProvider {}
