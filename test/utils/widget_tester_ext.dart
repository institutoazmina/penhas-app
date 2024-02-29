import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';

typedef OnController<C> = FutureOr<void> Function(C controller);

extension WidgetTesterExt on WidgetTester {
  Future<void> tapAll(Finder finder) async {
    final evaluated = finder.evaluate();
    assert(evaluated.isNotEmpty, finder.toString());
    for (final element in evaluated) {
      await tapAt(getCenter(find.byElementPredicate((e) => e == element)));
    }
  }

  Future<void> enterTextAll(Finder finder, String text) async {
    final evaluated = finder.evaluate();
    assert(evaluated.isNotEmpty, finder.toString());
    for (final element in evaluated) {
      await enterText(find.byElementPredicate((e) => e == element), text);
    }
  }

  Future<void>
      withViewController<P extends StatefulWidget, S extends ModularState, C>(
    OnController<C> onController,
  ) async {
    final elements = find.byType(P).evaluate();
    assert(elements.isNotEmpty, 'No Page found');
    for (final element in elements) {
      final controller = state<S>(
        find.byElementPredicate((e) => e == element),
      ).controller as C;
      onController(controller);
    }
  }
}
