import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/features/appstate/data/datasources/app_state_data_source.dart';
import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

void main() {
  late final MockHttpClient apiClient = MockHttpClient();
  late final MockIApiServerConfigure serverConfigure =
      MockIApiServerConfigure();
  late String bodyContent;
  final Uri serverEndpoint = Uri.https('api.anyserver.io', '/');
  late final IAppStateDataSource dataSource = AppStateDataSource(
    apiClient: apiClient,
    serverConfiguration: serverConfigure,
  );

  setUp(() {
    bodyContent =
        JsonUtil.getStringSync(from: 'profile/about_with_quiz_session.json');

    // MockApiServerConfigure configuration
    when(serverConfigure.baseUri).thenAnswer((_) => serverEndpoint);
    when(serverConfigure.apiToken)
        .thenAnswer((_) => Future.value('my.very.strong'));
    when(serverConfigure.userAgent)
        .thenAnswer((_) => Future.value('iOS 11.4/Simulator/1.0.0'));
  });

  Future<Map<String, String>> _setUpHttpHeader() async {
    final userAgent = await serverConfigure.userAgent;
    return {
      'User-Agent': userAgent,
      'Content-Type': 'application/json; charset=utf-8',
      'X-Api-Key': 'my.very.strong',
    };
  }

  Uri _setuHttpRequest() {
    return Uri(
      scheme: serverEndpoint.scheme,
      host: serverEndpoint.host,
      path: '/me',
    );
  }

  PostExpectation<Future<http.Response>> _mockRequest() {
    return when(
      apiClient.get(
        any,
        headers: anyNamed('headers'),
      ),
    );
  }

  void _setUpMockHttpClientSuccess200() {
    _mockRequest().thenAnswer(
      (_) async => http.Response(
        bodyContent,
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
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

  group('AppStateDataSource', () {
    test('should perform a GET with X-API-Key and application/json header ',
        () async {
      // arrange
      final headers = await _setUpHttpHeader();
      final loginUri = _setuHttpRequest();
      _setUpMockHttpClientSuccess200();
      // act
      await dataSource.check();
      // assert
      verify(apiClient.get(loginUri, headers: headers));
    });
    test('should get AppStateModel for valid session', () async {
      // arrange
      _setUpMockHttpClientSuccess200();
      final jsonData =
          await JsonUtil.getJson(from: 'profile/about_with_quiz_session.json');
      final expected = AppStateModel.fromJson(jsonData);
      // act
      final result = await dataSource.check();
      // assert
      expect(result, expected);
    });
    test('should get ApiProviderSessionExpection for invalid session',
        () async {
      // arrange
      final sessionHttpCodeError = [401, 403];
      for (final httpCode in sessionHttpCodeError) {
        _setUpMockHttpClientFailedWithHttp(code: httpCode);
        // act
        final sut = dataSource.check;
        // assert
        expect(
          () => sut(),
          throwsA(isA<ApiProviderSessionError>()),
        );
      }
    });
  });
}
