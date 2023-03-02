import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/feed/data/datasources/impl/tweet_in_memory_data_source.dart';
import 'package:penhas/app/features/feed/data/models/tweet_model.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';

class MockTweetTiles extends Mock implements TweetTiles {}

class MockTweetModel extends Mock implements TweetModel {}

void main() {
  group(TweetInMemoryDataSource, () {
    setUp(() {
      /// Mocks:
      /// - tweet without reply
      /// - tweet with reply
      /// - tweet in both cache and details
      /// - tweet in both details and last reply
      /// - tweet with subcomments

      // ignore: unused_local_variable
      final relatedTweets = {
        '789012345': [
          TweetModel(
            id: '901234567',
            userName: 'Grace',
            clientId: 222324,
            createdAt: '2022-02-24 13:30:00',
            totalReply: 0,
            totalLikes: 2,
            anonymous: true,
            content:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            avatar: 'https://example.com/anonymous.png',
            meta: const TweetMeta(liked: false, owner: false),
            lastReply: const [],
          ),
        ],
      };
    });

    test(
      'getAll returns a stream of tweet tiles',
      () {
        // arrange
        final dataSource = TweetInMemoryDataSource();

        // act
        final result = dataSource.getTweets();

        // assert
        expect(result, emits([]));
      },
    );

    group('getRelatedTweets', () {
      test(
        'emits an empty tweet list when has no data',
        () {
          // arrange
          final dataSource = TweetInMemoryDataSource();

          // act
          final result = dataSource.getRelatedTweets('987654321');

          // assert
          expect(result, emits([]));
        },
      );

      test(
        'emits a list with tweet from list cache when related tweet is empty',
        () {
          // arrange
          final tweets = [
            TweetModel(
              id: '987654321',
              userName: 'Sophie',
              clientId: 282930,
              createdAt: '2022-02-24 15:00:00',
              totalReply: 2,
              totalLikes: 4,
              anonymous: false,
              content:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              avatar: 'https://example.com/avatar.png',
              meta: const TweetMeta(liked: false, owner: false),
              lastReply: const [],
            ),
          ];
          final dataSource = TweetInMemoryDataSource.withInitialData(
            tweetListCache: tweets,
            relatedTweetsCache: {},
          );

          // act
          final result = dataSource.getRelatedTweets('987654321');

          // assert
          expect(result, emits(tweets));
        },
      );

      test(
        'emits a list of tweet models for a given id',
        () {
          // arrange
          final tweets = [
            TweetModel(
              id: '456789012',
              userName: 'Emily',
              clientId: 101112,
              createdAt: '2022-02-23 09:15:00',
              totalReply: 0,
              totalLikes: 1,
              anonymous: false,
              content:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              avatar: 'https://example.com/avatar.png',
              meta: const TweetMeta(liked: false, owner: false),
              lastReply: const [],
            ),
            TweetModel(
              id: '567890123',
              userName: 'Jessica',
              clientId: 131415,
              createdAt: '2022-02-23 10:00:00',
              totalReply: 3,
              totalLikes: 10,
              anonymous: false,
              content:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              avatar: 'https://example.com/avatar.png',
              meta: const TweetMeta(liked: false, owner: false),
              lastReply: const [],
            ),
          ];
          final dataSource = TweetInMemoryDataSource.withInitialData(
            relatedTweetsCache: {'456789012': tweets},
          );

          // act
          final result = dataSource.getRelatedTweets('456789012');

          // assert
          expect(result, emits(tweets));
        },
      );
    });

    group('replaceAll', () {
      test(
        'replaces all tweets with the given tweets',
        () async {
          // arrange
          final tweets = [
            TweetModel(
              id: '012345678',
              userName: 'Lily',
              clientId: 252627,
              createdAt: '2022-02-24 14:15:00',
              totalReply: 4,
              totalLikes: 8,
              anonymous: false,
              content:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              avatar: 'https://example.com/avatar.png',
              meta: const TweetMeta(liked: false, owner: false),
              lastReply: const [],
            ),
          ];
          final dataSource = TweetInMemoryDataSource();
          final stream = dataSource.getTweets();

          // act
          dataSource.replaceAll(tweets);

          // assert
          expect(stream, emitsThrough(tweets));
        },
      );
    });

    group('append', () {
      test(
        'should appends the given tweets to tweet list',
        () async {
          // arrange
          final firstTwet = TweetModel(
            id: '123456789',
            userName: 'Alice',
            clientId: 123,
            createdAt: '2022-02-22 15:30:00',
            totalReply: 1,
            totalLikes: 3,
            anonymous: false,
            content:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            avatar: 'https://example.com/avatar.png',
            meta: const TweetMeta(liked: false, owner: false),
            lastReply: const [],
          );
          final lastTweet = TweetModel(
            id: '345678901',
            userName: 'Sarah',
            clientId: 789,
            createdAt: '2022-02-22 17:00:00',
            totalReply: 2,
            totalLikes: 5,
            anonymous: false,
            content:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            avatar: 'https://example.com/avatar.png',
            meta: const TweetMeta(liked: false, owner: false),
            lastReply: const [],
          );
          final expeced = [firstTwet, lastTweet];
          final dataSource = TweetInMemoryDataSource.withInitialData(
            tweetListCache: [firstTwet],
          );
          final stream = dataSource.getTweets();

          // act
          dataSource.append([lastTweet]);

          // assert
          expect(stream, emitsThrough(expeced));
        },
      );

      test(
        'should create related tweet list and appends the given tweets to related tweet list',
        () async {
          // arrange
          final firstTwet = TweetModel(
            id: '234567890',
            userName: 'Bianca',
            clientId: 456,
            createdAt: '2022-02-22 16:45:00',
            totalReply: 0,
            totalLikes: 0,
            anonymous: true,
            content:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            avatar: 'https://example.com/anonymous.png',
            meta: const TweetMeta(liked: false, owner: false),
            lastReply: const [],
          );
          final lastTweet = TweetModel(
            id: '567890123',
            parentId: '234567890',
            userName: 'Jessica',
            clientId: 131415,
            createdAt: '2022-02-23 10:00:00',
            totalReply: 3,
            totalLikes: 10,
            anonymous: false,
            content:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            avatar: 'https://example.com/avatar.png',
            meta: const TweetMeta(liked: false, owner: false),
            lastReply: const [],
          );
          final expeced = [firstTwet, lastTweet];
          final dataSource = TweetInMemoryDataSource.withInitialData(
            tweetListCache: [firstTwet],
          );
          final stream = dataSource.getRelatedTweets('234567890');

          // act
          dataSource.append([lastTweet], parentId: '234567890');

          // assert
          expect(stream, emitsThrough(expeced));
        },
      );

      test(
        'should appends the given tweets to related tweet list',
        () async {
          // arrange
          final firstTwet = TweetModel(
            id: '456789012',
            userName: 'Emily',
            clientId: 101112,
            createdAt: '2022-02-23 09:15:00',
            totalReply: 0,
            totalLikes: 1,
            anonymous: false,
            content:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            avatar: 'https://example.com/avatar.png',
            meta: const TweetMeta(liked: false, owner: false),
            lastReply: const [],
          );
          final lastTweet = TweetModel(
            id: '678901234',
            parentId: '456789012',
            userName: 'Olivia',
            clientId: 161718,
            createdAt: '2022-02-23 11:30:00',
            totalReply: 1,
            totalLikes: 2,
            anonymous: true,
            content:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            avatar: 'https://example.com/anonymous.png',
            meta: const TweetMeta(liked: false, owner: false),
            lastReply: const [],
          );
          final expeced = [firstTwet, lastTweet];
          final dataSource = TweetInMemoryDataSource.withInitialData(
            relatedTweetsCache: {
              '456789012': [firstTwet]
            },
          );
          final stream = dataSource.getRelatedTweets('456789012');

          // act
          dataSource.append([lastTweet], parentId: '456789012');

          // assert
          expect(stream, emitsThrough(expeced));
        },
      );
    });

    group('prepend', () {
      test(
        'should prepends the given tweets',
        () async {
          // arrange
          final firstTwet = TweetModel(
            id: '789012345',
            userName: 'Rachel',
            clientId: 192021,
            createdAt: '2022-02-24 12:00:00',
            totalReply: 5,
            totalLikes: 7,
            anonymous: false,
            content:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            avatar: 'https://example.com/avatar.png',
            meta: const TweetMeta(liked: false, owner: false),
            lastReply: const [],
          );
          final lastTweet = TweetModel(
            id: '789012345',
            userName: 'Rachel',
            clientId: 192021,
            createdAt: '2022-02-24 12:00:00',
            totalReply: 5,
            totalLikes: 7,
            anonymous: false,
            content:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            avatar: 'https://example.com/avatar.png',
            meta: const TweetMeta(liked: false, owner: false),
            lastReply: const [],
          );
          final expeced = [firstTwet, lastTweet];
          final dataSource = TweetInMemoryDataSource.withInitialData(
            tweetListCache: [lastTweet],
          );
          final stream = dataSource.getTweets();

          // act
          dataSource.prepend([firstTwet]);

          // assert
          expect(stream, emitsThrough(expeced));
        },
      );
    });

    group('update', () {
      test(
        'updates a tweet',
        () async {
          // TODO
        },
      );
    });

    group('remove', () {
      test(
        'removes a tweet',
        () async {
          // TODO
        },
      );
    });
  });
}
