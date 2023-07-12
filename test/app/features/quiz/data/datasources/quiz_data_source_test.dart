import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';
import 'package:penhas/app/features/quiz/data/datasources/quiz_data_source.dart';
import 'package:penhas/app/features/quiz/domain/entities/quiz_request_entity.dart';

import '../../../../../utils/json_util.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockApiServerConfigure extends Mock implements IApiServerConfigure {}

void main() {
  late http.Client apiClient;
  late IQuizDataSource dataSource;
  late QuizRequestEntity quizRequest;
  late IApiServerConfigure serverConfigure;
  late String bodyContent;
  late Uri serverEndpoint;
  const sessionToken = 'my_really.long.JWT';

  setUp(() {
    apiClient = MockHttpClient();
    serverConfigure = MockApiServerConfigure();
    serverEndpoint = Uri.https('api.anyserver.io', '/');

    dataSource = QuizDataSource(
      apiClient: apiClient,
      serverConfiguration: serverConfigure,
    );

    quizRequest = const QuizRequestEntity(
      sessionId: '200',
      options: {'YN1': 'Y'},
    );
    bodyContent =
        JsonUtil.getStringSync(from: 'profile/quiz_session_response.json');

    // MockApiServerConfigure configuration
    when(() => serverConfigure.baseUri).thenAnswer((_) => serverEndpoint);
    when(() => serverConfigure.apiToken).thenAnswer((_) async => sessionToken);
    when(() => serverConfigure.userAgent)
        .thenAnswer((_) async => 'iOS 11.4/Simulator/1.0.0');
  });

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  Future<Map<String, String>> _setUpHttpHeader() async {
    final userAgent = await serverConfigure.userAgent;
    return {
      'X-Api-Key': sessionToken,
      'User-Agent': userAgent,
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
    };
  }

  Uri _setUpHttpRequest() {
    return Uri(
      scheme: serverEndpoint.scheme,
      host: serverEndpoint.host,
      path: '/me/quiz',
      queryParameters: {'session_id': '200', 'YN1': 'Y'},
    );
  }

  void _setUpMockHttpClientSuccess200() {
    when(
      () => apiClient.post(
        any(),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer(
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
    when(
      () => apiClient.post(
        any(),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        '{"status": $code, "error":"Some error message"}',
        code,
        headers: {'content-type': 'application/json; charset=utf-8'},
      ),
    );
  }

  group(QuizDataSource, () {
    test(
      'perform a POST with X-API-Key and application/json header ',
      () async {
        // arrange
        final headers = await _setUpHttpHeader();
        final loginUri = _setUpHttpRequest();
        _setUpMockHttpClientSuccess200();
        // act
        await dataSource.update(quiz: quizRequest);
        // assert
        verify(() => apiClient.post(loginUri, headers: headers));
      },
    );
    test(
      'get AppStateModel for valid session',
      () async {
        // arrange
        _setUpMockHttpClientSuccess200();
        final jsonData =
            await JsonUtil.getJson(from: 'profile/quiz_session_response.json');
        final expected = AppStateModel.fromJson(jsonData);
        // act
        final result = await dataSource.update(quiz: quizRequest);
        // assert
        expect(result, expected);
      },
    );
    test(
      'throw ApiProviderSessionError for invalid session',
      () async {
        // arrange
        final sessionHttpCodeError = [401, 403];
        for (final httpCode in sessionHttpCodeError) {
          _setUpMockHttpClientFailedWithHttp(code: httpCode);
          // act
          final sut = dataSource.update;
          // assert
          expect(
            () async => sut(quiz: quizRequest),
            throwsA(isA<ApiProviderSessionError>()),
          );
        }
      },
    );
    test('throw ApiProviderException from a server error', () async {
      // arrange
      _setUpMockHttpClientFailedWithHttp(code: 500);
      // act
      final sut = dataSource.update;
      // assert
      expect(
        () async => sut(quiz: quizRequest),
        throwsA(isA<ApiProviderException>()),
      );
    });
    test('propagates exception from drivers', () async {
      // arrange
      when(
        () => apiClient.post(
          any(),
          headers: any(named: 'headers'),
        ),
      ).thenThrow(Exception());
      // act
      final sut = dataSource.update;
      // assert
      expect(
        () async => await sut(quiz: quizRequest),
        throwsA(isA<Exception>()),
      );
    });
  });
}
