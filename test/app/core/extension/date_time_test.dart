import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/extension/date_time.dart';

void main() {
  test(
    'secondsSinceEpoch should return seconds since epoch',
    () async {
      // arrange
      final expected = 1703714581;

      // act
      final actual = DateTime.utc(2023, 12, 27, 22, 3, 1).secondsSinceEpoch;

      // assert
      expect(actual, expected);
    },
  );

  test(
    'fromSecondsSinceEpoch should return DateTime from seconds since epoch',
    () async {
      // arrange
      final expected = DateTime.utc(2023, 12, 27, 22, 3, 1);

      // act
      final actual = DateTimeExt.fromSecondsSinceEpoch(1703714581, isUtc: true);

      // assert
      expect(actual, expected);
    },
  );

  test(
    'fromHttpFormat should return DateTime from http format',
    () async {
      // arrange
      final expected = DateTime.utc(2023, 12, 20, 1, 45, 39);

      // act
      final actual =
          DateTimeExt.fromHttpFormat('Wed, 20 Dec 2023 01:45:39 GMT');

      // assert
      expect(actual, expected);
    },
  );

  test(
    'operator < should return true if date is before other',
    () async {
      // arrange
      final date = DateTime.utc(2023, 12, 20, 1, 45, 39);
      final other = DateTime.utc(2023, 12, 20, 1, 45, 40);

      // act
      final actual = date < other;

      // assert
      expect(actual, true);
    },
  );

  test(
    'operator < should return false if date is after other',
    () async {
      // arrange
      final date = DateTime.utc(2023, 12, 20, 1, 45, 40);
      final other = DateTime.utc(2023, 12, 20, 1, 45, 39);

      // act
      final actual = date < other;

      // assert
      expect(actual, false);
    },
  );

  test(
    'operator > should return true if date is after other',
    () async {
      // arrange
      final date = DateTime.utc(2023, 12, 20, 1, 45, 40);
      final other = DateTime.utc(2023, 12, 20, 1, 45, 39);

      // act
      final actual = date > other;

      // assert
      expect(actual, true);
    },
  );

  test(
    'operator > should return false if date is before other',
    () async {
      // arrange
      final date = DateTime.utc(2023, 12, 20, 1, 45, 39);
      final other = DateTime.utc(2023, 12, 20, 1, 45, 40);

      // act
      final actual = date > other;

      // assert
      expect(actual, false);
    },
  );
}
