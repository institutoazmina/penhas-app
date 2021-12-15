import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_up_password.dart';

void main() {
  final validator = PasswordValidator();
  group(
    'Password',
    () {
      test(
        'should get PasswordInvalidFailure for null password',
        () {
          final result = SignInPassword(null, validator).value;

          expect(result, left(EmptyRule()));
        },
      );
      test(
        'should get PasswordInvalidFailure for empty password',
        () {
          final result = SignInPassword('', validator);

          expect(result.value, left(EmptyRule()));
          expect(result.isValid, false);
          expect(result.rawValue, null);
        },
      );
      test(
        'should get value from a valid password',
        () {
          const validPassword = '_myStrongP4ss@rd';
          final result = SignInPassword(validPassword, validator);

          expect(result.value, right(validPassword));
          expect(result.mapFailure, '');
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
      test(
        'should get value from a valid password with only lower case letters',
        () {
          const validPassword = '_mystrongp4ss@rd';
          final result = SignInPassword(validPassword, validator);

          expect(result.value, right(validPassword));
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
      test(
        'should get value from a valid password with only upper case letters',
        () {
          const validPassword = '_MYSTRONGP4SS@RD';
          final result = SignInPassword(validPassword, validator);

          expect(result.value, right(validPassword));
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
      test(
        'should get value from a valid password without letters',
        () {
          const validPassword = '12345678@';
          final result = SignInPassword(validPassword, validator);

          expect(result.value, right(validPassword));
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
      test(
        'should get value from a valid password without numbers',
        () {
          const validPassword = '@bcdefgh';
          final result = SignInPassword(validPassword, validator);

          expect(result.value, right(validPassword));
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
      test(
        'should get value from a valid password without special characters',
        () {
          const validPassword = '1bcdefgh';
          final result = SignInPassword(validPassword, validator);

          expect(result.value, right(validPassword));
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
    },
  );
}
