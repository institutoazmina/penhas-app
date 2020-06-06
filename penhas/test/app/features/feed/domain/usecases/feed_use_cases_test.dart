import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/failures.dart';
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
    group('fetchNewestTweet', () {
      List<TweetEntity> firstTweetList;
      setUp(() {
        firstTweetList = [
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
          )
        ];
      });
      test('should get the newest tweets', () async {
        // arrange
        when(repository.retrieve(option: anyNamed('option')))
            .thenAnswer((_) async => right(TweetSessionEntity(
                  hasMore: true,
                  orderBy: TweetSessionOrder.latestFirst,
                  tweets: firstTweetList,
                )));

        final Either<Failure, List<TweetEntity>> expected =
            right(firstTweetList);
        final sut = FeedUseCases(repository: repository);
        // act
        final received = await sut.fetchNewestTweet();
        // assert
        expect(expected.getOrElse(() => null), received.getOrElse(() => null));
      });
    });
  });
}
