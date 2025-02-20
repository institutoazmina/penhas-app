import 'package:dartz/dartz.dart' show id, right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';
import 'package:penhas/app/features/appstate/data/model/quiz_session_model.dart';
import 'package:penhas/app/features/quiz/data/repositories/quiz_repository.dart';
import 'package:penhas/app/features/quiz/domain/entities/answer.dart';
import 'package:penhas/app/features/quiz/domain/entities/quiz_message.dart';
import 'package:penhas/app/features/quiz/domain/entities/quiz_request_entity.dart';

import '../../../../../utils/api_provider_mock.dart';
import '../../../../../utils/json_util.dart';
import '../quiz_fixtures.dart';

void main() {
  late QuizRepository quizRepository;
  late QuizRequestEntity quizRequest;

  const sessionToken = 'my_really.long.JWT';

  setUp(() async {
    ApiProviderMock.init();

    final serverEndpoint = Uri.https('api.example.com', '/');
    quizRepository = QuizRepository(apiProvider: ApiProviderMock.apiProvider);
    quizRequest = const QuizRequestEntity(
      sessionId: '200',
      options: {'YN1': 'Y'},
    );

    // MockApiServerConfigure configuration
    when(() => ApiProviderMock.serverConfigure.baseUri)
        .thenAnswer((_) => serverEndpoint);
    when(() => ApiProviderMock.serverConfigure.apiToken)
        .thenAnswer((_) async => sessionToken);
    when(() => ApiProviderMock.serverConfigure.userAgent)
        .thenAnswer((_) async => 'iOS 11.4/Simulator/1.0.0');
  });

  void _setUpMockHttpClientResponse(String body, {int? statusCode}) {
    ApiProviderMock.apiClientResponse(body, statusCode ?? 200);
  }

  group(QuizRepository, () {
    group('update', () {
      test(
        'return ServerSideSessionFailed on invalid session',
        () async {
          // arrange
          _setUpMockHttpClientResponse('{}', statusCode: 401);
          // act
          final received = await quizRepository.update(quiz: quizRequest);
          // assert
          expect(received.fold((l) => l, (r) => r), ServerSideSessionFailed());
        },
      );

      test(
        'return ServerSideSessionFailed for an expired JWT',
        () async {
          // arrange
          final bodyContent =
              '{"error": "expired_jwt", "message": "Bad request - Invalid JWT"}';
          _setUpMockHttpClientResponse(bodyContent, statusCode: 404);
          // act
          final received = await quizRepository.update(quiz: quizRequest);
          // assert
          expect(received.fold((l) => l, (r) => r), ServerSideSessionFailed());
        },
      );

      test(
        'return ServerSideFormFieldValidationFailure when server returns a bad request',
        () async {
          // arrange
          final bodyContent =
              '{"error": "server_error", "message": "message_error", "field": "field_error", "reason": "reason_error"}';
          final expected = ServerSideFormFieldValidationFailure(
            error: 'server_error',
            message: 'message_error',
            field: 'field_error',
            reason: 'reason_error',
          );
          _setUpMockHttpClientResponse(bodyContent, statusCode: 400);
          // act
          final received = await quizRepository.update(quiz: quizRequest);
          // assert
          expect(received.fold((l) => l, (r) => r), expected);
        },
      );

      test(
        'should return expected session on successful quiz update',
        () async {
          // arrange
          final response = JsonUtil.getStringSync(
            from: 'profile/quiz_session_response.json',
          );
          final expectedSession = AppStateModel.fromJson(
            await JsonUtil.getJson(
              from: 'profile/quiz_session_response.json',
            ),
          );
          _setUpMockHttpClientResponse(response);
          // act
          final receivedSession =
              await quizRepository.update(quiz: quizRequest);
          // assert
          expect(receivedSession.fold((l) => l, (r) => r), expectedSession);
        },
      );
    });

    group('start', () {
      test(
        'return QuizSessionModel for valid session',
        () async {
          // arrange
          final response = JsonUtil.getStringSync(
            from: 'quiz/quiz_start_response.json',
          );
          const expectedQuiz = QuizSessionModel(sessionId: 'session_id');
          _setUpMockHttpClientResponse(response);
          // act
          final result = await quizRepository.start('quiz_session_id');
          // assert
          expect(result.fold(id, id), expectedQuiz);
        },
      );

      test(
        'return a left failure when HTTP response indicates error for start',
        () async {
          // arrange
          _setUpMockHttpClientResponse('{}', statusCode: 400);
          // act
          final result = await quizRepository.start('session_id');
          // assert
          expect(result.isLeft(), isTrue);
        },
      );
    });

    group('send', () {
      test(
        'return a Failure when no quiz is provided',
        () async {
          // arrange
          _setUpMockHttpClientResponse('{}');
          // act
          final actual = await quizRepository.send(
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
        'return expected quiz fixture when answer is sent successfully',
        () async {
          // arrange
          final response = JsonUtil.getStringSync(
            from: 'quiz/all-messages.json',
          );
          _setUpMockHttpClientResponse(response);
          // act
          final actual = await quizRepository.send(
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
