import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_session_entity.dart';
import 'package:penhas/app/features/feed/domain/repositories/i_tweet_repositories.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_use_cases.dart';

class MockTweetRepository extends Mock implements ITweetRepository {}

void main() {
  ITweetRepository repository;
  TweetEntity tweetRequest;
  int maxRowsPerRequest;

  setUp(() {
    repository = MockTweetRepository();
    maxRowsPerRequest = 2;
    tweetRequest = TweetEntity(
        id: 'id_1',
        userName: 'user_1',
        clientId: 1,
        createdAt: '1500-01-01 01:01:01',
        totalReply: 0,
        totalLikes: 0,
        anonymous: false,
        content: 'content 1',
        avatar: 'https:/site.com/avatas.svg',
        meta: TweetMeta(liked: false, owner: false));
  });

  group('FeedUseCases', () {
    test('should not hit datasource on instantiate', () async {
      // act
      FeedUseCases(repository: repository);
      // assert
      verifyNoMoreInteractions(repository);
    });
    group('fetchTweetDetail', () {
      TweetSessionEntity emptySession;
      TweetSessionEntity firstSession;

      setUp(() {
        emptySession = TweetSessionEntity(
          hasMore: false,
          orderBy: TweetSessionOrder.oldestFirst,
          tweets: [],
        );

        firstSession = TweetSessionEntity(
            hasMore: false,
            orderBy: TweetSessionOrder.oldestFirst,
            tweets: [
              tweetRequest.copyWith(
                  id: 'id_5',
                  userName: 'user_2',
                  clientId: 2,
                  content: 'reply 1')
            ]);
      });
      test('should request with parent_id and after', () async {
        // arrange
        when(repository.fetch(option: anyNamed('option')))
            .thenAnswer((_) async => right(emptySession));
        // act
        final sut = FeedUseCases(
          repository: repository,
          maxRows: maxRowsPerRequest,
        );
        await sut.fetchTweetDetail(tweetRequest);
        // assert
        verify(
          repository.fetch(
            option: TweetRequestOption(
              after: tweetRequest.id,
              parent: tweetRequest.id,
              rows: maxRowsPerRequest,
            ),
          ),
        );
      });
      test('should get empty response if tweet does not have detail', () async {
        // arrange
        when(repository.fetch(option: anyNamed('option')))
            .thenAnswer((_) async => right(emptySession));
        final sut = FeedUseCases(repository: repository);
        final expected = right(FeedCache(tweets: []));
        // act
        final received = await sut.fetchTweetDetail(tweetRequest);
        // assert
        expect(expected, received);
      });
      test('should get a list of tweet from detail', () async {
        // arrange
        when(repository.fetch(option: anyNamed('option')))
            .thenAnswer((_) async => right(firstSession));
        final sut = FeedUseCases(repository: repository);
        final expected = right(
          FeedCache(
            tweets: [
              tweetRequest.copyWith(
                id: 'id_5',
                userName: 'user_2',
                clientId: 2,
                content: 'reply 1',
              )
            ],
          ),
        );
        // act
        final received = await sut.fetchTweetDetail(tweetRequest);
        // assert
        expect(expected, received);
      });
    });
    group('fetchNewestTweetDetail', () {
      TweetSessionEntity firstSession;
      TweetSessionEntity secondSession;

      setUp(() {
        firstSession = TweetSessionEntity(
            hasMore: false,
            orderBy: TweetSessionOrder.oldestFirst,
            tweets: [
              tweetRequest.copyWith(
                  id: 'id_5',
                  userName: 'user_2',
                  clientId: 2,
                  content: 'reply 1'),
              tweetRequest.copyWith(
                  id: 'id_6',
                  userName: 'user_2',
                  clientId: 2,
                  content: 'reply 2'),
            ]);
      });
      test('should request with parent_id and after of last tweet', () async {
        // arrange
        when(repository.fetch(option: anyNamed('option')))
            .thenAnswer((_) async => right(firstSession));
        final afterTweet = tweetRequest.copyWith(
          id: 'id_6',
          userName: 'user_2',
          clientId: 2,
          content: 'reply 2',
        );
        final sut = FeedUseCases(
          repository: repository,
          maxRows: maxRowsPerRequest,
        );
        await sut.fetchTweetDetail(tweetRequest);
        // act
        await sut.fetchNewestTweetDetail(tweetRequest);
        // assert
        verify(
          repository.fetch(
            option: TweetRequestOption(
              after: afterTweet.id,
              parent: tweetRequest.id,
              rows: maxRowsPerRequest,
            ),
          ),
        );
      });
      // test('should get the newest tweets', () async {
      //   // arrange
      //   when(repository.fetch(option: anyNamed('option')))
      //       .thenAnswer((_) async => right(firstSession));
      //   FeedUseCases(repository: repository);

      //   // act
      //   final sut =
      //       FeedUseCases(repository: repository, maxRows: maxRowsPerRequest);
      //   final received = await sut.fetchNewestTweetDetail(tweetRequest);
      //   // assert
      //   expect(expected, received);
      // });
    });
  });
}
