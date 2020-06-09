import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
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
    group('reply', () {
      int maxRowsPerRequet;
      TweetSessionEntity firstSessionResponse;
      TweetEntity tweetEntity1;
      TweetEntity tweetEntity2;
      TweetEntity tweetEntity3;

      setUp(() {
        maxRowsPerRequet = 5;
        tweetEntity1 = TweetEntity(
          id: 'id_1',
          userName: 'user_2',
          clientId: 2,
          createdAt: '2020-02-04 00:00:02',
          totalReply: 0,
          totalLikes: 1,
          anonymous: false,
          content: 'content 1',
          avatar: 'http://site.com/avatar_2.png',
          meta: TweetMeta(liked: true, owner: true),
          lastReply: [],
        );
        tweetEntity3 = TweetEntity(
          id: 'id_3',
          userName: 'user_6',
          clientId: 6,
          createdAt: '2020-03-01 00:00:01',
          totalReply: 0,
          totalLikes: 1,
          anonymous: false,
          content: 'comment 3',
          avatar: 'http://site.com/avatar_1.png',
          meta: TweetMeta(liked: true, owner: true),
          lastReply: [],
        );
        tweetEntity2 = TweetEntity(
          id: 'id_2',
          userName: 'user_1',
          clientId: 1,
          createdAt: '2020-02-03 00:00:01',
          totalReply: 1,
          totalLikes: 1,
          anonymous: false,
          content: 'content 2',
          avatar: 'http://site.com/avatar_1.png',
          meta: TweetMeta(liked: true, owner: true),
          lastReply: [tweetEntity3],
        );

        firstSessionResponse = TweetSessionEntity(
            hasMore: true,
            orderBy: TweetSessionOrder.latestFirst,
            tweets: [
              tweetEntity1,
              tweetEntity2,
            ]);
      });

      test('should create commented tweet and get updated cache', () async {
        // arrange
        final sut = FeedUseCases(
          repository: repository,
          maxRows: maxRowsPerRequet,
        );
        when(repository.fetch(option: anyNamed('option')))
            .thenAnswer((_) async => right(firstSessionResponse));
        await sut.fetchOldestTweet();
        final newTweet = TweetEntity(
          id: 'id_5',
          userName: 'maria',
          clientId: 42,
          createdAt: '2020-05-05 05:05:05',
          totalReply: 0,
          totalLikes: 0,
          anonymous: false,
          content: 'commented tweet = 5',
          avatar: 'http://site.com/avatar_42.png',
          meta: TweetMeta(liked: false, owner: true),
          lastReply: [],
        );
        final commentedTweet = tweetEntity1.copyWith(
          totalReply: tweetEntity1.totalReply + 1,
          lastReply: [newTweet],
        );
        final expected = right(
          FeedCache(tweets: [
            commentedTweet,
            tweetEntity2,
          ]),
        );

        when(repository.reply(option: anyNamed('option')))
            .thenAnswer((_) async => right(newTweet));
        // act
        final received = await sut.reply(
          mainTweet: tweetEntity1,
          comment: 'commented tweet',
        );
        // assert
        expect(received, expected);
      });
      test('should replaced current commented by new replied tweet', () async {
        // arrange
        final sut = FeedUseCases(
          repository: repository,
          maxRows: maxRowsPerRequet,
        );
        when(repository.fetch(option: anyNamed('option')))
            .thenAnswer((_) async => right(firstSessionResponse));
        await sut.fetchOldestTweet();
        final newTweet = TweetEntity(
          id: 'id_5',
          userName: 'maria',
          clientId: 42,
          createdAt: '2020-05-05 05:05:05',
          totalReply: 0,
          totalLikes: 0,
          anonymous: false,
          content: 'commented tweet',
          avatar: 'http://site.com/avatar_42.png',
          meta: TweetMeta(liked: false, owner: true),
          lastReply: [],
        );
        final commentedTweet = tweetEntity2.copyWith(
          totalReply: 2,
          lastReply: [newTweet],
        );
        final expected = right(
          FeedCache(tweets: [
            tweetEntity1,
            commentedTweet,
          ]),
        );

        when(repository.reply(option: anyNamed('option')))
            .thenAnswer((_) async => right(newTweet));
        // act
        final received = await sut.reply(
          mainTweet: tweetEntity2,
          comment: 'commented tweet',
        );
        // assert
        expect(received, expected);
      });
    });
  });
}
