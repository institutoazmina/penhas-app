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
  late MockTweetFilterPreference filterPreference;

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
    test(
      'dot not hit datasource on instantiate',
      () async {
        // act
        FeedUseCases(
            repository: repository, filterPreference: filterPreference);
        // assert
        verifyNoMoreInteractions(repository);
      },
    );
    group('reply()', () {
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
          totalLikes: 1,
          anonymous: false,
          content: 'content 1',
          avatar: 'http://site.com/avatar_2.png',
          meta: const TweetMeta(liked: true, owner: true),
          lastReply: const [],
          badges: [],
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
          content: 'content 2',
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

      test(
        'should create commented tweet and get updated cache',
        () async {
          // arrange
          final sut = FeedUseCases(
            repository: repository,
            filterPreference: filterPreference,
            maxRows: maxRowsPerRequest,
          );
          when(() => repository.fetch(option: any(named: 'option')))
              .thenAnswer((_) => Future.value(right(firstSessionResponse)));
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
            meta: const TweetMeta(liked: false, owner: true),
            lastReply: const [],
            badges: [],
          );
          final commentedTweet = tweetEntity1.copyWith(
            totalReply: tweetEntity1.totalReply + 1,
            lastReply: [newTweet],
          );
          final expected = FeedCache(
            tweets: [
              commentedTweet,
              tweetEntity2,
            ],
          );

          when(() => repository.reply(option: any(named: 'option')))
              .thenAnswer((_) async => right(newTweet));

          // act
          sut.reply(
            mainTweet: tweetEntity1,
            comment: 'commented tweet',
          );

          // assert
          expectLater(sut.tweetList(), emits(expected));
        },
      );

      test(
        'replaced current commented by new replied tweet',
        () async {
          // arrange
          final sut = FeedUseCases(
            repository: repository,
            filterPreference: filterPreference,
            maxRows: maxRowsPerRequest,
          );
          when(() => repository.fetch(option: any(named: 'option')))
              .thenAnswer((_) => Future.value(right(firstSessionResponse)));
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
            meta: const TweetMeta(liked: false, owner: true),
            lastReply: const [],
            badges: [],
          );
          final commentedTweet = tweetEntity2.copyWith(
            totalReply: 2,
            lastReply: [newTweet],
          );
          final expected = FeedCache(
            tweets: [
              tweetEntity1,
              commentedTweet,
            ],
          );

          when(() => repository.reply(option: any(named: 'option')))
              .thenAnswer((_) async => right(newTweet));

          // act
          sut.reply(
            mainTweet: tweetEntity2,
            comment: 'commented tweet',
          );

          // assert
          expectLater(sut.tweetList(), emits(expected));
        },
      );

      test(
        'when create commented tweet should return updated tweet',
        () async {
          // arrange
          final sut = FeedUseCases(
            repository: repository,
            filterPreference: filterPreference,
            maxRows: maxRowsPerRequest,
          );
          when(() => repository.fetch(option: any(named: 'option')))
              .thenAnswer((_) => Future.value(right(firstSessionResponse)));
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
            meta: const TweetMeta(liked: false, owner: true),
            lastReply: const [],
            badges: [],
          );
          final expected = right(newTweet);

          when(() => repository.reply(option: any(named: 'option')))
              .thenAnswer((_) async => right(newTweet));

          // act
          final received = await sut.reply(
            mainTweet: tweetEntity1,
            comment: 'commented tweet',
          );

          // assert
          expect(received, expected);
        },
      );
    });
  });
}
