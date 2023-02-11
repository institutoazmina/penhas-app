import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/appstate/data/datasources/app_state_data_source.dart';

import '../../../../../utils/json_util.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockApiServerConfigure extends Mock implements IApiServerConfigure {}

void main() {
  late String bodyContent;
  late Uri serverEndpoint;
  late http.Client apiClient;
  late IApiServerConfigure serverConfiguration;
  late IAppStateDataSource sut;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    apiClient = MockHttpClient();
    serverConfiguration = MockApiServerConfigure();
    serverEndpoint = Uri.https('api.anyserver.io', '/');

    sut = AppStateDataSource(
      apiClient: apiClient,
      serverConfiguration: serverConfiguration,
    );

    bodyContent =
        JsonUtil.getStringSync(from: 'profile/about_with_quiz_session.json');

    when(() => serverConfiguration.userAgent)
        .thenAnswer((_) async => 'iOS 11.4/Simulator/1.0.0');
    when(() => serverConfiguration.apiToken)
        .thenAnswer((_) async => 'my.very.strong');
    when(() => serverConfiguration.baseUri).thenReturn(serverEndpoint);
  });

  Future<Map<String, String>> _setUpHttpHeader() async {
    final userAgent = await serverConfiguration.userAgent;
    return {
      'User-Agent': userAgent,
      'Content-Type': 'application/json; charset=utf-8',
      'X-Api-Key': 'my.very.strong',
    };
  }

  Uri _setupHttpRequest() {
    return Uri(
      scheme: serverEndpoint.scheme,
      host: serverEndpoint.host,
      path: '/me',
    );
  }

  void _setUpMockHttpClientSuccess200() {
    when(() => apiClient.get(any(), headers: any(named: 'headers'))).thenAnswer(
      (_) async => http.Response(
        bodyContent,
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      ),
    );
  }

  void _setUpMockHttpClientFailedWithHttp({required int code}) {
    when(() => apiClient.get(any(), headers: any(named: 'headers'))).thenAnswer(
      (_) async => http.Response(
        '{"status": $code, "error":"Some error message"}',
        code,
        headers: {'content-type': 'application/json; charset=utf-8'},
      ),
    );
  }

  group(AppStateDataSource, () {
    test(
      'perform a GET with X-API-Key and application/json header ',
      () async {
        // arrange
        final headers = await _setUpHttpHeader();
        final loginUri = _setupHttpRequest();
        _setUpMockHttpClientSuccess200();
        // act
        await sut.check();
        // assert
        verify(() => apiClient.get(loginUri, headers: headers)).called(1);
      },
    );

    test('get ApiProviderSessionError for invalid session', () {
      // arrange
      final sessionHttpCodeError = [401, 403];
      for (final httpCode in sessionHttpCodeError) {
        _setUpMockHttpClientFailedWithHttp(code: httpCode);
        // act
        expect(
          () async => await sut.check(),
          throwsA(isA<ApiProviderSessionError>()),
        );
      }
    });

    test('get ApiProviderException for http code error not mapped', () {
      // arrange
      _setUpMockHttpClientFailedWithHttp(code: 503);
      // act
      expect(
        () async => await sut.check(),
        throwsA(isA<ApiProviderException>()),
      );
    });
  });
}
