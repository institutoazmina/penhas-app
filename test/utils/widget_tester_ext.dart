import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

typedef OnController<C> = FutureOr<void> Function(C controller);

extension WidgetTesterExt on WidgetTester {
  Future<void> tapAll(Finder finder) async {
    final evaluated = finder.evaluate();
    assert(evaluated.isNotEmpty, finder.toString());
    for (final element in evaluated) {
      await tapAt(
        getCenter(
          find.byElementPredicate((e) => e == element),
          warnIfMissed: true,
        ),
      );
    }
  }

  Future<void> enterTextAll(Finder finder, String text) async {
    final evaluated = finder.evaluate();
    assert(evaluated.isNotEmpty, finder.toString());
    for (final element in evaluated) {
      await enterText(find.byElementPredicate((e) => e == element), text);
    }
  }
}
