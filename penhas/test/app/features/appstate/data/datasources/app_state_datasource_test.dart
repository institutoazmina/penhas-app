import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/appstate/data/datasources/app_state_data_source.dart';

import '../../../../../utils/json_util.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockApiServerConfigure extends Mock implements IApiServerConfigure {}

void main() {
  MockHttpClient apiClient;
  IAppStateDataSource dataSource;
  MockApiServerConfigure serverConfigure;
  String bodyContent;
  Uri serverEndpoint;

  setUp(() async {
    apiClient = MockHttpClient();
    serverConfigure = MockApiServerConfigure();
    serverEndpoint = Uri.https('api.anyserver.io', '/');
    dataSource = AppStateDataSource(
      apliClient: apiClient,
      serverConfiguration: serverConfigure,
    );
    bodyContent =
        JsonUtil.getStringSync(from: 'profile/about_with_quiz_session.json');

    // MockApiServerConfigure configuration
    when(serverConfigure.baseUri).thenAnswer((_) => serverEndpoint);
    when(serverConfigure.apiToken)
        .thenAnswer((_) => Future.value('my.very.strong'));
    when(serverConfigure.userAgent)
        .thenAnswer((_) => Future.value("iOS 11.4/Simulator/1.0.0"));
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

  void _setUpMockHttpClientSuccess200() {
    when(apiClient.post(
      any,
      headers: anyNamed('headers'),
    )).thenAnswer((_) async => http.Response(bodyContent, 200));
  }

  group('AppStateDataSource', () {
    test(
        'should should perform a GET with X-API-Key and application/json header ',
        () async {
      // arrange
      _setUpMockHttpClientSuccess200();
      // act
      final headers = await _setUpHttpHeader();
      final loginUri = _setuHttpRequest();
      await dataSource.check();

      // assert
      verify(apiClient.get(loginUri, headers: headers));
    });
  });
}

//
// Content-Type: application/json; charset=utf-8
