import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterExt on WidgetTester {
  Future<void> tapAll(Finder finder) async {
    final evaluated = finder.evaluate();
    assert(evaluated.isNotEmpty, finder.toString());
    for (final element in evaluated) {
      await tapAt(getCenter(find.byWidget(element.widget)));
    }
  }
}
