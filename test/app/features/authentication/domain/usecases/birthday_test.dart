import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/birthday.dart';

void main() {
  group(
    Birthday,
    () {
      test(
        'returns invalid Birthday when constructed with null',
        () {
          // act
          final expected = Birthday(null);
          // assert
          expect(expected.isValid, false);
          expect(expected.mapFailure, 'Data de nascimento inválida');
          expect(expected.value, left(BirthdayInvalidFailure()));
        },
      );
      test(
        'returns invalid Birthday when constructed with invalid date string',
        () {
          // arrange
          const dateString = '';
          // act
          final expected = Birthday(dateString);
          // assert
          expect(expected.isValid, false);
          expect(expected.mapFailure, 'Data de nascimento inválida');
          expect(expected.value, left(BirthdayInvalidFailure()));
        },
      );

      test(
        'constructs a Birthday with valid date string',
        () {
          // arrange
          const dateString = '01/01/1994';
          // act
          final expected = Birthday(dateString);
          // assert
          expect(expected.isValid, true);
          expect(expected.rawValue, '1994-01-01');
          expect(expected.value, right('1994-01-01'));
          expect(expected.mapFailure, '');
        },
      );

      test(
        'constructs a Birthday with valid DateTime',
        () {
          // arrange
          final testValue = DateTime.utc(1994, 1, 1);
          // act
          final expected = Birthday.datetime(testValue);
          // assert
          expect(expected.isValid, true);
          expect(expected.rawValue, '1994-01-01');
          expect(expected.value, right('1994-01-01'));
          expect(expected.mapFailure, '');
        },
      );

      test(
        'return true for equal Birthdays',
        () {
          // arrange
          final testValue = DateTime.utc(1994, 1, 1);
          // act
          final expected = Birthday.datetime(testValue);
          final expected2 = Birthday.datetime(testValue);
          // assert
          expect(expected == expected2, true);
        },
      );

      test('return false for different Birthdays', () {
        // arrange
        final testValue = DateTime.utc(1994, 1, 1);
        final testValue2 = DateTime.utc(1994, 1, 2);
        // act
        final expected = Birthday.datetime(testValue);
        final expected2 = Birthday.datetime(testValue2);
        // assert
        expect(expected == expected2, false);
      });
    },
  );
}
