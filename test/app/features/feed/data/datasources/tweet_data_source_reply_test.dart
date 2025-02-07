import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/feed/data/datasources/tweet_data_source.dart';
import 'package:penhas/app/features/feed/data/models/tweet_model.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_engage_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';

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

  void _setUpMockHttpClientError(int statusCode) {
    final bodyContent = JsonUtil.getStringSync(
      from: 'feed/invalid_request.json',
    );

    when(
      () => apiClient.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        bodyContent,
        statusCode,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'
        },
      ),
    );
  }

  group(TweetDataSource, () {
    group('reply()', () {
      String? bodyContent;
      TweetEngageRequestOption? requestOption;

      setUp(() {
        bodyContent =
            JsonUtil.getStringSync(from: 'feed/tweet_reply_response.json');
        requestOption = TweetEngageRequestOption(
          tweetId: '200528T2055370004',
          message: 'um breve comentario',
        );
      });
      test(
        'perform a POST with X-API-Key',
        () async {
          // arrange
          final endPointPath = '/timeline/${requestOption!.tweetId}/comment';
          final bodyRequest = Uri.encodeComponent('um breve comentario');
          final headers = await _setUpHttpHeader();
          final request = _setUpHttpRequest(endPointPath, {});
          _setUpMockPostHttpClientSuccess200(bodyContent);
          // act
          await dataSource.reply(option: requestOption);
          // assert
          verify(
            () => apiClient.post(
              request,
              headers: headers,
              body: 'content=$bodyRequest',
            ),
          ).called(1);
        },
      );
      test(
        'get a valid ValidField for a successful request',
        () async {
          // arrange
          _setUpMockPostHttpClientSuccess200(bodyContent);
          final expected = TweetModel(
            id: '200608T1809090001',
            userName: 'rosa',
            clientId: 551,
            createdAt: '2020-06-08 18:09:09',
            totalReply: 0,
            totalLikes: 0,
            anonymous: false,
            content: 'um breve comentario',
            avatar: 'https://elasv2-api.appcivico.com/avatar/padrao.svg',
            meta: const TweetMeta(liked: false, owner: true),
            lastReply: const [],
            badges: [],
          );
          // act
          final received = await dataSource.reply(option: requestOption);
          // assert
          expect(expected, received);
        },
      );

      test(
        'throw an ApiProviderSessionError for an invalid session',
        () async {
          // arrange
          _setUpMockHttpClientError(401);

          // assert
          expect(
            () async => await dataSource.reply(option: requestOption),
            throwsA(isA<ApiProviderSessionError>()),
          );
        },
      );

      test(
        'throw an ApiProviderException for an invalid session',
        () async {
          // arrange
          _setUpMockHttpClientError(501);

          // assert
          expect(
            () async => await dataSource.reply(option: requestOption),
            throwsA(isA<ApiProviderException>()),
          );
        },
      );
    });
  });
}
