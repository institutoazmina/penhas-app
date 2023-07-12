import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

void main() {
  group('DesignSystemColors', () {
    test('hexColor correctly convert a hex string to a Color', () {
      const hexColor = '#AABBCC';
      const hexColorWithoutHash = 'AABBCC';
      const expectedColor = Color(0xFFAABBCC);

      expect(DesignSystemColors.hexColor(hexColor), expectedColor);
      expect(DesignSystemColors.hexColor(hexColorWithoutHash), expectedColor);
    });

    test('hexColor correctly convert a hex string with alpha to a Color', () {
      const hexColor = '#AABBCCDD';
      const hexColorWithoutHash = 'AABBCCDD';
      const expectedColor = Color(0xAABBCCDD);

      expect(DesignSystemColors.hexColor(hexColor), expectedColor);
      expect(DesignSystemColors.hexColor(hexColorWithoutHash), expectedColor);
    });

    test('return Exception for an invalid hexColor', () {
      expect(() => DesignSystemColors.hexColor('invalid_hex'),
          throwsA(isA<Exception>()));
    });
  });
}
