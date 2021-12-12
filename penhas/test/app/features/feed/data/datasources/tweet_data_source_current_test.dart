import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:penhas/app/features/feed/data/datasources/tweet_data_source.dart';
import 'package:penhas/app/features/feed/data/models/tweet_session_model.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_engage_request_option.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

void main() {
  MockHttpClient? apiClient;
  late ITweetDataSource dataSource;
  MockApiServerConfigure? serverConfigure;
  Uri? serverEndpoint;
  const String SESSSION_TOKEN = 'my_really.long.JWT';

  setUp(() {
    serverEndpoint = Uri.https('api.anyserver.io', '/');
    dataSource = TweetDataSource(
      apiClient: apiClient,
      serverConfiguration: serverConfigure,
    );

    // MockApiServerConfigure configuration
    when(serverConfigure!.baseUri).thenAnswer(((_) => serverEndpoint!) as Uri Function(Invocation));
    when(serverConfigure!.apiToken)
        .thenAnswer((_) => Future.value(SESSSION_TOKEN));
    when(serverConfigure!.userAgent)
        .thenAnswer((_) => Future.value("iOS 11.4/Simulator/1.0.0"));
  });

  Future<Map<String, String>> _setUpHttpHeader() async {
    final userAgent = await serverConfigure!.userAgent;
    return {
      'X-Api-Key': sessionToken,
      'User-Agent': userAgent,
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
    };
  }

  Uri _setuHttpRequest(String path, Map<String, String> queryParameters) {
    return Uri(
      scheme: serverEndpoint!.scheme,
      host: serverEndpoint!.host,
      path: path,
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    );
  }

  PostExpectation<Future<http.Response>> _mockGetRequest() {
    return when(apiClient!.get(
      any,
      headers: anyNamed('headers'),
    ));
  }

  void _setUpMockGetHttpClientSuccess200(String? bodyContent) {
    _mockGetRequest().thenAnswer(
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
    group('current()', () {
      String? bodyContent;
      TweetEngageRequestOption? requestOption;

      setUp(() {
        bodyContent =
            JsonUtil.getStringSync(from: 'feed/tweet_current_response.json');
        requestOption = TweetEngageRequestOption(tweetId: '200608T1545460001');
      });

      test('should perform a GET with X-API-Key', () async {
        // arrange
        const endPointPath = '/timeline';
        final queryParameters = {
          'id': '200608T1545460001',
        };
        final headers = await _setUpHttpHeader();
        final request = _setuHttpRequest(endPointPath, queryParameters);
        _setUpMockGetHttpClientSuccess200(bodyContent);
        // act
        await dataSource.current(option: requestOption);
        // assert
        verify(apiClient!.get(request, headers: headers));
      });
      test('should get a valid TweetSession for a successful request',
          () async {
        // arrange
        _setUpMockGetHttpClientSuccess200(bodyContent);
        final jsonData =
            await JsonUtil.getJson(from: 'feed/tweet_current_response.json');
        final expected = TweetSessionModel.fromJson(jsonData);
        // act
        final received = await dataSource.current(option: requestOption);
        // assert
        expect(expected, received);
      });
    });
  });
}
