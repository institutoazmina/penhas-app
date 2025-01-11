import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_filter_session_entity.dart';
import 'package:penhas/app/features/feed/presentation/category_tweet/category_tweet_controller.dart';
import 'package:penhas/app/features/feed/presentation/category_tweet/category_tweet_page.dart';

import '../../../../../utils/golden_tests.dart';
import '../../../../../utils/widget_test_steps.dart';

class MockCategoryTweetController extends Mock
    implements CategoryTweetController {}

void main() {
  late CategoryTweetController controller;

  setUp(() {
    controller = MockCategoryTweetController();
  });

  group(CategoryTweetPage, () {
    testWidgets('should load page', (tester) async {
      when(() => controller.getCategories()).thenAnswer((_) => Future.value());

      when(() => controller.currentState)
          .thenAnswer((_) => PageProgressState.loaded);

      when(() => controller.categories)
          .thenReturn(mobx.ObservableList.of(<TweetFilterEntity>[]));

      await theAppIsRunning(
          tester,
          CategoryTweetPage(
            controller: controller,
          ));

      await iSeeText('Categoria');
      await iSeeText('Selecione uma das categoria:');
      await iSeeText('Aplicar filtro');
    });

    screenshotTest('should render page', fileName: 'category_tweet_page',
        pageBuilder: () {
      when(() => controller.getCategories()).thenAnswer((_) => Future.value());

      when(() => controller.currentState)
          .thenAnswer((_) => PageProgressState.loaded);

      when(() => controller.categories)
          .thenReturn(mobx.ObservableList.of(<TweetFilterEntity>[]));

      return CategoryTweetPage(
        controller: controller,
      );
    });
  });
}
