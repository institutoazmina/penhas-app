import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/feed/data/datasources/tweet_data_source.dart';
import 'package:penhas/app/features/feed/data/models/tweet_session_model.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_request_option.dart';

import '../../../../../utils/json_util.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockApiServerConfigure extends Mock implements IApiServerConfigure {}

void main() {
  late Uri serverEndpoint;
  late http.Client apiClient;
  late ITweetDataSource dataSource;
  late IApiServerConfigure serverConfigure;
  const String sessionToken = 'my_really.long.JWT';

  setUp(() {
    apiClient = MockHttpClient();
    serverConfigure = MockApiServerConfigure();
    serverEndpoint = Uri.https('api.anyserver.io', '/');
    dataSource = TweetDataSource(
      apiClient: apiClient,
      serverConfiguration: serverConfigure,
    );

    dataSource = TweetDataSource(
      apiClient: apiClient,
      serverConfiguration: serverConfigure,
    );

    // MockApiServerConfigure configuration
    when(() => serverConfigure.baseUri).thenAnswer((_) => serverEndpoint);
    when(() => serverConfigure.apiToken)
        .thenAnswer((_) => Future.value(sessionToken));
    when(() => serverConfigure.userAgent)
        .thenAnswer((_) => Future.value('iOS 11.4/Simulator/1.0.0'));
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

  Uri _setUpHttpRequest(String path, Map<String, String> queryParameters) {
    return Uri(
      scheme: serverEndpoint.scheme,
      host: serverEndpoint.host,
      path: path,
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    );
  }

  void _setUpMockGetHttpClientSuccess200(String? bodyContent) {
    when(
      () => apiClient.get(
        any(),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        bodyContent!,
        200,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'
        },
      ),
    );
  }

  group(TweetDataSource, () {
    group('fetch()', () {
      String? bodyContent;
      TweetRequestOption? requestOption;

      setUp(() {
        bodyContent =
            JsonUtil.getStringSync(from: 'feed/retrieve_response.json');
        requestOption = const TweetRequestOption();
      });

      test(
        'perform a GET with X-API-Key',
        () async {
          // arrange
          const endPointPath = '/timeline';
          final queryParameters = {
            'rows': '100',
          };
          final headers = await _setUpHttpHeader();
          final request = _setUpHttpRequest(endPointPath, queryParameters);
          _setUpMockGetHttpClientSuccess200(bodyContent);
          // act
          await dataSource.fetch(option: requestOption);
          // assert
          verify(() => apiClient.get(request, headers: headers));
        },
      );
      test(
        'get a valid TweetSession for a successful request',
        () async {
          // arrange
          _setUpMockGetHttpClientSuccess200(bodyContent);
          final jsonData =
              await JsonUtil.getJson(from: 'feed/retrieve_response.json');
          final expected = TweetSessionModel.fromJson(jsonData);
          // act
          final received = await dataSource.fetch(option: requestOption);
          // assert
          expect(expected, received);
        },
      );
    });
  });
}
