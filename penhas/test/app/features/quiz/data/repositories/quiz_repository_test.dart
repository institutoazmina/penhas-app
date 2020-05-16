import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';
import 'package:penhas/app/features/quiz/data/datasources/quiz_data_source.dart';
import 'package:penhas/app/features/quiz/data/repositories/quiz_repository.dart';
import 'package:penhas/app/features/quiz/domain/entities/quiz_request_entity.dart';

import '../../../../../utils/json_util.dart';

class MockQuizDataSource extends Mock implements IQuizDataSource {}

class MockNetworkInfo extends Mock implements INetworkInfo {}

void main() {
  INetworkInfo networkInfo;
  IQuizDataSource dataSource;
  QuizRequestEntity quizRequest;
  QuizRepository quizRepository;

  Map<String, Object> jsonData;
  setUp(() async {
    networkInfo = MockNetworkInfo();
    dataSource = MockQuizDataSource();
    quizRepository = QuizRepository(
      dataSource: dataSource,
      networkInfo: networkInfo,
    );
    quizRequest = QuizRequestEntity(
      sessionId: 200,
      options: {'YN1': 'Y'},
    );
    jsonData =
        await JsonUtil.getJson(from: 'profile/quiz_session_response.json');
  });

  group('QuizRepository', () {
    test('should return a valid session for a valid update', () async {
      // arrange
      final expectedSession = AppStateModel.fromJson(jsonData);

      when(dataSource.update(quiz: anyNamed('quiz')))
          .thenAnswer((_) => Future.value(expectedSession));
      // act
      final receivedSession = await quizRepository.update(quiz: quizRequest);
      // assert
      expect(right(expectedSession), receivedSession);
    });

    test('should return ServerSideSessionFailed for a invalid session',
        () async {
      // arrange
      when(dataSource.update(quiz: anyNamed('quiz')))
          .thenThrow(ApiProviderSessionExpection());
      final expected = left(ServerSideSessionFailed());
      // act
      final received = await quizRepository.update(quiz: quizRequest);
      // assert
      expect(received, expected);
    });

    test('should return ServerSideSessionFailed for a invalid JWT', () async {
      // arrange
      when(dataSource.update(quiz: anyNamed('quiz'))).thenThrow(
        ApiProviderException(bodyContent: {
          "error": "expired_jwt",
          "nessage": "Bad request - Invalid JWT"
        }),
      );
      final expected = left(ServerSideSessionFailed());
      // act
      final received = await quizRepository.update(quiz: quizRequest);
      // assert
      expect(received, expected);
    });
  });
}
