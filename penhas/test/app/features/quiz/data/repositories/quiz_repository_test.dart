import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';
import 'package:penhas/app/features/quiz/data/repositories/quiz_repository.dart';
import 'package:penhas/app/features/quiz/domain/entities/quiz_request_entity.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

Future<bool> isConnected() => Future.value(true);

void main() {
  INetworkInfo networkInfo;
  IQuizDataSource? dataSource;
  QuizRequestEntity? quizRequest;
  late QuizRepository quizRepository;

  late Map<String, Object> jsonData;
  setUp(() async {
    quizRequest = const QuizRequestEntity(
      sessionId: '200',
      options: {'YN1': 'Y'},
    );
    jsonData =
        await JsonUtil.getJson(from: 'profile/quiz_session_response.json');
    when(networkInfo.isConnected).thenAnswer((_) => Future.value(true));
  });

  group('QuizRepository', () {
    test('should return a valid session for a valid update', () async {
      // arrange
      final expectedSession = AppStateModel.fromJson(jsonData);

      when(dataSource!.update(quiz: anyNamed('quiz')))
          .thenAnswer((_) => Future.value(expectedSession));
      // act
      final receivedSession = await quizRepository.update(quiz: quizRequest);
      // assert
      expect(right(expectedSession), receivedSession);
    });

    test('should return ServerSideSessionFailed for a invalid session',
        () async {
      // arrange
<<<<<<< HEAD
      when(dataSource.update(quiz: anyNamed('quiz')))
          .thenThrow(ApiProviderSessionError());
=======
      when(dataSource!.update(quiz: anyNamed('quiz')))
          .thenThrow(ApiProviderSessionExpection());
>>>>>>> Migrate code to nullsafety
      final expected = left(ServerSideSessionFailed());
      // act
      final received = await quizRepository.update(quiz: quizRequest);
      // assert
      expect(received, expected);
    });

    test('should return ServerSideSessionFailed for a invalid JWT', () async {
      // arrange
<<<<<<< HEAD
      when(dataSource.update(quiz: anyNamed('quiz'))).thenThrow(
        const ApiProviderException(
          bodyContent: {
            'error': 'expired_jwt',
            'nessage': 'Bad request - Invalid JWT'
          },
        ),
=======
      when(dataSource!.update(quiz: anyNamed('quiz'))).thenThrow(
        ApiProviderException(bodyContent: {
          "error": "expired_jwt",
          "nessage": "Bad request - Invalid JWT"
        }),
>>>>>>> Migrate code to nullsafety
      );
      final expected = left(ServerSideSessionFailed());
      // act
      final received = await quizRepository.update(quiz: quizRequest);
      // assert
      expect(received, expected);
    });
  });
}
