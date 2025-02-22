import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/features/feed/data/models/tweet_model.dart';
import 'package:penhas/app/features/feed/data/models/tweet_session_model.dart';
import 'package:penhas/app/features/feed/data/repositories/tweet_repository.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_engage_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_request_option.dart';
import 'package:penhas/app/features/feed/domain/repositories/i_tweet_repositories.dart';

import '../../../../../utils/api_provider_mock.dart';
import '../../../../../utils/json_util.dart';

void main() {
  late ITweetRepository repository;
  const contentType = 'application/x-www-form-urlencoded; charset=utf-8';

  setUp(() {
    ApiProviderMock.init();

    repository = TweetRepository(apiProvider: ApiProviderMock.apiProvider);
  });

  void _setUpMockHttpClientResponse(String body, {int? statusCode}) {
    ApiProviderMock.apiClientResponse(body, statusCode ?? 200);
  }

  group(TweetRepository, () {
    test(
      'create a tweet and return TweetModel when the session is valid',
      () async {
        // arrange
        final jsonFile = 'feed/tweet_create_response.json';
        _setUpMockHttpClientResponse(JsonUtil.getStringSync(from: jsonFile));
        final jsonData = await JsonUtil.getJson(from: jsonFile);
        final tweetModel = TweetModel.fromJson(jsonData);
        final requestOption = TweetCreateRequestOption(message: 'Mensagem 1');
        // act
        final received = await repository.create(option: requestOption);
        // assert
        final request = verify(
          () => ApiProviderMock.httpClient.send(captureAny()),
        ).captured.single;

        expect(request.url.path, '/me/tweets');
        expect(request.method, 'POST');
        expect(request.headers['Content-Type'], contentType);
        expect(request.body, 'content=Mensagem%201');
        expect(received.fold(id, id), tweetModel);
      },
    );

    test(
      'get a tweet and return TweetSessionModel when the session is valid',
      () async {
        // arrange
        final jsonFile = 'feed/tweet_current_response.json';
        _setUpMockHttpClientResponse(JsonUtil.getStringSync(from: jsonFile));
        final jsonData = await JsonUtil.getJson(from: jsonFile);
        final tweetSession = TweetSessionModel.fromJson(jsonData);
        final requestOption = TweetEngageRequestOption(
          tweetId: '200528T2055370004',
          message: '',
        );
        // act
        final received = await repository.current(option: requestOption);
        // assert
        final request = verify(
          () => ApiProviderMock.httpClient.send(captureAny()),
        ).captured.single;

        expect(request.url.path, '/timeline');
        expect(request.method, 'GET');
        expect(request.headers['Content-Type'], contentType);
        expect(request.url.queryParameters, {'id': '200528T2055370004'});
        expect(received.fold(id, id), tweetSession);
      },
    );

    test(
      'delete a tweet and return ValidField when the session is valid',
      () async {
        // arrange
        _setUpMockHttpClientResponse('{}');
        final requestOption = TweetEngageRequestOption(
          tweetId: '200528T2055370004',
          message: '',
        );
        // act
        final received = await repository.delete(option: requestOption);
        // assert
        final request = verify(
          () => ApiProviderMock.httpClient.send(captureAny()),
        ).captured.single;

        expect(request.url.path, '/me/tweets');
        expect(request.method, 'DELETE');
        expect(request.url.queryParameters, {'id': '200528T2055370004'});
        expect(received.fold(id, id), ValidField());
      },
    );

    test(
      'get tweets and return TweetSessionModel when the session is valid',
      () async {
        // arrange
        final jsonFile = 'feed/retrieve_response.json';
        final jsonSession = await JsonUtil.getJson(from: jsonFile);
        final tweetSession = TweetSessionModel.fromJson(jsonSession);
        _setUpMockHttpClientResponse(JsonUtil.getStringSync(from: jsonFile));
        // act
        final received = await repository.fetch(
          option: const TweetRequestOption(
            rows: 50,
            after: '2025-02-22',
            before: '2025-02-22',
            parent: '200528T2055370004',
            nextPageToken: '200528T2055370004',
            replyTo: '200528T2055370004',
            category: '200528T2055370004',
            tags: 'tag1,tag2',
          ),
        );
        // assert
        final request = verify(
          () => ApiProviderMock.httpClient.send(captureAny()),
        ).captured.single;

        expect(request.url.path, '/timeline');
        expect(request.method, 'GET');
        expect(request.headers['Content-Type'], contentType);
        expect(request.url.queryParameters, {
          'rows': '50',
          'after': '2025-02-22',
          'before': '2025-02-22',
          'parent_id': '200528T2055370004',
          'next_page': '200528T2055370004',
          'reply_to': '200528T2055370004',
          'category': '200528T2055370004',
          'tags': 'tag1,tag2'
        });
        expect(received.fold(id, id), tweetSession);
      },
    );

    test(
      'like a tweet and return TweetModel when the session is valid',
      () async {
        // arrange
        final jsonFile = 'feed/tweet_like_response.json';
        final jsonData = await JsonUtil.getJson(from: jsonFile);
        final tweetModel =
            TweetModel.fromJson(jsonData['tweet'] as Map<String, dynamic>);
        _setUpMockHttpClientResponse(JsonUtil.getStringSync(from: jsonFile));

        final requestOption = TweetEngageRequestOption(
          tweetId: '200520T0032210001',
          message: '',
        );
        // act
        final received = await repository.like(option: requestOption);
        // assert
        final request = verify(
          () => ApiProviderMock.httpClient.send(captureAny()),
        ).captured.single;

        expect(request.url.path, '/timeline/200520T0032210001/like');
        expect(request.method, 'POST');
        expect(request.headers['Content-Type'], contentType);
        expect(request.url.queryParameters, {});
        expect(received.fold(id, id), tweetModel);
      },
    );

    test(
      'dislike a tweet and return TweetModel when the session is valid',
      () async {
        // arrange
        final jsonFile = 'feed/tweet_like_response.json';
        final jsonData = await JsonUtil.getJson(from: jsonFile);
        final tweetModel =
            TweetModel.fromJson(jsonData['tweet'] as Map<String, dynamic>);
        _setUpMockHttpClientResponse(JsonUtil.getStringSync(from: jsonFile));

        final requestOption = TweetEngageRequestOption(
          tweetId: '200520T0032210001',
          dislike: true,
          message: '',
        );
        // act
        final received = await repository.like(option: requestOption);
        // assert
        final request = verify(
          () => ApiProviderMock.httpClient.send(captureAny()),
        ).captured.single;

        expect(request.url.path, '/timeline/200520T0032210001/like');
        expect(request.method, 'POST');
        expect(request.headers['Content-Type'], contentType);
        expect(request.url.queryParameters, {'remove': '1'});
        expect(received.fold(id, id), tweetModel);
      },
    );

    test(
      'reply to a tweet and return TweetModel when the session is valid',
      () async {
        // arrange
        final jsonFile = 'feed/tweet_reply_response.json';
        final jsonData = await JsonUtil.getJson(from: jsonFile);
        final tweetModel = TweetModel.fromJson(jsonData);
        _setUpMockHttpClientResponse(JsonUtil.getStringSync(from: jsonFile));

        final requestOption = TweetEngageRequestOption(
          tweetId: '200528T2055370004',
          message: 'um breve comentário',
        );
        // act
        final received = await repository.reply(option: requestOption);
        // assert
        final request = verify(
          () => ApiProviderMock.httpClient.send(captureAny()),
        ).captured.single;

        expect(request.url.path, '/timeline/200528T2055370004/comment');
        expect(request.method, 'POST');
        expect(request.headers['Content-Type'], contentType);
        expect(request.body, 'content=um%20breve%20coment%C3%A1rio');
        expect(received.fold(id, id), tweetModel);
      },
    );

    test(
      'report a tweet and return ValidField when the session is valid',
      () async {
        // arrange
        _setUpMockHttpClientResponse('{}');
        final requestOption = TweetEngageRequestOption(
          tweetId: '200528T2055370004',
          message: 'informação agressiva',
        );
        // act
        final received = await repository.report(option: requestOption);
        // assert
        final request = verify(
          () => ApiProviderMock.httpClient.send(captureAny()),
        ).captured.single;

        expect(request.url.path, '/timeline/200528T2055370004/report');
        expect(request.method, 'POST');
        expect(request.headers['Content-Type'], contentType);
        expect(request.body, 'reason=informa%C3%A7%C3%A3o%20agressiva');
        expect(received.fold(id, id), ValidField());
      },
    );
  });
}
