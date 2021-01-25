import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_up_password.dart';

void main() {
  final validator = PasswordValidator();
  group(
    "Password",
    () {
      test(
        'should get PasswordInvalidFailure for null password',
        () {
          var result = SignUpPassword(null, validator).value;

          expect(result, left(EmptyRule()));
        },
      );
      test(
        'should get PasswordInvalidFailure for empty password',
        () {
          var result = SignUpPassword("", validator);

          expect(result.value, left(EmptyRule()));
          expect(result.isValid, false);
          expect(result.rawValue, null);
        },
      );
      test(
        'should get PasswordInvalidFailure for password without min length require',
            () {
          var result = SignUpPassword("1Ba@2cD", validator);

          expect(result.value, left(MinLengthRule()));
          expect(result.mapFailure, 'Senha precisa ter no mínimo 8 caracteres');
          expect(result.isValid, false);
          expect(result.rawValue, null);
        },
      );
      test(
        'should get PasswordInvalidFailure for password without letters',
            () {
          var result = SignUpPassword("12345678@", validator);

          expect(result.value, left(LettersRule()));
          expect(result.isValid, false);
          expect(result.rawValue, null);
        },
      );
      test(
        'should get PasswordInvalidFailure for password without numbers',
            () {
          var result = SignUpPassword("@bcdefgh", validator);

          expect(result.value, left(NumbersRule()));
          expect(result.isValid, false);
          expect(result.rawValue, null);
        },
      );
      test(
        'should get PasswordInvalidFailure for password without special characters',
            () {
          var result = SignUpPassword("1bcdefgh", validator);

          expect(result.value, left(SpecialCharactersRule()));
          expect(result.isValid, false);
          expect(result.rawValue, null);
        },
      );
      test(
        'should get value from a valid password',
        () {
          var validPassword = "_myStrongP4ss@rd";
          var result = SignUpPassword(validPassword, validator);

          expect(result.value, right(validPassword));
          expect(result.mapFailure, '');
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
      test(
        'should get value from a valid password with only lower case letters',
            () {
          var validPassword = "_mystrongp4ss@rd";
          var result = SignUpPassword(validPassword, validator);

          expect(result.value, right(validPassword));
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
      test(
        'should get value from a valid password with only upper case letters',
            () {
          var validPassword = "_MYSTRONGP4SS@RD";
          var result = SignUpPassword(validPassword, validator);

          expect(result.value, right(validPassword));
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
    },
  );
}
