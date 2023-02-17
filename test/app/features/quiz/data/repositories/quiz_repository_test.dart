import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';
import 'package:penhas/app/features/quiz/data/datasources/quiz_data_source.dart';
import 'package:penhas/app/features/quiz/data/repositories/quiz_repository.dart';
import 'package:penhas/app/features/quiz/domain/entities/quiz_request_entity.dart';

import '../../../../../utils/json_util.dart';

class MockNetworkInfo extends Mock implements INetworkInfo {}

class MockQuizDataSource extends Mock implements IQuizDataSource {}

void main() {
  late INetworkInfo networkInfo;
  late IQuizDataSource dataSource;
  late QuizRepository quizRepository;
  late QuizRequestEntity quizRequest;
  late Map<String, dynamic> jsonData;

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
  });
}
