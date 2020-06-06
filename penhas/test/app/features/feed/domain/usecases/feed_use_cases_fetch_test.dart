import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_session_entity.dart';
import 'package:penhas/app/features/feed/domain/repositories/i_tweet_repositories.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_use_cases.dart';

class MockTweetRepository extends Mock implements ITweetRepository {}

void main() {
  ITweetRepository repository;

  setUp(() {
    repository = MockTweetRepository();
  });

  group('FeedUseCases', () {
    test('should not hit datasource on instantiate', () async {
      // act
      FeedUseCases(repository: repository);
      // assert
      verifyNoMoreInteractions(repository);
    });
    group('fetchNewestTweet', () {
      int maxRowsPerRequet;
      TweetSessionEntity firstSessionResponse;
      TweetSessionEntity secondSessionResponse;
      TweetSessionEntity thirdSessionResponse;

      setUp(() {
        maxRowsPerRequet = 5;
        firstSessionResponse = TweetSessionEntity(
            hasMore: true,
            orderBy: TweetSessionOrder.latestFirst,
            tweets: [
              TweetEntity(
                id: 'id_2',
                userName: 'user_2',
                clientId: 2,
                createdAt: '2020-01-01 00:00:02',
                totalReply: 0,
                totalLikes: 1,
                anonymous: false,
                content: 'content 2',
                avatar: 'http://site.com/avatar_2.png',
                meta: TweetMeta(liked: false, owner: true),
                lastReply: [],
              ),
              TweetEntity(
                id: 'id_1',
                userName: 'user_1',
                clientId: 1,
                createdAt: '2020-01-01 00:00:01',
                totalReply: 0,
                totalLikes: 1,
                anonymous: false,
                content: 'content 1',
                avatar: 'http://site.com/avatar_1.png',
                meta: TweetMeta(liked: false, owner: true),
                lastReply: [],
              ),
            ]);
        secondSessionResponse = TweetSessionEntity(
            hasMore: false,
            orderBy: TweetSessionOrder.oldestFirst,
            tweets: [
              TweetEntity(
                id: 'id_3',
                userName: 'user_1',
                clientId: 1,
                createdAt: '2020-02-02 00:00:02',
                totalReply: 0,
                totalLikes: 1,
                anonymous: false,
                content: 'content 1',
                avatar: 'http://site.com/avatar_1.png',
                meta: TweetMeta(liked: false, owner: true),
                lastReply: [],
              ),
              TweetEntity(
                id: 'id_4',
                userName: 'user_2',
                clientId: 2,
                createdAt: '2020-02-03 00:00:03',
                totalReply: 0,
                totalLikes: 1,
                anonymous: false,
                content: 'content 4',
                avatar: 'http://site.com/avatar_2.png',
                meta: TweetMeta(liked: false, owner: true),
                lastReply: [],
              ),
            ]);
        thirdSessionResponse = TweetSessionEntity(
          hasMore: false,
          orderBy: TweetSessionOrder.oldestFirst,
          tweets: [],
        );
      });
      test('should get the newest tweets', () async {
        // arrange
        when(repository.retrieve(option: anyNamed('option')))
            .thenAnswer((_) async => right(firstSessionResponse));

        final Either<Failure, FeedCache> expected =
            right(FeedCache(tweets: firstSessionResponse.tweets));
        final sut = FeedUseCases(repository: repository);
        // act
        final received = await sut.fetchNewestTweet();
        // assert
        expect(expected, received);
      });
      test('should do pagination', () async {
        // arrange
        final sut =
            FeedUseCases(repository: repository, maxRows: maxRowsPerRequet);
        when(repository.retrieve(option: anyNamed('option')))
            .thenAnswer((_) async => right(firstSessionResponse));
        final expected = right(
          FeedCache(
            tweets: [
              ...secondSessionResponse.tweets.reversed,
              ...firstSessionResponse.tweets
            ],
          ),
        );
        await sut.fetchNewestTweet();
        when(repository.retrieve(option: anyNamed('option')))
            .thenAnswer((_) async => right(secondSessionResponse));
        // act
        final received = await sut.fetchNewestTweet();
        // assert
        verify(
          repository.retrieve(
              option: TweetRequestOption(
            rows: maxRowsPerRequet,
            after: firstSessionResponse.tweets.first.id,
          )),
        );
        expect(expected, received);
      });
      test('should not update cache if has no more tweets', () async {
        // arrange
        final sut =
            FeedUseCases(repository: repository, maxRows: maxRowsPerRequet);

        when(repository.retrieve(option: anyNamed('option')))
            .thenAnswer((_) async => right(firstSessionResponse));
        await sut.fetchNewestTweet();

        when(repository.retrieve(option: anyNamed('option')))
            .thenAnswer((_) async => right(secondSessionResponse));
        final expected = await sut.fetchNewestTweet();
        // act
        when(repository.retrieve(option: anyNamed('option')))
            .thenAnswer((_) async => right(thirdSessionResponse));
        final received = await sut.fetchNewestTweet();
        // assert
        expect(expected, received);
      });
    });
    group('fetchOldestTweet', () {
      int maxRowsPerRequet;
      TweetSessionEntity firstSessionResponse;
      TweetSessionEntity secondSessionResponse;
      TweetSessionEntity thirdSessionResponse;

      setUp(() {
        maxRowsPerRequet = 5;
        firstSessionResponse = TweetSessionEntity(
            hasMore: true,
            orderBy: TweetSessionOrder.latestFirst,
            tweets: [
              TweetEntity(
                id: 'id_4',
                userName: 'user_2',
                clientId: 2,
                createdAt: '2020-02-04 00:00:02',
                totalReply: 0,
                totalLikes: 1,
                anonymous: false,
                content: 'content 4',
                avatar: 'http://site.com/avatar_2.png',
                meta: TweetMeta(liked: false, owner: true),
                lastReply: [],
              ),
              TweetEntity(
                id: 'id_3',
                userName: 'user_1',
                clientId: 1,
                createdAt: '2020-02-03 00:00:01',
                totalReply: 0,
                totalLikes: 1,
                anonymous: false,
                content: 'content 3',
                avatar: 'http://site.com/avatar_1.png',
                meta: TweetMeta(liked: false, owner: true),
                lastReply: [],
              ),
            ]);
        secondSessionResponse = TweetSessionEntity(
            hasMore: true,
            orderBy: TweetSessionOrder.latestFirst,
            tweets: [
              TweetEntity(
                id: 'id_2',
                userName: 'user_1',
                clientId: 1,
                createdAt: '2020-01-02 00:00:01',
                totalReply: 0,
                totalLikes: 1,
                anonymous: false,
                content: 'content 2',
                avatar: 'http://site.com/avatar_1.png',
                meta: TweetMeta(liked: false, owner: true),
                lastReply: [],
              ),
              TweetEntity(
                id: 'id_1',
                userName: 'user_2',
                clientId: 2,
                createdAt: '2020-01-01 00:00:01',
                totalReply: 0,
                totalLikes: 1,
                anonymous: false,
                content: 'content 1',
                avatar: 'http://site.com/avatar_2.png',
                meta: TweetMeta(liked: false, owner: true),
                lastReply: [],
              ),
            ]);
        thirdSessionResponse = TweetSessionEntity(
            hasMore: true,
            orderBy: TweetSessionOrder.oldestFirst,
            tweets: [
              TweetEntity(
                id: 'id_1',
                userName: 'user_2',
                clientId: 2,
                createdAt: '2020-01-01 00:00:01',
                totalReply: 0,
                totalLikes: 1,
                anonymous: false,
                content: 'content 1',
                avatar: 'http://site.com/avatar_2.png',
                meta: TweetMeta(liked: false, owner: true),
                lastReply: [],
              ),
              TweetEntity(
                id: 'id_2',
                userName: 'user_1',
                clientId: 1,
                createdAt: '2020-01-02 00:00:01',
                totalReply: 0,
                totalLikes: 1,
                anonymous: false,
                content: 'content 2',
                avatar: 'http://site.com/avatar_1.png',
                meta: TweetMeta(liked: false, owner: true),
                lastReply: [],
              ),
            ]);
      });
      test('should get the newest tweets for first time', () async {
        // arrange
        when(repository.retrieve(option: anyNamed('option')))
            .thenAnswer((_) async => right(firstSessionResponse));

        final Either<Failure, FeedCache> expected =
            right(FeedCache(tweets: firstSessionResponse.tweets));
        final sut = FeedUseCases(repository: repository);
        // act
        final received = await sut.fetchOldestTweet();
        // assert
        expect(expected, received);
      });

      test('should do pagination with the oldest tweets', () async {
        // arrange
        final sut = FeedUseCases(
          repository: repository,
          maxRows: maxRowsPerRequet,
        );
        final expected = right(
          FeedCache(
            tweets: [
              ...firstSessionResponse.tweets,
              ...secondSessionResponse.tweets,
            ],
          ),
        );

        when(repository.retrieve(option: anyNamed('option')))
            .thenAnswer((_) async => right(firstSessionResponse));
        await sut.fetchOldestTweet();

        when(repository.retrieve(option: anyNamed('option')))
            .thenAnswer((_) async => right(secondSessionResponse));
        // act
        final received = await sut.fetchOldestTweet();
        // assert
        verify(
          repository.retrieve(
              option: TweetRequestOption(
            rows: maxRowsPerRequet,
            after: firstSessionResponse.tweets.last.id,
          )),
        );
        expect(expected, received);
      });
      test(
          'should do pagination sorted with the oldest tweets when received a TweetSessionOrder.oldestFirst. ',
          () async {
        // arrange
        final sut = FeedUseCases(
          repository: repository,
          maxRows: maxRowsPerRequet,
        );
        final expected = right(
          FeedCache(
            tweets: [
              ...firstSessionResponse.tweets,
              ...thirdSessionResponse.tweets.reversed,
            ],
          ),
        );

        when(repository.retrieve(option: anyNamed('option')))
            .thenAnswer((_) async => right(firstSessionResponse));
        await sut.fetchOldestTweet();

        when(repository.retrieve(option: anyNamed('option')))
            .thenAnswer((_) async => right(thirdSessionResponse));
        // act
        final received = await sut.fetchOldestTweet();
        // assert
        verify(
          repository.retrieve(
              option: TweetRequestOption(
            rows: maxRowsPerRequet,
            after: firstSessionResponse.tweets.last.id,
          )),
        );
        expect(expected, received);
      });
    });
  });
}
