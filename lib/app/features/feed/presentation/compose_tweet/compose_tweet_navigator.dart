import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';

import '../../../mainboard/domain/states/mainboard_state.dart';
import '../../../mainboard/domain/states/mainboard_store.dart';

abstract class ComposeTweetNavigator {
  factory ComposeTweetNavigator({
    required Uri? currentUri,
    required MainboardStore mainboardStore,
  }) =>
      currentUri?.path.endsWith('/compose') == true
          ? _PageComposeTweetNavigator()
          : _TabComposeTweetNavigator(mainboardStore: mainboardStore);

  FutureOr<void> navigateToFeed();
}

class _PageComposeTweetNavigator implements ComposeTweetNavigator {
  @override
  void navigateToFeed() {
    Modular.to.pop();
  }
}

class _TabComposeTweetNavigator implements ComposeTweetNavigator {
  _TabComposeTweetNavigator({
    required MainboardStore mainboardStore,
  }) : _mainboardStore = mainboardStore;

  final MainboardStore _mainboardStore;
  @override
  Future<void> navigateToFeed() async {
    await _mainboardStore.changePage(to: const MainboardState.feed());
  }
}
