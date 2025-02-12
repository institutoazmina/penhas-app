import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_engage_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_request_option.dart';
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
    registerFallbackValue(TweetCreateRequestOption(message: ''));
  });

  group(FeedUseCases, () {
    test('do not hit datasource on instantiate', () async {
      // act
      FeedUseCases(repository: repository, filterPreference: filterPreference);
      // assert
      verifyNoMoreInteractions(repository);
    });
    group('create()', () {
      late int maxRowsPerRequest;

      setUp(() {
        maxRowsPerRequest = 5;
      });

      test(
        'create tweet',
        () async {
          // arrange
          final sut = FeedUseCases(
            repository: repository,
            filterPreference: filterPreference,
            maxRows: maxRowsPerRequest,
          );
          when(() => repository.create(option: any(named: 'option')))
              .thenAnswer(
            (_) async => right(
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
                badges: [],
              ),
            ),
          );
          final expected = right(
            FeedCache(
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
                  badges: [],
                ),
              ],
            ),
          );
          // act
          final received = await sut.create('Mensagem 1');
          // assert
          expect(expected, received);
        },
      );
    });
  });
}
