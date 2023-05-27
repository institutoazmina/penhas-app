import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/shared/navigation/app_route.dart';

void main() {
  group(AppRoute, () {
    test('no argument route', () {
      final AppRoute actual = AppRoute('/route_a');
      expect(actual.args, null);
      expect(actual.path, '/route_a');
    });

    test('single argument route', () {
      final AppRoute actual = AppRoute('/route_a?arg=val');
      expect(actual.args, {'arg': 'val'});
      expect(actual.path, '/route_a');
    });

    test('repeated arguments route', () {
      final AppRoute actual = AppRoute('/route_a?arg=val&arg=other');
      expect(actual.args, {'arg': 'other'});
      expect(actual.path, '/route_a');
    });

    test('two arguments route', () {
      final AppRoute actual = AppRoute('/route_a?arg=val&second=arg');
      expect(actual.args, {'arg': 'val', 'second': 'arg'});
      expect(actual.path, '/route_a');
    });

    test('has a valid hashCode', () {
      final AppRoute actual = AppRoute('/route_a');
      expect(actual.hashCode, isNotNull);
    });
  });
}
