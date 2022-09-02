import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/features/feed/data/datasources/tweet_data_source.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_engage_request_option.dart';

import '../../../../../utils/helper.mocks.dart';

void main() {
  late final MockHttpClient apiClient = MockHttpClient();
  late final MockIApiServerConfigure serverConfigure =
      MockIApiServerConfigure();
  final Uri serverEndpoint = Uri.https('api.anyserver.io', '/');
  late ITweetDataSource dataSource;

  const String sessionToken = 'my_really.long.JWT';

  setUp(() {
    dataSource = TweetDataSource(
      apiClient: apiClient,
      serverConfiguration: serverConfigure,
    );

    // MockApiServerConfigure configuration
    when(serverConfigure.baseUri).thenAnswer((_) => serverEndpoint);
    when(serverConfigure.apiToken)
        .thenAnswer((_) => Future.value(sessionToken));
    when(serverConfigure.userAgent)
        .thenAnswer((_) => Future.value('iOS 11.4/Simulator/1.0.0'));
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
    group('delete()', () {
      TweetEngageRequestOption? requestOption;

      setUp(() {
        requestOption = TweetEngageRequestOption(tweetId: '200528T2055370004');
      });

      test('should perform a DELETE with X-API-Key', () async {
        // arrange
        const endPointPath = '/me/tweets';
        final queryParameters = {'id': requestOption!.tweetId};
        final headers = await _setUpHttpHeader();
        final request = _setuHttpRequest(endPointPath, queryParameters);
        _setUpMockPostHttpClientSuccess204();
        // act
        await dataSource.delete(option: requestOption);
        // assert
        verify(apiClient.delete(request, headers: headers));
      });

      test('should get a valid ValidField for a successful delete', () async {
        // arrange
        _setUpMockPostHttpClientSuccess204();
        const expected = ValidField();
        // act
        final received = await dataSource.delete(option: requestOption);
        // assert
        expect(expected, received);
      });
    });
  });
}
