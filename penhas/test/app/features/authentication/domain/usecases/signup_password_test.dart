import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_up_password.dart';

void main() {
  final validator = PasswordValidator();
  group(
    'Password',
    () {
      test(
        'should get PasswordInvalidFailure for null password',
        () {
          final result = SignUpPassword(null, validator).value;

          expect(result, left(EmptyRule()));
        },
      );
      test(
        'should get PasswordInvalidFailure for empty password',
        () {
          final result = SignUpPassword('', validator);

          expect(result.value, left(EmptyRule()));
          expect(result.isValid, false);
          expect(result.rawValue, null);
        },
      );
      test(
        'should get PasswordInvalidFailure for password without min length require',
            () {
          final result = SignUpPassword('1Ba@2cD', validator);

          expect(result.value, left(MinLengthRule()));
          expect(result.mapFailure, 'Senha precisa ter no mínimo 8 caracteres');
          expect(result.isValid, false);
          expect(result.rawValue, null);
        },
      );
      test(
        'should get PasswordInvalidFailure for password without letters',
            () {
          final result = SignUpPassword('12345678@', validator);

          expect(result.value, left(LettersRule()));
          expect(result.isValid, false);
          expect(result.rawValue, null);
        },
      );
      test(
        'should get PasswordInvalidFailure for password without numbers',
            () {
          final result = SignUpPassword('@bcdefgh', validator);

          expect(result.value, left(NumbersRule()));
          expect(result.isValid, false);
          expect(result.rawValue, null);
        },
      );
      test(
        'should get PasswordInvalidFailure for password without special characters',
            () {
          final result = SignUpPassword('1bcdefgh', validator);

          expect(result.value, left(SpecialCharactersRule()));
          expect(result.isValid, false);
          expect(result.rawValue, null);
        },
      );
      test(
        'should get value from a valid password',
        () {
          final validPassword = '_myStrongP4ss@rd';
          final result = SignUpPassword(validPassword, validator);

          expect(result.value, right(validPassword));
          expect(result.mapFailure, '');
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
      test(
        'should get value from a valid password with only lower case letters',
            () {
          final validPassword = '_mystrongp4ss@rd';
          final result = SignUpPassword(validPassword, validator);

          expect(result.value, right(validPassword));
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
      test(
        'should get value from a valid password with only upper case letters',
            () {
          final validPassword = '_MYSTRONGP4SS@RD';
          final result = SignUpPassword(validPassword, validator);

          expect(result.value, right(validPassword));
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
    },
  );
}
