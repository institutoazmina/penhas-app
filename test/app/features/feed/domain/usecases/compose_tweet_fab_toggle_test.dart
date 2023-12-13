import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/escape_manual/domain/escape_manual_toggle.dart';
import 'package:penhas/app/features/feed/domain/usecases/compose_tweet_fab_toggle.dart';
import 'package:penhas/app/features/feed/domain/usecases/tweet_toggle_feature.dart';

class MockEscapeManualToggleFeature extends Mock
    implements EscapeManualToggleFeature {}

class MockTweetToggleFeature extends Mock implements TweetToggleFeature {}

void main() {
  late ComposeTweetFabToggleFeature sut;

  late EscapeManualToggleFeature mockEscapeManualToggleFeature;
  late TweetToggleFeature mockTweetToggleFeature;

  setUp(() {
    mockEscapeManualToggleFeature = MockEscapeManualToggleFeature();
    mockTweetToggleFeature = MockTweetToggleFeature();

    sut = ComposeTweetFabToggleFeature(
      escapeManualToggleFeature: mockEscapeManualToggleFeature,
      tweetToggleFeature: mockTweetToggleFeature,
    );
  });

  group('ComposeTweetFabToggleFeature', () {
    test(
      'should call escape manual toggle feature isEnabled',
      () async {
        // arrange
        when(() => mockEscapeManualToggleFeature.isEnabled)
            .thenAnswer((_) async => true);
        when(() => mockTweetToggleFeature.isEnabled)
            .thenAnswer((_) async => true);

        // act
        await sut.isEnabled;

        // assert
        verify(() => mockEscapeManualToggleFeature.isEnabled).called(1);
      },
    );

    test(
      'should call tweet toggle feature isEnabled',
      () async {
        // arrange
        when(() => mockEscapeManualToggleFeature.isEnabled)
            .thenAnswer((_) async => true);
        when(() => mockTweetToggleFeature.isEnabled)
            .thenAnswer((_) async => true);

        // act
        await sut.isEnabled;

        // assert
        verify(() => mockTweetToggleFeature.isEnabled).called(1);
      },
    );

    test('should return true when all features are enabled', () async {
      // arrange
      when(() => mockEscapeManualToggleFeature.isEnabled)
          .thenAnswer((_) async => true);
      when(() => mockTweetToggleFeature.isEnabled)
          .thenAnswer((_) async => true);

      // act
      final result = await sut.isEnabled;

      // assert
      expect(result, true);
    });

    test('should return false when only escape manual feature is disabled',
        () async {
      // arrange
      when(() => mockEscapeManualToggleFeature.isEnabled)
          .thenAnswer((_) async => false);
      when(() => mockTweetToggleFeature.isEnabled)
          .thenAnswer((_) async => true);

      // act
      final result = await sut.isEnabled;

      // assert
      expect(result, false);
    });

    test('should return false when only tweet feature is disabled', () async {
      // arrange
      when(() => mockEscapeManualToggleFeature.isEnabled)
          .thenAnswer((_) async => true);
      when(() => mockTweetToggleFeature.isEnabled)
          .thenAnswer((_) async => false);

      // act
      final result = await sut.isEnabled;

      // assert
      expect(result, false);
    });

    test('should return false when both features is disabled', () async {
      // arrange
      when(() => mockEscapeManualToggleFeature.isEnabled)
          .thenAnswer((_) async => false);
      when(() => mockTweetToggleFeature.isEnabled)
          .thenAnswer((_) async => false);

      // act
      final result = await sut.isEnabled;

      // assert
      expect(result, false);
    });
  });
}
