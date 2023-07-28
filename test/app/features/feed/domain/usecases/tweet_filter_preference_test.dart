// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/feed/data/repositories/tweet_filter_preference_repository.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_filter_session_entity.dart';
import 'package:penhas/app/features/feed/domain/usecases/tweet_filter_preference.dart';

class MockTweetFilterPreferenceRepository extends Mock
    implements ITweetFilterPreferenceRepository {}

void main() {
  late TweetFilterPreference sut;
  late TweetFilterSessionEntity response;
  late ITweetFilterPreferenceRepository mockRepository;

  setUp(() {
    mockRepository = MockTweetFilterPreferenceRepository();

    response = TweetFilterSessionEntity(
      categories: const [
        TweetFilterEntity(id: '1', isSelected: true, label: 'C 1'),
        TweetFilterEntity(id: '2', isSelected: false, label: 'C 2'),
      ],
      tags: const [
        TweetFilterEntity(id: '1', isSelected: false, label: 'Tag - 1'),
        TweetFilterEntity(id: '2', isSelected: false, label: 'Tag - 2'),
        TweetFilterEntity(id: '3', isSelected: false, label: 'Tag - 3')
      ],
    );

    sut = TweetFilterPreference(
      repository: mockRepository,
    );
  });

  group(TweetFilterPreference, () {
    test(
      'retrieve tag and categories list from server',
      () async {
        // arrange
        when(() => mockRepository.retrieve())
            .thenAnswer((_) async => right(response));

        final expected = right(
          const TweetFilterSessionEntity(
            categories: [
              TweetFilterEntity(id: '1', isSelected: true, label: 'C 1'),
              TweetFilterEntity(id: '2', isSelected: false, label: 'C 2'),
            ],
            tags: [
              TweetFilterEntity(id: '1', isSelected: false, label: 'Tag - 1'),
              TweetFilterEntity(id: '2', isSelected: false, label: 'Tag - 2'),
              TweetFilterEntity(id: '3', isSelected: false, label: 'Tag - 3')
            ],
          ),
        );
        // act
        final received = await sut.retrieve();
        // assert
        expect(received, expected);
      },
    );

    test(
      'retrieve updated tag and categories list from server',
      () async {
        // arrange
        when(() => mockRepository.retrieve())
            .thenAnswer((_) async => right(response));
        final expected = right(
          const TweetFilterSessionEntity(
            categories: [
              TweetFilterEntity(id: '1', isSelected: false, label: 'C 1'),
              TweetFilterEntity(id: '2', isSelected: true, label: 'C 2'),
            ],
            tags: [
              TweetFilterEntity(id: '1', isSelected: false, label: 'Tag - 1'),
              TweetFilterEntity(id: '2', isSelected: true, label: 'Tag - 2'),
              TweetFilterEntity(id: '3', isSelected: true, label: 'Tag - 3')
            ],
          ),
        );
        // act
        sut.categories = ['2'];
        sut.saveTags(['2', '3']);

        final received = await sut.retrieve();
        // assert
        expect(received, expected);
      },
    );
    test(
      'retrieve tags preference',
      () async {
        // arrange
        sut.saveTags(['1', '2']);
        final expected = ['1', '2'];
        // act
        final received = sut.getTags();
        // assert
        expect(received, expected);
      },
    );
  });
}
