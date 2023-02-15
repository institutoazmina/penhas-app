import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/extension/safely_parser.dart';

void main() {
  group('SafelyParser extension', () {
    test('safeParseDouble parse double from string or number', () {
      expect((1.0).safeParseDouble(), 1.0);
      expect(('1.0').safeParseDouble(), 1.0);
      expect(('not a number').safeParseDouble(), isNull);
      expect((null).safeParseDouble(), isNull);
    });

    test('safeParseInt parse int from string or number', () {
      expect((1).safeParseInt(), 1);
      expect(('1').safeParseInt(), 1);
      expect(('default value').safeParseInt(def: 42), 42);
      expect(('not an int').safeParseInt(), 0);
      expect((null).safeParseInt(), 0);
    });

    test('safeParseBool return true for 1, false for anything else', () {
      expect((1).safeParseBool(), isTrue);
      expect((0).safeParseBool(), isFalse);
      expect(('1').safeParseBool(), isFalse);
      expect((null).safeParseBool(), isFalse);
    });
  });
}
