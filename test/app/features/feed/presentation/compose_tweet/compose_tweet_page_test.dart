import 'package:dartz/dartz.dart' show left, right;
import 'package:flutter/material.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_use_cases.dart';
import 'package:penhas/app/features/feed/presentation/compose_tweet/compose_tweet_controller.dart';
import 'package:penhas/app/features/feed/presentation/compose_tweet/compose_tweet_navigator.dart';
import 'package:penhas/app/features/feed/presentation/compose_tweet/compose_tweet_page.dart';

import '../../../../../utils/golden_tests.dart';
import '../../../../../utils/widget_tester_ext.dart';

void main() {
  late FeedUseCases mockFeedUseCases;
  late ComposeTweetNavigator mockNavigator;
  late ComposeTweetController composeTweetController;
  group(ComposeTweetPage, () {
    setUpAll(() {
      registerFallbackValue(_FakeContext());
    });

    setUp(() {
      mockFeedUseCases = _MockFeedUseCases();
      mockNavigator = _MockComposeTweetNavigator();
      composeTweetController = ComposeTweetController(
          navigator: mockNavigator, useCase: mockFeedUseCases);
    });

    screenshotTest('should render ComposeTweetPage',
        fileName: 'compose_tweet_page', pageBuilder: () {
      return ComposeTweetPage(
        composeTweetController: composeTweetController,
      );
    });

    screenshotTest('should render ComposeTweetPage with app bar',
        fileName: 'compose_tweet_page_with_app_bar', pageBuilder: () {
      return ComposeTweetPage(
        showAppBar: true,
        composeTweetController: composeTweetController,
      );
    });

    screenshotTest(
      'when user types a tweet, should enable create button',
      fileName: 'compose_tweet_page_with_text',
      pageBuilder: () {
        return ComposeTweetPage(
          showAppBar: true,
          composeTweetController: composeTweetController,
        );
      },
      pumpBeforeTest: (tester) async {
        await tester.enterTextAll(find.byType(TextField), 'Hello, world!');
        await tester.pumpAndSettle();
      },
    );

    screenshotTest(
      'when create tweet fails should show error message',
      fileName: 'compose_tweet_page_with_error',
      pageBuilder: () => ComposeTweetPage(
        showAppBar: true,
        composeTweetController: composeTweetController,
      ),
      setUp: () {
        when(() => mockFeedUseCases.create(any())).thenAnswer(
          (_) async => left<Failure, FeedCache>(ServerFailure()),
        );
      },
      pumpBeforeTest: (tester) async {
        await tester.enterTextAll(find.byType(TextField), 'Hello, world!');
        await tester.pumpAndSettle();
        await tester.tapAll(find.text('Publicar'));
      },
    );

    testWidgets(
      'when create button pressed should call create tweet',
      (tester) async {
        // arrange
        when(() => mockFeedUseCases.create(any())).thenAnswer(
          (_) async => right<Failure, FeedCache>(FeedCache(tweets: [])),
        );

        await tester.pumpWidget(buildTestableWidget(ComposeTweetPage(
          composeTweetController: composeTweetController,
        )));
        await tester.pumpAndSettle();

        // act
        await tester.enterText(find.byType(TextField), 'Hello, world!');
        await tester.pump();
        await tester.tap(find.text('Publicar'));
        await tester.pump();

        // assert
        verify(() => mockFeedUseCases.create('Hello, world!')).called(1);
      },
    );

    testWidgets(
      'when tweet created successfully should navigate to mainboard',
      (tester) async {
        // arrange

        when(() => mockFeedUseCases.create(any())).thenAnswer(
          (_) async => right<Failure, FeedCache>(FeedCache(tweets: [])),
        );
        when(() => mockNavigator.navigateToFeed(any()))
            .thenAnswer((_) => Future.value());

        await tester.pumpWidget(buildTestableWidget(ComposeTweetPage(
          composeTweetController: composeTweetController,
        )));
        await tester.pumpAndSettle();

        // act
        await tester.enterText(find.byType(TextField), 'Hello, world!');
        await tester.pump();
        await tester.tap(find.text('Publicar'));
        await tester.pumpAndSettle();

        // assert
        verify(() => mockNavigator.navigateToFeed(any(that: isNotNull)))
            .called(1);
      },
    );
  });
}

class _MockFeedUseCases extends Mock implements FeedUseCases {}

class _MockComposeTweetNavigator extends Mock
    implements ComposeTweetNavigator {}

class _FakeContext extends Fake implements BuildContext {}
