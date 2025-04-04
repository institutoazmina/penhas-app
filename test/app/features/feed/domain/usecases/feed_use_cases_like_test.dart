import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_engage_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_session_entity.dart';
import 'package:penhas/app/features/feed/domain/repositories/i_tweet_repositories.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_use_cases.dart';
import 'package:penhas/app/features/feed/domain/usecases/tweet_filter_preference.dart';

class MockTweetRepository extends Mock implements ITweetRepository {}

class MockTweetFilterPreference extends Mock implements TweetFilterPreference {}

void main() {
  late ITweetRepository repository;
  late TweetFilterPreference filterPreference;

  setUp(() {
    repository = MockTweetRepository();
    filterPreference = MockTweetFilterPreference();

    when(() => filterPreference.categories).thenReturn([]);
    when(() => filterPreference.getTags()).thenReturn([]);
  });

  setUpAll(() {
    registerFallbackValue(const TweetRequestOption());
    registerFallbackValue(TweetEngageRequestOption(tweetId: '', message: ''));
  });

  group(FeedUseCases, () {
    test('should not hit datasource on instantiate', () async {
      // act
      FeedUseCases(repository: repository, filterPreference: filterPreference);
      // assert
      verifyNoMoreInteractions(repository);
    });
    group('like()', () {
      late int maxRowsPerRequest;
      late TweetSessionEntity firstSessionResponse;
      late TweetEntity tweetEntity1;
      late TweetEntity tweetEntity2;
      late TweetEntity tweetEntity3;

      setUp(() {
        maxRowsPerRequest = 5;
        tweetEntity1 = TweetEntity(
          id: 'id_1',
          userName: 'user_2',
          clientId: 2,
          createdAt: '2020-02-04 00:00:02',
          totalReply: 0,
          totalLikes: 0,
          anonymous: false,
          content: 'content 4',
          avatar: 'http://site.com/avatar_2.png',
          meta: const TweetMeta(liked: false, owner: true),
          lastReply: const [],
          badges: [],
        );
        tweetEntity3 = TweetEntity(
          id: 'id_3',
          parentId: 'id_2',
          userName: 'user_6',
          clientId: 6,
          createdAt: '2020-03-01 00:00:01',
          totalReply: 0,
          totalLikes: 1,
          anonymous: false,
          content: 'comment 3',
          avatar: 'http://site.com/avatar_1.png',
          meta: const TweetMeta(liked: false, owner: true),
          lastReply: const [],
          badges: [],
        );
        tweetEntity2 = TweetEntity(
          id: 'id_2',
          userName: 'user_1',
          clientId: 1,
          createdAt: '2020-02-03 00:00:01',
          totalReply: 1,
          totalLikes: 0,
          anonymous: false,
          content: 'content 3',
          avatar: 'http://site.com/avatar_1.png',
          meta: const TweetMeta(liked: false, owner: true),
          lastReply: [tweetEntity3],
          badges: [],
        );

        firstSessionResponse = TweetSessionEntity(
          nextPage: null,
          hasMore: true,
          orderBy: TweetSessionOrder.latestFirst,
          tweets: [
            tweetEntity1,
            tweetEntity2,
          ],
        );
      });

      test('main tweet should get updated cache', () async {
        // arrange
        final sut = FeedUseCases(
          repository: repository,
          filterPreference: filterPreference,
          maxRows: maxRowsPerRequest,
        );
        when(() => repository.fetch(option: any(named: 'option')))
            .thenAnswer((_) async => right(firstSessionResponse));
        await sut.fetchOldestTweet();

        final likeResponse = tweetEntity1.copyWith(
          totalLikes: tweetEntity1.totalLikes + 1,
          meta: const TweetMeta(liked: true, owner: true),
        );
        final expected = right(
          FeedCache(
            tweets: [
              likeResponse,
              tweetEntity2,
            ],
          ),
        );
        when(() => repository.like(option: any(named: 'option')))
            .thenAnswer((_) async => right(likeResponse));
        // act
        final received = await sut.like(tweetEntity1);
        // assert
        expect(received, expected);
      });

      test('sub tweet should get updated cache', () async {
        // arrange
        final sut = FeedUseCases(
          repository: repository,
          filterPreference: filterPreference,
          maxRows: maxRowsPerRequest,
        );
        when(() => repository.fetch(option: any(named: 'option')))
            .thenAnswer((_) async => right(firstSessionResponse));
        await sut.fetchOldestTweet();

        final likeResponse = tweetEntity3.copyWith(
          totalLikes: tweetEntity3.totalLikes + 1,
          meta: const TweetMeta(liked: true, owner: true),
        );
        when(() => repository.like(option: any(named: 'option')))
            .thenAnswer((_) async => right(likeResponse));
        final expected = right(
          FeedCache(
            tweets: [
              tweetEntity1,
              tweetEntity2.copyWith(
                lastReply: [likeResponse],
              ),
            ],
          ),
        );
        // act
        final received = await sut.like(tweetEntity3);
        // assert
        expect(received, expected);
      });
    });
    group('unlike()', () {
      late int maxRowsPerRequet;
      late TweetSessionEntity firstSessionResponse;
      late TweetEntity tweetEntity1;
      late TweetEntity tweetEntity2;
      late TweetEntity tweetEntity3;

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
          content: 'content 4',
          avatar: 'http://site.com/avatar_2.png',
          meta: const TweetMeta(liked: true, owner: true),
          lastReply: const [],
          badges: [],
        );
        tweetEntity3 = TweetEntity(
          id: 'id_3',
          parentId: 'id_2',
          userName: 'user_6',
          clientId: 6,
          createdAt: '2020-03-01 00:00:01',
          totalReply: 0,
          totalLikes: 1,
          anonymous: false,
          content: 'comment 3',
          avatar: 'http://site.com/avatar_1.png',
          meta: const TweetMeta(liked: true, owner: true),
          lastReply: const [],
          badges: [],
        );
        tweetEntity2 = TweetEntity(
          id: 'id_2',
          userName: 'user_1',
          clientId: 1,
          createdAt: '2020-02-03 00:00:01',
          totalReply: 1,
          totalLikes: 1,
          anonymous: false,
          content: 'content 3',
          avatar: 'http://site.com/avatar_1.png',
          meta: const TweetMeta(liked: true, owner: true),
          lastReply: [tweetEntity3],
          badges: [],
        );

        firstSessionResponse = TweetSessionEntity(
          nextPage: null,
          hasMore: true,
          orderBy: TweetSessionOrder.latestFirst,
          tweets: [
            tweetEntity1,
            tweetEntity2,
          ],
        );
      });

      test('main tweet should get updated cache', () async {
        // arrange
        final sut = FeedUseCases(
          repository: repository,
          filterPreference: filterPreference,
          maxRows: maxRowsPerRequet,
        );
        when(() => repository.fetch(option: any(named: 'option')))
            .thenAnswer((_) async => right(firstSessionResponse));
        await sut.fetchOldestTweet();

        final likeResponse = tweetEntity1.copyWith(
          totalLikes: tweetEntity1.totalLikes - 1,
          meta: const TweetMeta(liked: false, owner: true),
        );
        final expected = right(
          FeedCache(
            tweets: [
              likeResponse,
              tweetEntity2,
            ],
          ),
        );
        when(() => repository.like(option: any(named: 'option')))
            .thenAnswer((_) async => right(likeResponse));
        // act
        final received = await sut.unlike(tweetEntity1);
        // assert
        expect(received, expected);
      });

      test('sub tweet should get updated cache', () async {
        // arrange
        final sut = FeedUseCases(
          repository: repository,
          filterPreference: filterPreference,
          maxRows: maxRowsPerRequet,
        );
        when(() => repository.fetch(option: any(named: 'option')))
            .thenAnswer((_) async => right(firstSessionResponse));
        await sut.fetchOldestTweet();

        final likeResponse = tweetEntity3.copyWith(
          totalLikes: 0,
          meta: const TweetMeta(liked: false, owner: true),
        );
        when(() => repository.like(option: any(named: 'option')))
            .thenAnswer((_) async => right(likeResponse));
        final expected = right(
          FeedCache(
            tweets: [
              tweetEntity1,
              tweetEntity2.copyWith(
                lastReply: [likeResponse],
              ),
            ],
          ),
        );
        // act
        final received = await sut.unlike(tweetEntity3);
        // assert
        expect(received, expected);
      });
    });
  });
}
