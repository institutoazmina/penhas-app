import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/feed/data/datasources/tweet_data_source.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_engage_request_option.dart';

import '../../../../../utils/json_util.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockApiServerConfigure extends Mock implements IApiServerConfigure {}

void main() {
  MockHttpClient apiClient;
  ITweetDataSource dataSource;
  MockApiServerConfigure serverConfigure;
  Uri serverEndpoint;
  const String SESSSION_TOKEN = 'my_really.long.JWT';

  setUp(() async {
    apiClient = MockHttpClient();
    serverConfigure = MockApiServerConfigure();
    serverEndpoint = Uri.https('api.anyserver.io', '/');
    dataSource = TweetDataSource(
      apiClient: apiClient,
      serverConfiguration: serverConfigure,
    );

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

  Uri _setuHttpRequest(String path, Map<String, String> queryParameters) {
    return Uri(
      scheme: serverEndpoint.scheme,
      host: serverEndpoint.host,
      path: path,
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    );
  }

  PostExpectation<Future<http.Response>> _mockGetRequest() {
    return when(apiClient.get(
      any,
      headers: anyNamed('headers'),
    ));
  }

  PostExpectation<Future<http.Response>> _mockPostRequest() {
    return when(apiClient.post(
      any,
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    ));
  }

  void _setUpMockGetHttpClientSuccess200(String bodyContent) {
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

  void _setUpMockPostHttpClientSuccess200(String bodyContent) {
    _mockPostRequest().thenAnswer(
      (_) async => http.Response(
        bodyContent,
        200,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'
        },
      ),
    );
  }

  void _setUpMockPostHttpClientSuccess204() {
    when(
      apiClient.delete(
        any,
        headers: anyNamed('headers'),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        '',
        204,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'
        },
      ),
    );
  }

  group('FeedDataSource', () {
    group('reply()', () {
      String bodyContent;
      TweetEngageRequestOption requestOption;

      setUp(() async {
        bodyContent =
            JsonUtil.getStringSync(from: 'feed/tweet_create_response.json');
        requestOption = TweetEngageRequestOption(
          tweetId: '200528T2055370004',
          message: 'um breve comentario',
        );
      });
      test('should perform a POST with X-API-Key', () async {
        // arrange
        final endPointPath = '/timeline/${requestOption.tweetId}/comment';
        final bodyContent = Uri.encodeComponent('um breve comentario');

        final headers = await _setUpHttpHeader();
        final request = _setuHttpRequest(endPointPath, {});
        _setUpMockPostHttpClientSuccess200(bodyContent);
        // act
        await dataSource.reply(option: requestOption);
        // assert
        verify(
          apiClient.post(
            request,
            headers: headers,
            body: 'content=um%20breve%20comentario',
          ),
        );
      });
      test('should get a valid ValidField for a successful request', () async {
        // arrange
        _setUpMockPostHttpClientSuccess200(bodyContent);
        final expected = ValidField();
        // act
        final received = await dataSource.reply(option: requestOption);
        // assert
        expect(expected, received);
      });
    });
  });
}
