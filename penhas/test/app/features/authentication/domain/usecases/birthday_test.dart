import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/birthday.dart';

void main() {
  group(
    "Birthday",
    () {
      test(
        'should get BirthdayInvalidFailure for null value',
        () {
          var result = Birthday(null).value;

          expect(result, left(BirthdayInvalidFailure()));
        },
      );
      test(
        'should get BirthdayInvalidFailure for empty value',
        () {
          var result = Birthday("").value;

          expect(result, left(BirthdayInvalidFailure()));
        },
      );

      test(
        'should get value from a valid birthday',
        () {
          var testValue = "1994-01-01";
          var result = Birthday(testValue).value;

          expect(result, right(testValue));
        },
      );
    },
  );
}
