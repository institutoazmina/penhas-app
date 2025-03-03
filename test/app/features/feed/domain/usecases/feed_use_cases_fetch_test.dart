import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
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
    test(
      'do not hit datasource on instantiate',
      () async {
        // act
        FeedUseCases(
            repository: repository, filterPreference: filterPreference);
        // assert
        verifyNoMoreInteractions(repository);
      },
    );
    group('fetchNewestTweet()', () {
      late int maxRowsPerRequet;
      late TweetSessionEntity firstSessionResponse;
      late TweetSessionEntity secondSessionResponse;
      late TweetSessionEntity thirdSessionResponse;

      setUp(() {
        maxRowsPerRequet = 5;
        firstSessionResponse = TweetSessionEntity(
          nextPage: '_next_page_request_1_',
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
              meta: const TweetMeta(liked: false, owner: true),
              lastReply: const [],
              badges: [],
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
              meta: const TweetMeta(liked: false, owner: true),
              lastReply: const [],
              badges: [],
            ),
          ],
        );
        secondSessionResponse = TweetSessionEntity(
          nextPage: '_next_page_request_1_',
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
              meta: const TweetMeta(liked: false, owner: true),
              lastReply: const [],
              badges: [],
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
              meta: const TweetMeta(liked: false, owner: true),
              lastReply: const [],
              badges: [],
            ),
          ],
        );
        thirdSessionResponse = const TweetSessionEntity(
          nextPage: '_next_page_request_1_',
          hasMore: false,
          orderBy: TweetSessionOrder.oldestFirst,
          tweets: [],
        );
      });
      test(
        'should get the newest tweets',
        () async {
          // arrange
          when(() => repository.fetch(option: any(named: 'option')))
              .thenAnswer((_) async => right(firstSessionResponse));

          final Either<Failure, FeedCache> expected =
              right(FeedCache(tweets: firstSessionResponse.tweets));
          final sut = FeedUseCases(
            repository: repository,
            filterPreference: filterPreference,
          );
          // act
          final received = await sut.fetchNewestTweet();
          // assert
          expect(expected, received);
        },
      );
      test(
        'do pagination',
        () async {
          // arrange
          final sut = FeedUseCases(
            repository: repository,
            filterPreference: filterPreference,
            maxRows: maxRowsPerRequet,
          );
          when(() => repository.fetch(option: any(named: 'option')))
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
          when(() => repository.fetch(option: any(named: 'option')))
              .thenAnswer((_) async => right(secondSessionResponse));
          // act
          final received = await sut.fetchNewestTweet();
          // assert

          verify(
            () => repository.fetch(
              option: TweetRequestOption(
                rows: maxRowsPerRequet,
                after: (firstSessionResponse.tweets.first as TweetEntity).id,
              ),
            ),
          ).called(1);
          expect(expected, received);
        },
      );
      test(
        'do not update cache if has no more tweets',
        () async {
          // arrange
          final sut = FeedUseCases(
            repository: repository,
            filterPreference: filterPreference,
            maxRows: maxRowsPerRequet,
          );

          when(() => repository.fetch(option: any(named: 'option')))
              .thenAnswer((_) async => right(firstSessionResponse));
          await sut.fetchNewestTweet();

          when(() => repository.fetch(option: any(named: 'option')))
              .thenAnswer((_) async => right(secondSessionResponse));
          final expected = await sut.fetchNewestTweet();
          // act
          when(() => repository.fetch(option: any(named: 'option')))
              .thenAnswer((_) async => right(thirdSessionResponse));
          final received = await sut.fetchNewestTweet();
          // assert
          expect(expected, received);
        },
      );
    });
    group('fetchOldestTweet()', () {
      late int maxRowsPerRequet;
      late TweetSessionEntity firstSessionResponse;
      late TweetSessionEntity secondSessionResponse;
      late TweetSessionEntity thirdSessionResponse;

      setUp(() {
        maxRowsPerRequet = 5;
        firstSessionResponse = TweetSessionEntity(
          nextPage: '_next_page_request_1_',
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
              meta: const TweetMeta(liked: false, owner: true),
              lastReply: const [],
              badges: [],
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
              meta: const TweetMeta(liked: false, owner: true),
              lastReply: const [],
              badges: [],
            ),
          ],
        );
        secondSessionResponse = TweetSessionEntity(
          nextPage: '_next_page_request_2_',
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
              meta: const TweetMeta(liked: false, owner: true),
              lastReply: const [],
              badges: [],
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
              meta: const TweetMeta(liked: false, owner: true),
              lastReply: const [],
              badges: [],
            ),
          ],
        );
        thirdSessionResponse = TweetSessionEntity(
          nextPage: '_next_page_request_3_',
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
              meta: const TweetMeta(liked: false, owner: true),
              lastReply: const [],
              badges: [],
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
              meta: const TweetMeta(liked: false, owner: true),
              lastReply: const [],
              badges: [],
            ),
          ],
        );
      });
      test(
        'get the newest tweets for first time',
        () async {
          // arrange
          when(() => repository.fetch(option: any(named: 'option')))
              .thenAnswer((_) async => right(firstSessionResponse));

          final Either<Failure, FeedCache> expected =
              right(FeedCache(tweets: firstSessionResponse.tweets));
          final sut = FeedUseCases(
            repository: repository,
            filterPreference: filterPreference,
          );
          // act
          final received = await sut.fetchOldestTweet();
          // assert
          expect(expected, received);
        },
      );

      test(
        'do pagination with the oldest tweets',
        () async {
          // arrange
          final sut = FeedUseCases(
            repository: repository,
            filterPreference: filterPreference,
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

          when(() => repository.fetch(option: any(named: 'option')))
              .thenAnswer((_) async => right(firstSessionResponse));
          await sut.fetchNewestTweet();

          when(() => repository.fetch(option: any(named: 'option')))
              .thenAnswer((_) async => right(secondSessionResponse));
          // act
          final received = await sut.fetchOldestTweet();
          // assert
          verifyInOrder([
            () => repository.fetch(
                  option: TweetRequestOption(
                    rows: maxRowsPerRequet,
                  ),
                ),
            () => repository.fetch(
                  option: TweetRequestOption(
                    rows: maxRowsPerRequet,
                    nextPageToken: '_next_page_request_1_',
                  ),
                ),
          ]);
          expect(expected, received);
        },
      );
      test(
        'do pagination sorted with the oldest tweets when received a TweetSessionOrder.oldestFirst. ',
        () async {
          // arrange
          final sut = FeedUseCases(
            repository: repository,
            filterPreference: filterPreference,
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

          when(() => repository.fetch(option: any(named: 'option')))
              .thenAnswer((_) => Future.value(right(firstSessionResponse)));
          await sut.fetchOldestTweet();

          when(() => repository.fetch(option: any(named: 'option')))
              .thenAnswer((_) => Future.value(right(thirdSessionResponse)));
          // act
          final received = await sut.fetchOldestTweet();
          // assert
          verifyInOrder([
            () => repository.fetch(
                  option: TweetRequestOption(
                    rows: maxRowsPerRequet,
                  ),
                ),
            () => repository.fetch(
                  option: TweetRequestOption(
                    rows: maxRowsPerRequet,
                    nextPageToken: '_next_page_request_1_',
                  ),
                ),
          ]);

          expect(expected, received);
        },
      );
    });
  });
}
