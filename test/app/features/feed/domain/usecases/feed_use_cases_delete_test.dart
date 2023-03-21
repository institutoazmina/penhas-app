import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
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
    registerFallbackValue(TweetEngageRequestOption(tweetId: ''));
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
    group(
      'delete()',
      () {
        late int maxRowsPerRequest;
        late TweetSessionEntity firstSessionResponse;

        setUp(() {
          maxRowsPerRequest = 5;
          firstSessionResponse = TweetSessionEntity(
            nextPage: null,
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
              ),
              TweetEntity(
                id: 'id_1',
                userName: 'user_1',
                clientId: 1,
                createdAt: '2020-01-01 00:00:01',
                totalReply: 1,
                totalLikes: 1,
                anonymous: false,
                content: 'content 1',
                avatar: 'http://site.com/avatar_1.png',
                meta: const TweetMeta(liked: false, owner: true),
                lastReply: [
                  TweetEntity(
                    id: 'id_3',
                    userName: 'user_3',
                    clientId: 3,
                    createdAt: '2020-06-09',
                    totalReply: 0,
                    totalLikes: 1,
                    anonymous: false,
                    content: 'just replied',
                    avatar: 'http://site.com/2.svg',
                    meta: const TweetMeta(liked: false, owner: false),
                    lastReply: const [],
                  ),
                ],
              ),
            ],
          );
        });

        test(
          'should remove tweet',
          () async {
            // arrange
            final tweet = TweetEntity(
              id: 'id_1',
              userName: 'user_1',
              clientId: 1,
              createdAt: '2002-01-01',
              totalReply: 0,
              totalLikes: 0,
              anonymous: true,
              content: 'content 1',
              avatar: 'http://site.com/1.svg',
              meta: const TweetMeta(liked: false, owner: true),
              lastReply: const [],
            );

            final sut = FeedUseCases(
              repository: repository,
              filterPreference: filterPreference,
              maxRows: maxRowsPerRequest,
            );

            final expected = right(
              FeedCache(
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
                  ),
                ],
              ),
            );

            when(() => repository.fetch(option: any(named: 'option')))
                .thenAnswer((_) async => right(firstSessionResponse));
            await sut.fetchNewestTweet();

            when(() => repository.delete(option: any(named: 'option')))
                .thenAnswer((_) async => right(const ValidField()));
            // act
            final received = await sut.delete(tweet);
            // assert
            expect(expected, received);
          },
        );

        test('remove replied tweet', () async {
          // arrange
          final tweet = TweetEntity(
            id: 'id_3',
            parentId: 'id_1',
            userName: 'user_3',
            clientId: 3,
            createdAt: '2020-06-09',
            totalReply: 0,
            totalLikes: 1,
            anonymous: false,
            content: 'just replied',
            avatar: 'http://site.com/2.svg',
            meta: const TweetMeta(liked: false, owner: false),
            lastReply: const [],
          );

          final sut = FeedUseCases(
            repository: repository,
            filterPreference: filterPreference,
            maxRows: maxRowsPerRequest,
          );

          final expected = right(
            FeedCache(
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
                ),
              ],
            ),
          );

          when(() => repository.fetch(option: any(named: 'option')))
              .thenAnswer((_) async => right(firstSessionResponse));
          await sut.fetchNewestTweet();

          when(() => repository.delete(option: any(named: 'option')))
              .thenAnswer((_) async => right(const ValidField()));
          // act
          final received = await sut.delete(tweet);
          // assert
          expect(received, expected);
        });
      },
    );
  });
}
