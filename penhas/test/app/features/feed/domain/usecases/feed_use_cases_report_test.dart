import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/repositories/i_tweet_repositories.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_use_cases.dart';

class MockTweetRepository extends Mock implements ITweetRepository {}

void main() {
  ITweetRepository repository;
  IAppConfiguration appConfiguration;

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
    group('report', () {
      int maxRowsPerRequet;
      ValidField validField;

      setUp(() {
        maxRowsPerRequet = 5;
        validField = ValidField(message: 'Report enviado');
      });

      test('should get message from server', () async {
        // arrange
        final sut = FeedUseCases(
          repository: repository,
          maxRows: maxRowsPerRequet,
        );

        final expected = right(validField);
        final tweet = TweetEntity(
            id: 'id_1',
            userName: 'userName',
            clientId: 1,
            createdAt: '2020-01-01 01-01-01',
            totalReply: 0,
            totalLikes: 0,
            anonymous: false,
            content: 'content 1',
            avatar: 'https://site.com/avatar.svg',
            meta: TweetMeta(liked: false, owner: false));

        when(repository.report(option: anyNamed('option')))
            .thenAnswer((_) async => right(validField));
        // act
        final received = await sut.report(tweet, 'reason');
        // assert
        expect(expected, received);
      });
    });
  });
}
