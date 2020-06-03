import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/feed/data/datasources/tweet_data_source.dart';
import 'package:penhas/app/features/feed/data/models/tweet_session_model.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_request_option.dart';

import '../../../../../utils/json_util.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockApiServerConfigure extends Mock implements IApiServerConfigure {}

void main() {
  MockHttpClient apiClient;
  ITweetDataSource dataSource;
  MockApiServerConfigure serverConfigure;
  String bodyContent;
  Uri serverEndpoint;
  TweetRequestOption requestOption;
  const String SESSSION_TOKEN = 'my_really.long.JWT';

  setUp(() async {
    apiClient = MockHttpClient();
    serverConfigure = MockApiServerConfigure();
    serverEndpoint = Uri.https('api.anyserver.io', '/');
    dataSource = TweetDataSource(
      apiClient: apiClient,
      serverConfiguration: serverConfigure,
    );

    requestOption = TweetRequestOption();
    bodyContent = JsonUtil.getStringSync(from: 'feed/retrieve_response.json');

    // MockApiServerConfigure configuration
    when(serverConfigure.baseUri).thenAnswer((_) => serverEndpoint);
    when(serverConfigure.apiToken)
        .thenAnswer((_) => Future.value(SESSSION_TOKEN));
    when(serverConfigure.userAgent)
        .thenAnswer((_) => Future.value("iOS 11.4/Simulator/1.0.0"));
  });

  Future<Map<String, String>> _setUpHttpHeader() async {
    final userAgent = await serverConfigure.userAgent;
    return {
      'X-Api-Key': SESSSION_TOKEN,
      'User-Agent': userAgent,
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
    };
  }

  Uri _setuHttpRequest(String path) {
    return Uri(
      scheme: serverEndpoint.scheme,
      host: serverEndpoint.host,
      path: path,
      queryParameters: {'only_myself': '0', 'skip_myself': '0', 'rows': '100'},
    );
  }

  PostExpectation<Future<http.Response>> _mockGetRequest() {
    return when(apiClient.get(
      any,
      headers: anyNamed('headers'),
    ));
  }

  void _setUpMockHttpClientSuccess200() {
    _mockGetRequest().thenAnswer(
      (_) async => http.Response(
        bodyContent,
        200,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'
        },
      ),
    );
  }

  group('FeedDataSource', () {
    group('retrieve()', () {
      test('should perform a GET with X-API-Key', () async {
        // arrange
        final headers = await _setUpHttpHeader();
        final request = _setuHttpRequest('/timeline');
        _setUpMockHttpClientSuccess200();
        // act
        await dataSource.retrieve(option: requestOption);
        // assert
        verify(apiClient.get(request, headers: headers));
      });
      test('should get a valid TweetSession', () async {
        // arrange
        _setUpMockHttpClientSuccess200();
        final jsonData =
            await JsonUtil.getJson(from: 'feed/retrieve_response.json');
        final expected = TweetSessionMondel.fromJson(jsonData);
        // act
        final received = await dataSource.retrieve(option: requestOption);
        // assert
        expect(expected, received);
      });
    });
  });
}
