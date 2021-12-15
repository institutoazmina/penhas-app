import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:penhas/app/features/feed/data/datasources/tweet_data_source.dart';
import 'package:penhas/app/features/feed/data/models/tweet_model.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_engage_request_option.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

void main() {
  late MockHttpClient apiClient = MockHttpClient();
  late MockIApiServerConfigure serverConfigure = MockIApiServerConfigure();
  late ITweetDataSource dataSource;
  final Uri serverEndpoint = Uri.https('api.anyserver.io', '/');
  const String SESSSION_TOKEN = 'my_really.long.JWT';

  setUp(() {
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
      'X-Api-Key': sessionToken,
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

  PostExpectation<Future<http.Response>> _mockPostRequest() {
    return when(apiClient.post(
      any,
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    ));
  }

  void _setUpMockPostHttpClientSuccess200(String? bodyContent) {
    _mockPostRequest().thenAnswer(
      (_) async => http.Response(
        bodyContent!,
        200,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'
        },
      ),
    );
  }

  group('FeedDataSource', () {
    group('dislike()', () {
      String? bodyContent;
      TweetEngageRequestOption? requestOption;

      setUp(() {
        bodyContent =
            JsonUtil.getStringSync(from: 'feed/tweet_like_response.json');
        requestOption = TweetEngageRequestOption(
          tweetId: '200520T0032210001',
          dislike: true,
        );
      });
      test('should perform a POST with X-API-Key', () async {
        // arrange
        final endPointPath = '/timeline/${requestOption!.tweetId}/like';
        final queryParameters = {'remove': '1'};

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
        final expected =
            TweetModel.fromJson(jsonData['tweet'] as Map<String, dynamic>);
        // act
        final received = await dataSource.like(option: requestOption);
        // assert
        expect(expected, received);
      });
    });
  });
}
