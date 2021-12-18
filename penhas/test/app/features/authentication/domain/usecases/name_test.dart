import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/full_name.dart';
import 'package:penhas/app/features/authentication/domain/usecases/nickname.dart';

void main() {
  group(
    'Fullname',
    () {
      test(
        'should get FullnameInvalidFailure for null value',
        () {
          final result = Fullname(null).value;

          expect(result, left(FullnameInvalidFailure()));
        },
      );
      test(
        'should get FullnameInvalidFailure for empty value',
        () {
          final result = Fullname('').value;

          expect(result, left(FullnameInvalidFailure()));
        },
      );

      test(
        'should get value from a valid fullname',
        () {
          const testValue = 'Maria da Penha Maia Fernandes';
          final result = Fullname(testValue).value;

          expect(result, right(testValue));
        },
      );
    },
  );

  group(
    'Nickname',
    () {
      test(
        'should get NicknameInvalidFailure for null value',
        () {
          final result = Nickname(null).value;

          expect(result, left(NicknameInvalidFailure()));
        },
      );
      test(
        'should get NicknameInvalidFailure for empty value',
        () {
          final result = Nickname('').value;

          expect(result, left(NicknameInvalidFailure()));
        },
      );

      test(
        'should get value from a valid nickname',
        () {
          const testValue = 'penha';
          final result = Nickname(testValue).value;

          expect(result, right(testValue));
        },
      );
    },
  );
}
