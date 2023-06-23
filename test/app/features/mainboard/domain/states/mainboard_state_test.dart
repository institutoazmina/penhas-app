import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_state.dart';

void main() {
  group(MainboardState, () {
    test('returns Feed state when fromString is called with "feed"', () {
      // arrange
      const expectedState = MainboardState.feed();
      const inputString = 'feed';
      // act
      final result = MainboardState.fromString(inputString);
      // assert
      expect(result, equals(expectedState));
    });

    test('returns Chat state when fromString is called with "chat"', () {
      // arrange
      const expectedState = MainboardState.chat();
      const inputString = 'chat';
      // act
      final result = MainboardState.fromString(inputString);
      // assert
      expect(result, equals(expectedState));
    });

    test('returns Compose state when fromString is called with "compose"', () {
      // arrange
      const expectedState = MainboardState.compose();
      const inputString = 'compose';
      // act
      final result = MainboardState.fromString(inputString);
      // assert
      expect(result, equals(expectedState));
    });

    test(
        'returns SupportPoint state when fromString is called with "supportpoint"',
        () {
      // arrange
      const expectedState = MainboardState.supportPoint();
      const inputString = 'supportpoint';
      // act
      final result = MainboardState.fromString(inputString);
      // assert
      expect(result, equals(expectedState));
    });

    test('returns HelpCenter state when fromString is called with "helpcenter"',
        () {
      // arrange
      const expectedState = MainboardState.helpCenter();
      const inputString = 'helpcenter';
      // act
      final result = MainboardState.fromString(inputString);
      // assert
      expect(result, equals(expectedState));
    });

    test(
        'returns Feed state when fromString is called with an unrecognized string',
        () {
      // arrange
      const expectedState = MainboardState.feed();
      const inputString = 'unrecognized';
      // act
      final result = MainboardState.fromString(inputString);
      // assert
      expect(result, equals(expectedState));
    });

    test('returns Feed state when fromString is called with null', () {
      // arrange
      const expectedState = MainboardState.feed();
      const inputString = null;
      // act
      final result = MainboardState.fromString(inputString);
      // assert
      expect(result, equals(expectedState));
    });
  });
}
