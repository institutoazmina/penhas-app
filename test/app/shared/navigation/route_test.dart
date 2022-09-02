import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/shared/navigation/route.dart';

void main() {

  group('Route', () {
    test('no argument route', () {
      final AppRoute actual = AppRoute('/aroute');
      expect(actual.args, null);
      expect(actual.path, '/aroute');
    });

    test('single argument route', () {
      final AppRoute actual = AppRoute('/aroute?arg=val');
      expect(actual.args, {'arg': 'val'});
      expect(actual.path, '/aroute');
    });

    test('repeated arguments route', () {
      final AppRoute actual = AppRoute('/aroute?arg=val&arg=other');
      expect(actual.args, {'arg': 'other'});
      expect(actual.path, '/aroute');
    });


    test('two arguments route', () {
      final AppRoute actual = AppRoute('/aroute?arg=val&second=arg');
      expect(actual.args, {'arg': 'val', 'second': 'arg'});
      expect(actual.path, '/aroute');
    });
  });
}
