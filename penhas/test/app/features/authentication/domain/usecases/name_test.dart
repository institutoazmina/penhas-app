import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/full_name.dart';
import 'package:penhas/app/features/authentication/domain/usecases/nickname.dart';

void main() {
  group(
    "Fullname",
    () {
      test(
        'should get FullnameInvalidFailure for null value',
        () {
          var result = Fullname(null).value;

          expect(result, left(FullnameInvalidFailure()));
        },
      );
      test(
        'should get FullnameInvalidFailure for empty value',
        () {
          var result = Fullname("").value;

          expect(result, left(FullnameInvalidFailure()));
        },
      );

      test(
        'should get value from a valid fullname',
        () {
          var testValue = "Maria da Penha Maia Fernandes";
          var result = Fullname(testValue).value;

          expect(result, right(testValue));
        },
      );
    },
  );

  group(
    "Nickname",
    () {
      test(
        'should get NicknameInvalidFailure for null value',
        () {
          var result = Nickname(null).value;

          expect(result, left(NicknameInvalidFailure()));
        },
      );
      test(
        'should get NicknameInvalidFailure for empty value',
        () {
          var result = Nickname("").value;

          expect(result, left(NicknameInvalidFailure()));
        },
      );

      test(
        'should get value from a valid nickname',
        () {
          var testValue = "penha";
          var result = Nickname(testValue).value;

          expect(result, right(testValue));
        },
      );
    },
  );
}
