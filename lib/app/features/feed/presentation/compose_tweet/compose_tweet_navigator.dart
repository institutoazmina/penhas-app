import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../mainboard/domain/states/mainboard_state.dart';
import '../../../mainboard/domain/states/mainboard_store.dart';
import '../../../mainboard/presentation/mainboard/mainboard_page.dart';

abstract class ComposeTweetNavigator {
  factory ComposeTweetNavigator({
    required Uri? currentUri,
  }) =>
      currentUri?.path.endsWith('/compose') == true
          ? _PageComposeTweetNavigator()
          : _TabComposeTweetNavigator();

  FutureOr<void> navigateToFeed([BuildContext? context]);
}

class _PageComposeTweetNavigator implements ComposeTweetNavigator {
  @override
  void navigateToFeed([BuildContext? context]) {
    Modular.to.pop();
  }
}

class _TabComposeTweetNavigator implements ComposeTweetNavigator {
  @override
  Future<void> navigateToFeed([BuildContext? context]) async {
    assert(context != null, 'context must be provided');
    if (context == null) return;

    final MainboardStore? mainBoardStore =
        MainboardPage.of(context)?.controller.mainboardStore;
    const feed = MainboardState.feed();
    await mainBoardStore?.changePage(to: feed);
  }
}
