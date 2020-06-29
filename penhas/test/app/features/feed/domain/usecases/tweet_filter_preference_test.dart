import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_filter_session_entity.dart';
import 'package:penhas/app/features/feed/domain/usecases/tweet_filter_preference.dart';

class MockTweetRepository extends Mock implements ITweetRepository {}

class MockAppConfiguration extends Mock implements IAppConfiguration {}

void main() {
  TweetFilterPreference sut;
  ITweetRepository mockRepository;
  IAppConfiguration mockConfiguration;
  TweetFilterSessionEntity response;

  setUp(() {
    mockRepository = MockTweetRepository();
    mockConfiguration = MockAppConfiguration();
    sut = TweetFilterPreference(
      repository: mockRepository,
      appConfiguration: mockConfiguration,
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
      when(mockConfiguration.getCategoryPreference())
          .thenAnswer((_) async => ['2']);
      when(mockConfiguration.getTagsPreference())
          .thenAnswer((_) async => ['2', '3']);

      final expected = right(TweetFilterSessionEntity(categories: [
        TweetFilterEntity(id: '1', isSelected: false, label: 'C 1'),
        TweetFilterEntity(id: '2', isSelected: true, label: 'C 2'),
      ], tags: [
        TweetFilterEntity(id: '1', isSelected: false, label: 'Tag - 1'),
        TweetFilterEntity(id: '2', isSelected: true, label: 'Tag - 2'),
        TweetFilterEntity(id: '3', isSelected: true, label: 'Tag - 3')
      ]));
      // act
      final received = await sut.retreive();
      // assert
      expect(received, expected);
    });
    test('should store categories preference', () async {
      // arrange
      final categories = [
        TweetFilterEntity(id: '1', isSelected: true, label: 'C 1'),
      ];
      final codes = categories.map((e) => e.id).toList();
      when(mockConfiguration.saveCategoryPreference(codes: anyNamed('codes')))
          .thenAnswer((_) async => codes);
      // act
      await sut.saveCategory(categories);
      // assert
      verify(mockConfiguration.saveCategoryPreference(codes: codes));
    });

    test('should retrieve categories preference', () async {
      // arrange
      when(mockConfiguration.getCategoryPreference())
          .thenAnswer((_) async => ['1']);
      final expected = ['1'];
      // act
      final received = await sut.getCategory();
      // assert
      expect(received, expected);
    });

    test('should store tags preference', () async {
      // arrange
      final categories = [
        TweetFilterEntity(id: '1', isSelected: false, label: 'T-1'),
        TweetFilterEntity(id: '2', isSelected: false, label: 'T-2'),
      ];
      final codes = categories.map((e) => e.id).toList();
      when(mockConfiguration.saveTagsPreference(codes: anyNamed('codes')))
          .thenAnswer((_) async => codes);
      // act
      await sut.saveTags(categories);
      // assert
      verify(mockConfiguration.saveTagsPreference(codes: codes));
    });

    test('should retrieve tags preference', () async {
      // arrange
      when(mockConfiguration.getTagsPreference())
          .thenAnswer((_) async => ['1', '2']);
      final expected = ['1', '2'];
      // act
      final received = await sut.getTags();
      // assert
      expect(received, expected);
    });
  });
}
