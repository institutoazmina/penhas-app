// ignore_for_file: avoid_print, prefer_function_declarations_over_variables
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/states/security_toggle_state.dart';

void main() {
  group(SecurityToggleState, () {
    test('create an instance with a title, enabled state and callback', () {
      // arrange
      const title = 'Toggle Title';
      final callback = (value) {
        print(value);
      };
      // act
      final toggle = SecurityToggleState(
        title: title,
        isEnabled: true,
        onChanged: callback,
      );
      // assert
      expect(toggle.title, title);
      expect(toggle.isEnabled, true);
      expect(toggle.onChanged, isNotNull);
      expect(toggle.onChanged, callback);
    });

    test(
        'create an empty instance with a title, disabled state and empty callback',
        () {
      final toggle = SecurityToggleState.empty();

      expect(toggle.title, '');
      expect(toggle.isEnabled, false);
      expect(toggle.onChanged, isNull);
    });
  });
}
