import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';
import 'package:penhas/app/features/quiz/data/datasources/quiz_data_source.dart';
import 'package:penhas/app/features/quiz/domain/entities/quiz_request_entity.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

void main() {
  late final MockHttpClient apiClient = MockHttpClient();
  late final MockIApiServerConfigure serverConfigure = MockIApiServerConfigure();
  late IQuizDataSource dataSource;
  QuizRequestEntity? quizRequest;
  late String bodyContent;
  final Uri serverEndpoint = Uri.https('api.anyserver.io', '/');
  const String SESSSION_TOKEN = 'my_really.long.JWT';

  setUp(() {
    dataSource = QuizDataSource(
      apiClient: apiClient,
      serverConfiguration: serverConfigure,
    );

    quizRequest = QuizRequestEntity(
      sessionId: '200',
      options: const {'YN1': 'Y'},
    );
    bodyContent =
        JsonUtil.getStringSync(from: 'profile/quiz_session_response.json');

    // MockApiServerConfigure configuration
    when(serverConfigure.baseUri).thenAnswer((_) => serverEndpoint);
    when(serverConfigure.apiToken)
        .thenAnswer((_) => Future.value(SESSSION_TOKEN));
    when(serverConfigure.userAgent)
        .thenAnswer((_) => Future.value('iOS 11.4/Simulator/1.0.0'));
  });

  Future<Map<String, String>> _setUpHttpHeader() async {
    final userAgent = await serverConfigure.userAgent;
    return {
      'X-Api-Key': SESSSION_TOKEN,
      'User-Agent': userAgent,
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
    };
  }

  Uri _setuHttpRequest() {
    return Uri(
      scheme: serverEndpoint.scheme,
      host: serverEndpoint.host,
      path: '/me/quiz',
      queryParameters: {'session_id': '200', 'YN1': 'Y'},
    );
  }

  PostExpectation<Future<http.Response>> _mockRequest() {
    return when(apiClient.post(
      any,
      headers: anyNamed('headers'),
    ),);
  }

  void _setUpMockHttpClientSuccess200() {
    _mockRequest().thenAnswer(
      (_) async => http.Response(
        bodyContent,
        200,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'
        },
      ),
    );
  }

  void _setUpMockHttpClientFailedWithHttp({required int code}) {
    _mockRequest().thenAnswer(
      (_) async => http.Response(
        '{"status": $code, "error":"Some error messsage"}',
        code,
        headers: {'content-type': 'application/json; charset=utf-8'},
      ),
    );
  }

  group('QuizDataSource', () {
    test('should perform a POST with X-API-Key and application/json header ',
        () async {
      // arrange
      final headers = await _setUpHttpHeader();
      final loginUri = _setuHttpRequest();
      _setUpMockHttpClientSuccess200();
      // act
      await dataSource.update(quiz: quizRequest);
      // assert
      verify(apiClient.post(loginUri, headers: headers));
    });
    test('should get AppStateModel for valid session', () async {
      // arrange
      _setUpMockHttpClientSuccess200();
      final jsonData =
          await JsonUtil.getJson(from: 'profile/quiz_session_response.json');
      final expected = AppStateModel.fromJson(jsonData);
      // act
      final result = await dataSource.update(quiz: quizRequest);
      // assert
      expect(result, expected);
    });
    test('should get ApiProviderSessionExpection for invalid session',
        () async {
      // arrange
      final sessionHttpCodeError = [401, 403];
      for (var httpCode in sessionHttpCodeError) {
        _setUpMockHttpClientFailedWithHttp(code: httpCode);
        // act
        final sut = dataSource.update;
        // assert
        expect(
          () async => await sut(quiz: quizRequest),
          throwsA(isA<ApiProviderSessionError>()),
        );
      }
    });
  });
}
