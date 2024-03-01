import 'package:dartz/dartz.dart' show id, right;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/app_module.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';
import 'package:penhas/app/features/appstate/data/model/quiz_session_model.dart';
import 'package:penhas/app/features/quiz/data/datasources/quiz_data_source.dart';
import 'package:penhas/app/features/quiz/data/repositories/quiz_repository.dart';
import 'package:penhas/app/features/quiz/domain/entities/answer.dart';
import 'package:penhas/app/features/quiz/domain/entities/quiz_message.dart';
import 'package:penhas/app/features/quiz/domain/entities/quiz_request_entity.dart';
import 'package:penhas/app/features/quiz/domain/repositories/i_quiz_repository.dart';
import 'package:penhas/app/features/quiz/quiz_module.dart';

import '../../../../../utils/json_util.dart';
import '../quiz_fixtures.dart';

class MockNetworkInfo extends Mock implements INetworkInfo {}

class MockQuizDataSource extends Mock implements IQuizDataSource {}

class _MockHttpClient extends Mock implements Client {}

class _MockApiServerConfigure extends Mock implements IApiServerConfigure {}

void main() {
  late QuizRepository quizRepository;

  late IQuizDataSource dataSource;
  late INetworkInfo networkInfo;
  late QuizRequestEntity quizRequest;
  late Map<String, dynamic> jsonData;

  setUpAll(() {
    registerFallbackValue(Uri.parse(''));
  });

  setUp(() async {
    networkInfo = MockNetworkInfo();
    dataSource = MockQuizDataSource();
    quizRepository = QuizRepository(
      dataSource: dataSource,
      networkInfo: networkInfo,
    );

    quizRequest = const QuizRequestEntity(
      sessionId: '200',
      options: {'YN1': 'Y'},
    );

    jsonData =
        await JsonUtil.getJson(from: 'profile/quiz_session_response.json');

    when(() => networkInfo.isConnected).thenAnswer((_) async => true);
  });

  group(QuizRepository, () {
    test(
      'return a valid session for a valid update',
      () async {
        // arrange
        final expectedSession = AppStateModel.fromJson(jsonData);

        when(() => dataSource.update(quiz: any(named: 'quiz')))
            .thenAnswer((_) => Future.value(expectedSession));
        // act
        final receivedSession = await quizRepository.update(quiz: quizRequest);
        // assert
        expect(receivedSession.fold((l) => l, (r) => r), expectedSession);
      },
    );

    test(
      'return ServerSideSessionFailed for a invalid session',
      () async {
        // arrange
        when(() => dataSource.update(quiz: any(named: 'quiz')))
            .thenThrow(ApiProviderSessionError());
        // act
        final received = await quizRepository.update(quiz: quizRequest);
        // assert
        expect(received.fold((l) => l, (r) => r), ServerSideSessionFailed());
      },
    );

    test(
      'return ServerSideSessionFailed for a invalid JWT',
      () async {
        // arrange
        when(() => dataSource.update(quiz: any(named: 'quiz'))).thenThrow(
          const ApiProviderException(
            bodyContent: {
              'error': 'expired_jwt',
              'message': 'Bad request - Invalid JWT'
            },
          ),
        );
        // act
        final received = await quizRepository.update(quiz: quizRequest);
        // assert
        expect(received.fold((l) => l, (r) => r), ServerSideSessionFailed());
      },
    );

    test(
      'with internet off return InternetConnectionFailure',
      () async {
        // arrange
        when(() => networkInfo.isConnected).thenAnswer((_) async => false);
        // act
        final received = await quizRepository.update(quiz: quizRequest);
        // assert
        expect(received.fold((l) => l, (r) => r), InternetConnectionFailure());
      },
    );

    test(
      'return ServerSideFormFieldValidationFailure for server error',
      () async {
        // arrange
        final expected = ServerSideFormFieldValidationFailure(
          error: 'server_error',
          message: 'message_error',
          field: 'field_error',
          reason: 'reason_error',
        );
        when(() => dataSource.update(quiz: any(named: 'quiz'))).thenThrow(
          const ApiProviderException(
            bodyContent: {
              'error': 'server_error',
              'message': 'message_error',
              'field': 'field_error',
              'reason': 'reason_error',
            },
          ),
        );
        // act
        final received = await quizRepository.update(quiz: quizRequest);
        // assert
        expect(received.fold((l) => l, (r) => r), expected);
      },
    );

    test(
      'return ServerFailure for a not mapped error',
      () async {
        // arrange
        when(() => dataSource.update(quiz: any(named: 'quiz')))
            .thenThrow(Exception());
        // act
        final received = await quizRepository.update(quiz: quizRequest);
        // assert
        expect(received.fold((l) => l, (r) => r), ServerFailure());
      },
    );

    group('start', () {
      test(
        'should call datasource start',
        () async {
          // arrange
          const quizSession = QuizSessionModel(
            sessionId: 'session_id',
          );
          when(() => dataSource.start(any()))
              .thenAnswer((_) async => quizSession);

          // act
          await quizRepository.start('session_id');

          // assert
          verify(() => dataSource.start('session_id')).called(1);
        },
      );

      test(
        'should return datasource start',
        () async {
          // arrange
          const quizSession = QuizSessionModel(
            sessionId: 'session_id',
          );
          when(() => dataSource.start(any()))
              .thenAnswer((_) async => quizSession);

          // act
          final result = await quizRepository.start('session_id');

          // assert
          expect(result, right(quizSession));
        },
      );

      test(
        'should return failure when datasource start throws',
        () async {
          // arrange
          when(() => dataSource.start(any())).thenThrow(Exception());

          // act
          final result = await quizRepository.start('session_id');

          // assert
          expect(result.isLeft(), isTrue);
        },
      );
    });

    group('send', () {
      late IQuizRepository sut;

      late Client mockClient;
      late IApiServerConfigure mockServerConfiguration;

      setUp(() {
        mockClient = _MockHttpClient();
        mockServerConfiguration = _MockApiServerConfigure();

        initModules(
          [
            AppModule(),
            QuizModule(),
          ],
          replaceBinds: [
            Bind.singleton<Client>((i) => mockClient),
            Bind<IApiServerConfigure>((i) => mockServerConfiguration),
            Bind<INetworkInfo>((i) => networkInfo),
          ],
        );

        sut = Modular.get<IQuizRepository>();

        when(() => mockServerConfiguration.baseUri)
            .thenReturn(Uri.parse('http://example.com'));
        when(() => mockServerConfiguration.userAgent)
            .thenAnswer((_) async => 'userAgent');
        when(() => mockServerConfiguration.apiToken)
            .thenAnswer((_) async => 'apiToken');
      });

      test(
        'given no quiz when send should return left',
        () async {
          // arrange
          final response = '{}';
          when(() => mockClient.post(any(), headers: any(named: 'headers')))
              .thenAnswer((_) async => Response(response, 200));

          // act
          final actual = await sut.send(
            quizId: '200',
            answer: UserAnswer(
              value: AnswerValue('1'),
              message: QuizMessage.button(reference: '', label: '', value: ''),
            ),
          );

          // assert
          expect(actual.isLeft(), isTrue);
          expect(actual.fold(id, id), isA<Failure>());
        },
      );

      test(
        'when send success should return right',
        () async {
          // arrange
          final response = JsonUtil.getStringSync(
            from: 'quiz/all-messages.json',
          );
          when(() => mockClient.post(any(), headers: any(named: 'headers')))
              .thenAnswer((_) async => Response(response, 200));

          // act
          final actual = await sut.send(
            quizId: '200',
            answer: UserAnswer(
              value: AnswerValue('1'),
              message: QuizMessage.button(reference: '', label: '', value: ''),
            ),
          );

          // assert
          expect(actual.isRight(), isTrue);
          expect(actual.fold(id, id), quizFixture);
        },
      );
    });
  });
}
