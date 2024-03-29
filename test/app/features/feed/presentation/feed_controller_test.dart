// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/states/feed_security_state.dart';
import 'package:penhas/app/features/feed/domain/states/feed_state.dart';
import 'package:penhas/app/features/feed/domain/usecases/compose_tweet_fab_toggle.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_use_cases.dart';
import 'package:penhas/app/features/feed/presentation/feed_controller.dart';
import 'package:penhas/app/features/help_center/domain/usecases/security_mode_action_feature.dart';

import '../../../../utils/completer.dart';

class MockFeedUseCases extends Mock implements FeedUseCases {}

class MockSecurityModeActionFeature extends Mock
    implements SecurityModeActionFeature {}

class MockTweet extends Mock implements TweetTiles {}

class MockComposeTweetFabToggleFeature extends Mock
    implements ComposeTweetFabToggleFeature {}

void main() {
  group(FeedController, () {
    late FeedController controller;

    late FeedUseCases mockFeedUseCases;
    late SecurityModeActionFeature mockSecurityModeActionFeature;
    late MockComposeTweetFabToggleFeature mockComposeTweetFabToggleFeature;

    late StreamController<FeedCache> feedCacheStreamCtrl;
    late Completer<TFeed> fetchNewestTweetCompleter;
    late Completer<bool> securityModeActionFeatureCompleter;
    late Completer<bool> composeTweetFabToggleFeatureCompleter;

    setUp(() {
      mockFeedUseCases = MockFeedUseCases();
      mockSecurityModeActionFeature = MockSecurityModeActionFeature();
      mockComposeTweetFabToggleFeature = MockComposeTweetFabToggleFeature();

      feedCacheStreamCtrl = StreamController.broadcast();
      fetchNewestTweetCompleter = Completer();
      securityModeActionFeatureCompleter = Completer();
      composeTweetFabToggleFeatureCompleter = Completer();

      when(() => mockFeedUseCases.fetchNewestTweet())
          .thenAnswer((_) => fetchNewestTweetCompleter.future);
      when(() => mockSecurityModeActionFeature.isEnabled)
          .thenAnswer((_) => securityModeActionFeatureCompleter.future);
      when(() => mockComposeTweetFabToggleFeature.isEnabled)
          .thenAnswer((_) => composeTweetFabToggleFeatureCompleter.future);
      when(() => mockFeedUseCases.tweetList())
          .thenAnswer((_) => feedCacheStreamCtrl.stream);

      controller = FeedController(
        useCase: mockFeedUseCases,
        securityModeActionFeature: mockSecurityModeActionFeature,
        composeTweetFabToggleFeature: mockComposeTweetFabToggleFeature,
      );
    });

    test(
      'should set state to initial and fetch newest tweets on initialization',
      () async {
        // assert
        expect(controller.state, equals(FeedState.initial()));
        verify(() => mockFeedUseCases.tweetList()).called(1);
        verify(() => mockFeedUseCases.fetchNewestTweet()).called(1);
        verifyNoMoreInteractions(mockFeedUseCases);
      },
    );

    test(
      'should set state to loaded when receive new tweets from stream',
      () async {
        // arrange
        final mockTweets = [MockTweet(), MockTweet()];

        // act
        feedCacheStreamCtrl.add(FeedCache(tweets: mockTweets));
        await Future.delayed(Duration.zero); // dispatch stream

        // assert
        expect(controller.state, FeedState.loaded(mockTweets));
      },
    );

    test(
      'should set securityState to disable and check if SecurityModeActionFeature is enabled on initialization',
      () async {
        // assert
        verify(() => mockSecurityModeActionFeature.isEnabled).called(1);
        expect(controller.securityState, FeedSecurityState.disable());
        verifyNoMoreInteractions(mockSecurityModeActionFeature);
      },
    );

    test(
      'should set securityState to enable when SecurityModeActionFeature is true',
      () async {
        // act
        await securityModeActionFeatureCompleter.completeAndWait(true);

        // assert
        expect(controller.securityState, FeedSecurityState.enable());
      },
    );

    test(
      'should set securityState to disable when SecurityModeActionFeature is false',
      () async {
        // act
        await securityModeActionFeatureCompleter.completeAndWait(false);

        // assert
        expect(controller.securityState, FeedSecurityState.disable());
      },
    );

    group('fetchNextPage', () {
      late Completer<TFeed> fetchNewestTweetCompleter;

      setUp(() async {
        fetchNewestTweetCompleter = Completer();

        when(() => mockFeedUseCases.fetchNewestTweet())
            .thenAnswer((_) => fetchNewestTweetCompleter.future);

        controller = FeedController(
          useCase: mockFeedUseCases,
          securityModeActionFeature: mockSecurityModeActionFeature,
          composeTweetFabToggleFeature: mockComposeTweetFabToggleFeature,
        );
      });

      test(
        'should call fetchNewestTweet when fetchNextPage is called',
        () async {
          // arrange
          await fetchNewestTweetCompleter
              .completeAndWait(right(FeedCache(tweets: [])));
          clearInteractions(mockFeedUseCases);

          // act
          controller.fetchNextPage();

          // assert
          verify(() => mockFeedUseCases.fetchNewestTweet()).called(1);
          verifyNoMoreInteractions(mockFeedUseCases);
        },
      );

      test(
        'should set state to error on fetchNextPage failure when feed is empty',
        () async {
          // arrange
          await fetchNewestTweetCompleter
              .completeAndWait(left(ServerFailure()));

          // act
          await controller.fetchNextPage();

          // assert
          expect(
            controller.state,
            FeedState.error(
              'O servidor está com problema neste momento, tente novamente.',
            ),
          );
        },
      );

      test(
        'should set errorMessage on fetchNextPage failure when feed is not empty',
        () async {
          // arrange
          feedCacheStreamCtrl
              .add(FeedCache(tweets: [MockTweet(), MockTweet()]));
          await fetchNewestTweetCompleter
              .completeAndWait(left(ServerFailure()));

          // act
          await controller.fetchNextPage();

          // assert
          expect(
            controller.errorMessage,
            'O servidor está com problema neste momento, tente novamente.',
          );
        },
      );
    });

    group('fetchOldestPage', () {
      late Completer<TFeed> fetchOldestTweetCompleter;

      setUp(() async {
        fetchOldestTweetCompleter = Completer();

        when(() => mockFeedUseCases.fetchOldestTweet())
            .thenAnswer((_) => fetchOldestTweetCompleter.future);

        await fetchNewestTweetCompleter
            .completeAndWait(right(FeedCache(tweets: [])));
      });

      test(
        'should invoke fetchOldestTweet',
        () async {
          // arrange
          clearInteractions(mockFeedUseCases);

          // act
          controller.fetchOldestPage();

          // assert
          verify(() => mockFeedUseCases.fetchOldestTweet()).called(1);
          verifyNoMoreInteractions(mockFeedUseCases);
        },
      );

      test(
        'should set state to error on failure and feed is empty',
        () async {
          // act
          controller.fetchOldestPage();
          await fetchOldestTweetCompleter
              .completeAndWait(left(InternetConnectionFailure()));

          // assert
          expect(
            controller.state,
            FeedState.error(
              'O servidor está inacessível, o PenhaS está com acesso à Internet?',
            ),
          );
        },
      );

      test(
        'should set errorMessage on failure and feed is not empty',
        () async {
          // arrange
          feedCacheStreamCtrl
              .add(FeedCache(tweets: [MockTweet(), MockTweet()]));

          // act
          controller.fetchOldestPage();
          await fetchOldestTweetCompleter
              .completeAndWait(left(InternetConnectionFailure()));

          // assert
          expect(
            controller.errorMessage,
            'O servidor está inacessível, o PenhaS está com acesso à Internet?',
          );
        },
      );
    });

    group('reloadFeed', () {
      late Completer<TFeed> reloadTweetFeedCompleter;

      setUp(() {
        reloadTweetFeedCompleter = Completer();

        when(() => mockFeedUseCases.reloadTweetFeed())
            .thenAnswer((_) => reloadTweetFeedCompleter.future);
      });

      test(
        'should invoke reloadTweetFeed',
        () async {
          // arrange
          clearInteractions(mockFeedUseCases);

          // act
          controller.reloadFeed();

          // assert
          verify(() => mockFeedUseCases.reloadTweetFeed()).called(1);
          verifyNoMoreInteractions(mockFeedUseCases);
        },
      );

      test(
        'should set state to error on failure',
        () async {
          // arrange
          const message = 'errou!';

          // act
          controller.reloadFeed();
          await reloadTweetFeedCompleter.completeAndWait(
              left(ServerSideFormFieldValidationFailure(message: message)));

          // assert
          expect(controller.state, FeedState.error(message));
        },
      );
    });

    test(
      'should cancel stream on dispose',
      () async {
        // act
        await controller.dispose();

        // assert
        expect(feedCacheStreamCtrl.hasListener, isFalse);
      },
    );

    test(
      'should call ComposeTweetFabToogle.isEnabled on initialization',
      () async {
        // assert
        verify(() => mockComposeTweetFabToggleFeature.isEnabled).called(1);
        verifyNoMoreInteractions(mockComposeTweetFabToggleFeature);
      },
    );

    test(
      'should set isComposeTweetFabVisible to true when ComposeTweetFabToogle.isEnabled is true',
      () async {
        // act
        await composeTweetFabToggleFeatureCompleter.completeAndWait(true);

        // assert
        expect(controller.isComposeTweetFabVisible, isTrue);
      },
    );

    test(
      'should set isComposeTweetFabVisible to false when ComposeTweetFabToogle.isEnabled is false',
      () async {
        // act
        await composeTweetFabToggleFeatureCompleter.completeAndWait(false);

        // assert
        expect(controller.isComposeTweetFabVisible, isFalse);
      },
    );
  });
}
