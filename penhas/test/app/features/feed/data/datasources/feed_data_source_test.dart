import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/feed/data/datasources/tweet_data_source.dart';
import 'package:penhas/app/features/feed/data/models/tweet_model.dart';
import 'package:penhas/app/features/feed/data/models/tweet_session_model.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_engage_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_request_option.dart';

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

  group('FeedDataSource', () {
    group('retrieve()', () {
      String bodyContent;
      TweetRequestOption requestOption;

      setUp(() async {
        bodyContent =
            JsonUtil.getStringSync(from: 'feed/retrieve_response.json');
        requestOption = TweetRequestOption();
      });

      test('should perform a GET with X-API-Key', () async {
        // arrange
        final endPointPath = '/timeline';
        final queryParameters = {
          'only_myself': '0',
          'skip_myself': '0',
          'rows': '100'
        };
        final headers = await _setUpHttpHeader();
        final request = _setuHttpRequest(endPointPath, queryParameters);
        _setUpMockGetHttpClientSuccess200(bodyContent);
        // act
        await dataSource.retrieve(option: requestOption);
        // assert
        verify(apiClient.get(request, headers: headers));
      });
      test('should get a valid TweetSession for a successful request',
          () async {
        // arrange
        _setUpMockGetHttpClientSuccess200(bodyContent);
        final jsonData =
            await JsonUtil.getJson(from: 'feed/retrieve_response.json');
        final expected = TweetSessionModel.fromJson(jsonData);
        // act
        final received = await dataSource.retrieve(option: requestOption);
        // assert
        expect(expected, received);
      });
    });
    group('report()', () {
      String bodyContent;
      TweetEngageRequestOption requestOption;

      setUp(() async {
        bodyContent = '{message: "Report enviado"}';
        requestOption = TweetEngageRequestOption(
          tweetId: '200520T0032210001',
          message: 'esse tweet me ofende pq XPTO',
        );
      });
      test('should perform a POST with X-API-Key', () async {
        // arrange
        final endPointPath = '/timeline/${requestOption.tweetId}/report';
        final queryParameters = {
          'reason': requestOption.message,
        };

        final headers = await _setUpHttpHeader();
        final request = _setuHttpRequest(endPointPath, queryParameters);
        _setUpMockPostHttpClientSuccess200(bodyContent);
        // act
        await dataSource.report(option: requestOption);
        // assert
        verify(apiClient.post(request, headers: headers));
      });
      test('should get a valid ValidField for a successful request', () async {
        // arrange
        _setUpMockPostHttpClientSuccess200(bodyContent);
        final expected = ValidField();
        // act
        final received = await dataSource.report(option: requestOption);
        // assert
        expect(expected, received);
      });
    });
    group('like()', () {
      String bodyContent;
      TweetEngageRequestOption requestOption;

      setUp(() async {
        bodyContent =
            JsonUtil.getStringSync(from: 'feed/tweet_like_response.json');
        requestOption = TweetEngageRequestOption(tweetId: '200520T0032210001');
      });
      test('should perform a POST with X-API-Key', () async {
        // arrange
        final endPointPath = '/timeline/${requestOption.tweetId}/like';
        final queryParameters = Map<String, String>();

        final headers = await _setUpHttpHeader();
        final request = _setuHttpRequest(endPointPath, queryParameters);
        _setUpMockPostHttpClientSuccess200(bodyContent);
        // act
        await dataSource.like(option: requestOption);
        // assert
        verify(apiClient.post(request, headers: headers));
      });
      test('should get a valid ValidField for a successful request', () async {
        // arrange
        _setUpMockPostHttpClientSuccess200(bodyContent);
        final jsonData =
            await JsonUtil.getJson(from: 'feed/tweet_like_response.json');
        final expected = TweetModel.fromJson(jsonData['tweet']);
        // act
        final received = await dataSource.like(option: requestOption);
        // assert
        expect(expected, received);
      });
    });
  });
}
