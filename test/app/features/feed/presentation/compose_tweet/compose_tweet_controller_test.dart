import 'dart:async';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_use_cases.dart';
import 'package:penhas/app/features/feed/presentation/compose_tweet/compose_tweet_controller.dart';
import 'package:penhas/app/features/feed/presentation/compose_tweet/compose_tweet_navigator.dart';

void main() {
  late ComposeTweetController sut;

  late FeedUseCases mockUseCase;
  late ComposeTweetNavigator mockNavigator;
  late TextEditingController mockEditingController;
  late BuildContext fakeContext = FakeContext();

  setUp(() {
    mockUseCase = FeedUseCasesMock();
    mockNavigator = ComposeTweetNavigatorMock();
    mockEditingController = TextEditingControllerMock();
    fakeContext = FakeContext();

    sut = ComposeTweetController(
      useCase: mockUseCase,
      navigator: mockNavigator,
      textEditingController: mockEditingController,
    );
  });

  group(ComposeTweetController, () {
    group('init', () {
      test(
        'should set isAnonymousMode to false',
        () {
          // assert
          expect(sut.isAnonymousMode, isFalse);
        },
      );

      test(
        'should set isEnableCreateButton to false',
        () {
          // assert
          expect(sut.isEnableCreateButton, isFalse);
        },
      );

      test(
        'should set errorMessage to empty',
        () {
          // assert
          expect(sut.errorMessage, isEmpty);
        },
      );

      test(
        'should set currentState to PageProgressState.initial',
        () {
          // assert
          expect(sut.currentState, PageProgressState.initial);
        },
      );
    });

    group('setTweetContent', () {
      test(
        'should set isEnableCreateButton to true when content is not empty',
        () {
          // arrange
          const content = 'content';

          // act
          sut.setTweetContent(content);

          // assert
          expect(sut.isEnableCreateButton, isTrue);
        },
      );

      test(
        'should set isEnableCreateButton to false when content is empty',
        () {
          // arrange
          const content = '';

          // act
          sut.setTweetContent(content);

          // assert
          expect(sut.isEnableCreateButton, isFalse);
        },
      );
    });

    group('createTweetPressed', () {
      test(
        'should set errorMessage to empty when tweet content is empty',
        () async {
          // arrange
          sut.errorMessage = 'some error';
          sut.setTweetContent('');

          // act
          await sut.createTweetPressed();

          // assert
          expect(sut.errorMessage, isEmpty);
        },
      );

      test(
        'should set errorMessage to empty when tweet content is not empty',
        () async {
          // arrange
          sut.errorMessage = 'some error';
          sut.setTweetContent('not empty');
          final completer = Completer<Either<Failure, FeedCache>>();
          when(() => mockUseCase.create(any()))
              .thenAnswer((_) => completer.future);

          // act
          sut.createTweetPressed();

          // assert
          expect(sut.errorMessage, isEmpty);
        },
      );

      test(
        'should call useCase.create with correct params',
        () async {
          // arrange
          const content = 'content';
          sut.setTweetContent(content);
          final completer = Completer<Either<Failure, FeedCache>>();
          when(() => mockUseCase.create(any()))
              .thenAnswer((_) => completer.future);

          // act
          sut.createTweetPressed();

          // assert
          verify(() => mockUseCase.create(content)).called(1);
        },
      );

      test(
        'should call useCase.create with limited tweet content',
        () async {
          // arrange
          final random = Random();
          final content = String.fromCharCodes(
            List.generate(2300, (index) => random.nextInt(33) + 89),
          );
          sut.setTweetContent(content);

          final completer = Completer<Either<Failure, FeedCache>>();
          when(() => mockUseCase.create(any()))
              .thenAnswer((_) => completer.future);

          // act
          sut.createTweetPressed();

          // assert
          final captured = verify(
            () => mockUseCase.create(captureAny()),
          ).captured.last;
          expect(captured.length, equals(2200));
        },
      );

      test(
        'should change currentState to PageProgressState.loading when useCase.create is called',
        () async {
          // arrange
          sut.setTweetContent('content');
          final completer = Completer<Either<Failure, FeedCache>>();
          when(() => mockUseCase.create(any()))
              .thenAnswer((_) => completer.future);

          // act
          sut.createTweetPressed();

          // assert
          expect(sut.currentState, PageProgressState.loading);
        },
      );

      test(
        'should change currentState to PageProgressState.loaded when success',
        () async {
          // arrange
          sut.setTweetContent('content');

          when(() => mockUseCase.create(any()))
              .thenAnswer((_) async => right(const FeedCache(tweets: [])));

          // act
          await sut.createTweetPressed();

          // assert
          expect(sut.currentState, PageProgressState.loaded);
        },
      );

      test(
        'should change currentState to PageProgressState.loaded when error',
        () async {
          // arrange
          sut.setTweetContent('content');

          when(() => mockUseCase.create(any()))
              .thenAnswer((_) async => left(ServerFailure()));

          // act
          await sut.createTweetPressed();

          // assert
          expect(sut.currentState, PageProgressState.loaded);
        },
      );

      test(
        'should call navigator.navigateToFeed when useCase.create returns success',
        () async {
          // arrange
          sut.setTweetContent('content');

          when(() => mockUseCase.create(any()))
              .thenAnswer((_) async => right(const FeedCache(tweets: [])));

          // act
          await sut.createTweetPressed(fakeContext);

          // assert
          verify(() => mockNavigator.navigateToFeed(fakeContext)).called(1);
        },
      );

      test(
        'should call editingController.clear when useCase.create returns success',
        () async {
          // arrange
          sut.setTweetContent('content');

          when(() => mockUseCase.create(any()))
              .thenAnswer((_) async => right(const FeedCache(tweets: [])));

          // act
          await sut.createTweetPressed();

          // assert
          verify(() => mockEditingController.clear()).called(1);
        },
      );

      test(
        'should set errorMessage to correct value when useCase.create returns failure',
        () async {
          // arrange
          sut.setTweetContent('content');

          when(() => mockUseCase.create(any()))
              .thenAnswer((_) async => left(ServerFailure()));

          // act
          await sut.createTweetPressed();

          // assert
          expect(
            sut.errorMessage,
            'O servidor está com problema neste momento, tente novamente.',
          );
          verifyZeroInteractions(mockNavigator);
          verifyZeroInteractions(mockEditingController);
        },
      );
    });
  });
}

class ComposeTweetNavigatorMock extends Mock implements ComposeTweetNavigator {}

class FeedUseCasesMock extends Mock implements FeedUseCases {}

class TextEditingControllerMock extends Mock implements TextEditingController {}

class FakeContext extends Fake implements BuildContext {}
