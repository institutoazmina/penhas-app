import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/extension/either.dart';
import 'package:penhas/app/features/feed/data/models/tweet_model.dart';
import 'package:penhas/app/features/feed/data/models/tweet_session_model.dart';
import 'package:penhas/app/features/feed/data/repositories/tweet_repository.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_engage_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_session_entity.dart';
import 'package:penhas/app/features/feed/domain/repositories/i_tweet_repositories.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

void main() {
  late ITweetRepository repository;
  late final MockINetworkInfo networkInfo = MockINetworkInfo();
  late final MockITweetDataSource dataSource = MockITweetDataSource();
  Map<String, dynamic> jsonSession;

  setUp(() {
    repository =
        TweetRepository(dataSource: dataSource, networkInfo: networkInfo);
  });

  group('TweetRepository', () {
    TweetSessionModel? sessionModel;

    setUp(() async {
      jsonSession = await JsonUtil.getJson(from: 'feed/retrieve_response.json');
      sessionModel = TweetSessionModel.fromJson(jsonSession);
      when(dataSource.fetch(option: anyNamed('option')))
          .thenAnswer((_) => Future.value(sessionModel));
    });
    group('fetch()', () {
      test('should retrieve tweets from a valid session', () async {
        // arrange
        final TweetSessionEntity? expectedSession = sessionModel;
        // act
        final receivedSession =
            await repository.fetch(option: const TweetRequestOption());
        // assert
        expect(receivedSession.get(), expectedSession);
      });
    });
    group('create()', () {
      setUp(() async {
        final jsonData =
            await JsonUtil.getJson(from: 'feed/tweet_create_response.json');
        when(dataSource.create(option: anyNamed('option')))
            .thenAnswer((_) => Future.value(TweetModel.fromJson(jsonData)));
      });
      test('should create tweet from a valid session', () async {
        // arrange
        final requestOption = TweetCreateRequestOption(message: 'Mensagem 1');
        final expected = right(
          TweetModel(
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
            lastReply: const [],
          ),
        );
        // act
        final received = await repository.create(option: requestOption);
        // assert
        expect(received, expected);
      });
    });
    group('delete', () {
      setUp(() {
        when(dataSource.delete(option: anyNamed('option')))
            .thenAnswer((_) => Future.value(const ValidField()));
      });
      test('should detete tweet from a valid session', () async {
        // arrange
        final requestOption = TweetEngageRequestOption(
          tweetId: '200528T2055370004',
        );
        final expected = right(const ValidField());
        // act
        final received = await repository.delete(option: requestOption);
        // assert
        expect(received, expected);
      });
    });
    group('like()', () {
      Map<String, dynamic> jsonData;
      setUp(() async {
        jsonData =
            await JsonUtil.getJson(from: 'feed/tweet_like_response.json');
        final tweetModel = TweetModel.fromJson(jsonData['tweet']);

        when(dataSource.like(option: anyNamed('option')))
            .thenAnswer((_) => Future.value(tweetModel));
      });
      test('should favorite a valid tweet', () async {
        // arrange
        final requestOption =
            TweetEngageRequestOption(tweetId: '200520T0032210001');
        final expected = right(
          TweetModel(
            id: '200528T2055370004',
            userName: 'penhas',
            clientId: 551,
            createdAt: '2020-05-28 20:55:37',
            totalReply: 0,
            totalLikes: 1,
            anonymous: false,
            content: 'sleep 6',
            avatar: 'https://elasv2-api.appcivico.com/avatar/padrao.svg',
            meta: const TweetMeta(liked: true, owner: true),
            lastReply: const [],
          ),
        );
        // act
        final received = await repository.like(option: requestOption);
        // assert
        expect(received, expected);
      });
    });
    group('reply()', () {
      setUp(() async {
        final jsonData =
            await JsonUtil.getJson(from: 'feed/tweet_reply_response.json');
        when(dataSource.reply(option: anyNamed('option')))
            .thenAnswer((_) => Future.value(TweetModel.fromJson(jsonData)));
      });

      test('should reply a valid tweet', () async {
        // arrange
        final requestOption = TweetEngageRequestOption(
          tweetId: '200528T2055370004',
          message: 'um breve comentario',
        );
        final expected = right(
          TweetModel(
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
          ),
        );
        // act
        final received = await repository.reply(option: requestOption);
        // assert
        expect(received, expected);
      });
    });
    group('current()', () {
      setUp(() async {
        final jsonData =
            await JsonUtil.getJson(from: 'feed/tweet_current_response.json');
        when(dataSource.current(option: anyNamed('option'))).thenAnswer(
          (_) => Future.value(TweetSessionModel.fromJson(jsonData)),
        );
      });

      test('should get a current version of a tweet', () async {
        // arrange
        final requestOption = TweetEngageRequestOption(
          tweetId: '200528T2055370004',
        );
        final expected = right(
          TweetSessionModel(
            TweetSessionOrder.latestFirst,
            null,
            [
              TweetModel(
                id: '200608T1545460001',
                userName: 'maria',
                clientId: 551,
                createdAt: '2020-06-08 15:45:46',
                totalReply: 0,
                totalLikes: 0,
                anonymous: false,
                content: 'Comentário 7',
                avatar: 'https://elasv2-api.appcivico.com/avatar/padrao.svg',
                meta:
                    const TweetMeta(liked: false, owner: true, canReply: false),
                lastReply: const [],
              )
            ],
            null,
            hasMore: false,
          ),
        );
        // act
        final received = await repository.current(option: requestOption);
        // assert
        expect(received, expected);
      });
    });

    group('report()', () {
      setUp(() {
        when(dataSource.report(option: anyNamed('option')))
            .thenAnswer((_) => Future.value(const ValidField()));
      });
      test('should report a valid tweet', () async {
        // arrange
        final requestOption = TweetEngageRequestOption(
          tweetId: '200528T2055370004',
          message: 'esse tweet me ofende pq XPTO',
        );
        final expected = right(const ValidField());
        // act
        final received = await repository.report(option: requestOption);
        // assert
        expect(received, expected);
      });
    });
  });
}
