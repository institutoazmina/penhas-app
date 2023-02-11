import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/appstate/data/datasources/app_state_data_source.dart';
import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';

import '../../../../../utils/json_util.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockIApiServerConfigure extends Mock implements IApiServerConfigure {}

void main() {
  late String bodyContent;
  late http.Client apiClient;
  late IAppStateDataSource dataSource;
  late IApiServerConfigure serverConfigure;
  late When<Future<http.Response>> mockGetAction;
  final Uri serverEndpoint = Uri.https('api.anyserver.io', '/');

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    bodyContent =
        JsonUtil.getStringSync(from: 'profile/about_with_quiz_session.json');

    apiClient = MockHttpClient();
    serverConfigure = MockIApiServerConfigure();
    dataSource = AppStateDataSource(
      apiClient: apiClient,
      serverConfiguration: serverConfigure,
    );

    // MockApiServerConfigure configuration
    when(() => serverConfigure.baseUri).thenReturn(serverEndpoint);
    when(() => serverConfigure.apiToken)
        .thenAnswer((_) async => 'my.very.strong');
    when(() => serverConfigure.userAgent)
        .thenAnswer((_) async => 'iOS 11.4/Simulator/1.0.0');

    mockGetAction =
        when(() => apiClient.get(any(), headers: any(named: 'headers')));
  });

  Future<Map<String, String>> _setUpHttpHeader() async {
    final userAgent = await serverConfigure.userAgent;
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
    mockGetAction.thenAnswer(
      (_) async => http.Response(
        bodyContent,
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      ),
    );
  }

  void _setUpMockHttpClientFailedWithHttp({required int code}) {
    mockGetAction.thenAnswer(
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
        await dataSource.check();
        // assert
        verify(() => apiClient.get(loginUri, headers: headers)).called(1);
      },
    );
    test(
      'get AppStateModel for valid session',
      () async {
        // arrange
        _setUpMockHttpClientSuccess200();
        final jsonData = await JsonUtil.getJson(
            from: 'profile/about_with_quiz_session.json');
        final expected = AppStateModel.fromJson(jsonData);
        // act
        final result = await dataSource.check();
        // assert
        expect(result, expected);
      },
    );
    test(
      'get ApiProviderSessionError for invalid session',
      () async {
        // arrange
        final sessionHttpCodeError = [401];
        for (final httpCode in sessionHttpCodeError) {
          _setUpMockHttpClientFailedWithHttp(code: httpCode);
          // act
          // final sut = dataSource.check;
          // assert
          expect(
            () async => await dataSource.check(),
            throwsA(isA<ApiProviderSessionError>()),
          );
        }
      },
    );
  });
}
