import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/feed/data/datasources/tweet_data_source.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_engage_request_option.dart';

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

  void _setUpMockPostHttpClientSuccess200(String? bodyContent) {
    when(
      () => apiClient.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
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
    group('report()', () {
      String? bodyContent;
      TweetEngageRequestOption? requestOption;

      setUp(() {
        bodyContent = '{"message": "Report enviado"}';
        requestOption = TweetEngageRequestOption(
          tweetId: '200520T0032210001',
          message: 'esse tweet me ofende pq XPTO',
        );
      });
      test(
        'perform a POST with X-API-Key',
        () async {
          // arrange
          final endPointPath = '/timeline/${requestOption!.tweetId}/report';

          final headers = await _setUpHttpHeader();
          final request = _setUpHttpRequest(endPointPath, {});
          _setUpMockPostHttpClientSuccess200(bodyContent);
          // act
          await dataSource.report(option: requestOption);
          // assert
          verify(
            () => apiClient.post(
              request,
              headers: headers,
              body: 'reason=esse%20tweet%20me%20ofende%20pq%20XPTO',
            ),
          );
        },
      );
      test(
        'get a valid ValidField for a successful request',
        () async {
          // arrange
          _setUpMockPostHttpClientSuccess200(bodyContent);
          const expected = ValidField(message: 'Report enviado');
          // act
          final received = await dataSource.report(option: requestOption);
          // assert
          expect(expected, received);
        },
      );
    });
  });
}
