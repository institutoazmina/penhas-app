import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/features/feed/data/repositories/tweet_filter_preference_repository.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_filter_session_entity.dart';
import 'package:penhas/app/features/feed/domain/usecases/tweet_filter_preference.dart';

class MockTweetRepository extends Mock
    implements ITweetFilterPreferenceRepository {}

void main() {
  TweetFilterPreference sut;
  ITweetFilterPreferenceRepository mockRepository;
  TweetFilterSessionEntity response;

  setUp(() {
    mockRepository = MockTweetRepository();
    sut = TweetFilterPreference(
      repository: mockRepository,
    );
    response = TweetFilterSessionEntity(categories: [
      TweetFilterEntity(id: '1', isSelected: true, label: 'C 1'),
      TweetFilterEntity(id: '2', isSelected: false, label: 'C 2'),
    ], tags: [
      TweetFilterEntity(id: '1', isSelected: false, label: 'Tag - 1'),
      TweetFilterEntity(id: '2', isSelected: false, label: 'Tag - 2'),
      TweetFilterEntity(id: '3', isSelected: false, label: 'Tag - 3')
    ]);
  });

  group('TweetFilterPreference', () {
    test('should retrieve tag and categories list from server', () async {
      // arrange
      when(mockRepository.retreive()).thenAnswer((_) async => right(response));

      final expected = right(TweetFilterSessionEntity(categories: [
        TweetFilterEntity(id: '1', isSelected: true, label: 'C 1'),
        TweetFilterEntity(id: '2', isSelected: false, label: 'C 2'),
      ], tags: [
        TweetFilterEntity(id: '1', isSelected: false, label: 'Tag - 1'),
        TweetFilterEntity(id: '2', isSelected: false, label: 'Tag - 2'),
        TweetFilterEntity(id: '3', isSelected: false, label: 'Tag - 3')
      ]));
      // act
      final received = await sut.retreive();
      // assert
      expect(received, expected);
    });

    test('should retrieve upgated tag and categories list from server',
        () async {
      // arrange
      when(mockRepository.retreive()).thenAnswer((_) async => right(response));
      final expected = right(TweetFilterSessionEntity(categories: [
        TweetFilterEntity(id: '1', isSelected: false, label: 'C 1'),
        TweetFilterEntity(id: '2', isSelected: true, label: 'C 2'),
      ], tags: [
        TweetFilterEntity(id: '1', isSelected: false, label: 'Tag - 1'),
        TweetFilterEntity(id: '2', isSelected: true, label: 'Tag - 2'),
        TweetFilterEntity(id: '3', isSelected: true, label: 'Tag - 3')
      ]));
      // act
      sut.saveCategory(['2']);
      sut.saveTags(['2', '3']);

      final received = await sut.retreive();
      // assert
      expect(received, expected);
    });
    test('should retrieve categories preference', () async {
      // arrange
      sut.saveCategory(['1']);
      final expected = ['1'];
      // act
      final received = sut.getCategory();
      // assert
      expect(received, expected);
    });
    test('should retrieve tags preference', () async {
      // arrange
      sut.saveTags(['1', '2']);
      final expected = ['1', '2'];
      // act
      final received = sut.getTags();
      // assert
      expect(received, expected);
    });
  });
}
