import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/feed/data/datasources/tweet_data_source.dart';
import 'package:penhas/app/features/feed/data/models/tweet_model.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_engage_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

void main() {
  late final MockHttpClient apiClient = MockHttpClient();
  late ITweetDataSource dataSource;
  late final MockIApiServerConfigure serverConfigure = MockIApiServerConfigure();
  Uri? serverEndpoint;
  const String SESSSION_TOKEN = 'my_really.long.JWT';

  setUp(() {
    serverEndpoint = Uri.https('api.anyserver.io', '/');
    dataSource = TweetDataSource(
      apiClient: apiClient,
      serverConfiguration: serverConfigure,
    );

    // MockApiServerConfigure configuration
    when(serverConfigure.baseUri).thenAnswer((_) => serverEndpoint!);
    when(serverConfigure.apiToken)
        .thenAnswer((_) => Future.value(SESSSION_TOKEN));
    when(serverConfigure.userAgent)
        .thenAnswer((_) => Future.value('iOS 11.4/Simulator/1.0.0'));
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
      scheme: serverEndpoint!.scheme,
      host: serverEndpoint!.host,
      path: path,
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    );
  }

  PostExpectation<Future<http.Response>> _mockPostRequest() {
    return when(apiClient.post(
      any,
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    ),);
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
    group('create()', () {
      String? bodyContent;
      TweetCreateRequestOption? requestOption;

      setUp(() {
        bodyContent =
            JsonUtil.getStringSync(from: 'feed/tweet_create_response.json');
        requestOption = TweetCreateRequestOption(
          message: 'Mensagem 1',
        );
      });
      test('should perform a POST with X-API-Key', () async {
        // arrange
        const endPointPath = '/me/tweets';
        final bodyRequest = Uri.encodeComponent(requestOption!.message!);
        final headers = await _setUpHttpHeader();
        final request = _setuHttpRequest(endPointPath, {});
        _setUpMockPostHttpClientSuccess200(bodyContent);
        // act
        await dataSource.create(option: requestOption);
        // assert
        verify(
          apiClient.post(
            request,
            headers: headers,
            body: 'content=$bodyRequest',
          ),
        );
      });
      test('should get a valid ValidField for a successful request', () async {
        // arrange
        _setUpMockPostHttpClientSuccess200(bodyContent);
        final expected = TweetModel(
            id: '200608T1805540001',
            userName: 'maria',
            clientId: 424,
            createdAt: '2020-06-08 18:05:54',
            totalReply: 0,
            totalLikes: 0,
            anonymous: false,
            content: 'Mensagem 1',
            avatar: 'https://elasv2-api.appcivico.com/avatar/padrao.svg',
            meta: const TweetMeta(liked: false, owner: true),
            lastReply: const [],);
        // act
        final received = await dataSource.create(option: requestOption);
        // assert
        expect(expected, received);
      });
    });
  });
}
