import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';

void main() {
  group(
    "Password",
    () {
      test(
        'should get PasswordInvalidFailure for null password',
        () {
          var result = Password(null).value;

          expect(result, left(PasswordInvalidFailure()));
        },
      );
      test(
        'should get PasswordInvalidFailure for empty password',
        () {
          var result = Password("");

          expect(result.value, left(PasswordInvalidFailure()));
          expect(result.isValid, false);
          expect(result.rawValue, null);
        },
      );
      test(
        'should get value from a valid password',
        () {
          var validPassword = "_myStrongP4ss@rd";
          var result = Password(validPassword);

          expect(result.value, right(validPassword));
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
    },
  );
}
