import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/birthday.dart';

void main() {
  group(
    'Birthday',
    () {
      test(
        'should get BirthdayInvalidFailure for null value',
        () {
          final result = Birthday(null).value;

          expect(result, left(BirthdayInvalidFailure()));
        },
      );
      test(
        'should get BirthdayInvalidFailure for empty value',
        () {
          final result = Birthday('').value;

          expect(result, left(BirthdayInvalidFailure()));
        },
      );

      test(
        'should get value from a valid birthday',
        () {
          const testValue = '01/01/1994';
          final result = Birthday(testValue).value;

          expect(result, right('1994-01-01'));
        },
      );

      test(
        'should get value from a valid birthday from Datetime',
        () {
          final testValue = DateTime.utc(1994);
          final result = Birthday.datetime(testValue).value;

          expect(result, right('1994-01-01'));
        },
      );
    },
  );
}
