import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
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
    group('create', () {
      int? maxRowsPerRequet;

      setUp(() {
        maxRowsPerRequet = 5;
      });

      test('should create tweet', () async {
        // arrange
        final sut = FeedUseCases(
          repository: repository,
          filterPreference: filterPreference,
          maxRows: maxRowsPerRequet,
        );
        when(repository.create(option: anyNamed('option')))
            .thenAnswer((_) async => right(
                  TweetEntity(
                      id: '200608T1805540001',
                      userName: 'maria',
                      clientId: 424,
                      createdAt: '2020-06-08 18:05:54',
                      totalReply: 0,
                      totalLikes: 0,
                      anonymous: false,
                      content: 'Mensagem 1',
                      avatar:
                          'https://elasv2-api.appcivico.com/avatar/padrao.svg',
                      meta: const TweetMeta(liked: false, owner: true),
                      lastReply: const [],),
                ),);
        final expected = right(FeedCache(
          tweets: [
            TweetEntity(
              id: '200608T1805540001',
              userName: 'maria',
              clientId: 424,
              createdAt: '2020-06-08 18:05:54',
              totalReply: 0,
              totalLikes: 0,
              anonymous: false,
              content: 'Mensagem 1',
              avatar: 'https://elasv2-api.appcivico.com/avatar/padrao.svg',
              meta: const TweetMeta(liked: false, owner: true),
              lastReply: const [],
            ),
          ],
        ),);
        // act
        final received = await sut.create('Mensagem 1');
        // assert
        expect(expected, received);
      });
    });
  });
}
