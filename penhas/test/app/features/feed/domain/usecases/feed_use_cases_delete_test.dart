import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_session_entity.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_use_cases.dart';

import '../../../../../utils/helper.mocks.dart';

void main() {
  late final MockITweetRepository repository = MockITweetRepository();
  late final MockTweetFilterPreference filterPreference = MockTweetFilterPreference();

  setUp(() {
    when(filterPreference.getCategory()).thenReturn([]);
    when(filterPreference.getTags()).thenReturn([]);
  });

  group('FeedUseCases', () {
    test('should not hit datasource on instantiate', () async {
      // act
      FeedUseCases(repository: repository, filterPreference: filterPreference);
      // assert
      verifyNoMoreInteractions(repository);
    });
    group('delete', () {
      late int maxRowsPerRequet;
      late TweetSessionEntity firstSessionResponse;

      setUp(() {
        maxRowsPerRequet = 5;
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
              meta: TweetMeta(liked: false, owner: true),
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
              meta: TweetMeta(liked: false, owner: true),
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
                  meta: TweetMeta(liked: false, owner: false),
                  lastReply: const [],
                ),
              ],
            ),
          ],
        );
      });

      test('should remove tweet', () async {
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
          meta: TweetMeta(liked: false, owner: true),
          lastReply: const [],
        );

        final sut = FeedUseCases(
          repository: repository,
          filterPreference: filterPreference,
          maxRows: maxRowsPerRequet,
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
                meta: TweetMeta(liked: false, owner: true),
                lastReply: const [],
              ),
            ],
          ),
        );

        when(repository.fetch(option: anyNamed('option')))
            .thenAnswer((_) async => right(firstSessionResponse));
        await sut.fetchNewestTweet();

        when(repository.delete(option: anyNamed('option')))
            .thenAnswer((_) async => right(ValidField()));
        // act
        final received = await sut.delete(tweet);
        // assert
        expect(expected, received);
      });

      test('should remove replied tweet', () async {
        // arrange
        final tweet = TweetEntity(
          id: 'id_3',
          userName: 'user_3',
          clientId: 3,
          createdAt: '2020-06-09',
          totalReply: 0,
          totalLikes: 1,
          anonymous: false,
          content: 'just replied',
          avatar: 'http://site.com/2.svg',
          meta: TweetMeta(liked: false, owner: false),
          lastReply: const [],
        );

        final sut = FeedUseCases(
          repository: repository,
          filterPreference: filterPreference,
          maxRows: maxRowsPerRequet,
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
                meta: TweetMeta(liked: false, owner: true),
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
                meta: TweetMeta(liked: false, owner: true),
                lastReply: const [],
              ),
            ],
          ),
        );

        when(repository.fetch(option: anyNamed('option')))
            .thenAnswer((_) async => right(firstSessionResponse));
        await sut.fetchNewestTweet();

        when(repository.delete(option: anyNamed('option')))
            .thenAnswer((_) async => right(ValidField()));
        // act
        final received = await sut.delete(tweet);
        // assert
        expect(expected, received);
      });
    });
  });
}
