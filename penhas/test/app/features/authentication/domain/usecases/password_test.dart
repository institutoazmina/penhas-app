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

          expect(result, left(EmptyRule()));
        },
      );
      test(
        'should get PasswordInvalidFailure for empty password',
        () {
          var result = Password("");

          expect(result.value, left(EmptyRule()));
          expect(result.isValid, false);
          expect(result.rawValue, null);
        },
      );
      test(
        'should get PasswordInvalidFailure for password without min length require',
            () {
          var result = Password("1Ba@2cD");

          expect(result.value, left(MinLengthRule()));
          expect(result.mapFailure, 'Senha precisa ter no mínimo 8 caracteres');
          expect(result.isValid, false);
          expect(result.rawValue, null);
        },
      );
      test(
        'should get PasswordInvalidFailure for password without letters',
            () {
          var result = Password("12345678@");

          expect(result.value, left(LettersRule()));
          expect(result.isValid, false);
          expect(result.rawValue, null);
        },
      );
      test(
        'should get PasswordInvalidFailure for password without numbers',
            () {
          var result = Password("@bcdefgh");

          expect(result.value, left(NumbersRule()));
          expect(result.isValid, false);
          expect(result.rawValue, null);
        },
      );
      test(
        'should get PasswordInvalidFailure for password without special characters',
            () {
          var result = Password("1bcdefgh");

          expect(result.value, left(SpecialCharactersRule()));
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
          expect(result.mapFailure, '');
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
      test(
        'should get value from a valid password with only lower case letters',
            () {
          var validPassword = "_mystrongp4ss@rd";
          var result = Password(validPassword);

          expect(result.value, right(validPassword));
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
      test(
        'should get value from a valid password with only upper case letters',
            () {
          var validPassword = "_MYSTRONGP4SS@RD";
          var result = Password(validPassword);

          expect(result.value, right(validPassword));
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
    },
  );
}
