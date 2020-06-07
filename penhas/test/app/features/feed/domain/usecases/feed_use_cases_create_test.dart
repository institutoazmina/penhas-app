import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
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
    group('create', () {
      int maxRowsPerRequet;

      setUp(() {
        maxRowsPerRequet = 5;
      });

      test('should create tweet', () async {
        // arrange
        final sut = FeedUseCases(
          repository: repository,
          maxRows: maxRowsPerRequet,
        );
        final expected = right(ValidField());
        when(repository.create(option: anyNamed('option')))
            .thenAnswer((_) async => right(ValidField()));
        // act
        final received = await sut.create('New content');
        // assert
        expect(expected, received);
      });
    });
  });
}
