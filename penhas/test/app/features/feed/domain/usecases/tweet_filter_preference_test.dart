import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_filter_session_entity.dart';
import 'package:penhas/app/features/feed/domain/usecases/tweet_filter_preference.dart';

class MockTweetRepository extends Mock implements ITweetRepository {}

void main() {
  TweetFilterPreference sut;
  ITweetRepository mockRepository;
  TweetFilterSessionEntity response;

  setUp(() {
    mockRepository = MockTweetRepository();
    sut = TweetFilterPreference(repository: mockRepository);
    response = TweetFilterSessionEntity(categories: [
      TweetFilterCategory(id: '1', isDefault: true, label: 'C 1'),
      TweetFilterCategory(id: '2', isDefault: false, label: 'C 2'),
    ], tags: [
      TweetFilterTag(id: '1', title: 'Tag - 1'),
      TweetFilterTag(id: '2', title: 'Tag - 2')
    ]);
  });

  group('TweetFilterPreference', () {
    test('should retrieve tag and categories list from server', () async {
      // arrange
      when(mockRepository.retreive()).thenAnswer((_) async => right(response));

      final expected = right(TweetFilterSessionEntity(categories: [
        TweetFilterCategory(id: '1', isDefault: true, label: 'C 1'),
        TweetFilterCategory(id: '2', isDefault: false, label: 'C 2'),
      ], tags: [
        TweetFilterTag(id: '1', title: 'Tag - 1'),
        TweetFilterTag(id: '2', title: 'Tag - 2')
      ]));
      // act
      final received = await sut.retreive();
      // assert
      expect(received, expected);
    });
  });
}
