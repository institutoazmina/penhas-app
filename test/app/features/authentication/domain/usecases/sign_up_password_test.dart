import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_up_password.dart';

void main() {
  late PasswordValidator validator;

  setUp(() {
    validator = PasswordValidator();
  });

  group(
    SignUpPassword,
    () {
      test(
        'get EmptyRule for null password',
        () {
          // act
          final result = SignUpPassword(null, validator);
          // assert
          expect(result.isValid, isFalse);
          expect(result.value, left(EmptyRule()));
          expect(result.rawValue, null);
          expect(result.mapFailure, '');
        },
      );
      test(
        'get EmptyRule for empty password',
        () {
          // act
          final result = SignUpPassword('', validator);
          // assert
          expect(result.value, left(EmptyRule()));
          expect(result.isValid, false);
          expect(result.rawValue, null);
        },
      );
      test(
        'get MinLengthRule for password without min length require',
        () {
          // act
          final result = SignUpPassword('1Ba@2cD', validator);
          // assert
          expect(result.value, left(MinLengthRule()));
          expect(result.mapFailure, 'Senha precisa ter no mínimo 8 caracteres');
          expect(result.isValid, false);
          expect(result.rawValue, null);
        },
      );
      test(
        'get LettersRule for password without letters',
        () {
          // act
          final result = SignUpPassword('12345678@', validator);
          // assert
          expect(result.value, left(LettersRule()));
          expect(result.isValid, false);
          expect(result.mapFailure, 'Senha precisa ter ao menos 1 letra');
          expect(result.rawValue, null);
        },
      );
      test(
        'get NumbersRule for password without numbers',
        () {
          // act
          final result = SignUpPassword('@bcdefgh', validator);
          // assert
          expect(result.value, left(NumbersRule()));
          expect(result.isValid, false);
          expect(result.mapFailure, 'Senha precisa ter ao menos 1 número');
          expect(result.rawValue, null);
        },
      );
      test(
        'get SpecialCharactersRule for password without special characters',
        () {
          // act
          final result = SignUpPassword('1bcdefgh', validator);
          // assert
          expect(result.value, left(SpecialCharactersRule()));
          expect(result.isValid, false);
          expect(result.rawValue, null);
          expect(result.mapFailure,
              'Senha precisa ter ao menos 1 caractere especial');
        },
      );
      test(
        'constructs an SignUpPassword with valid password',
        () {
          // arrange
          const validPassword = '_myStrongP4ss@rd';
          // act
          final result = SignUpPassword(validPassword, validator);
          // assert
          expect(result.value, right(validPassword));
          expect(result.mapFailure, '');
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
      test(
        'constructs an SignUpPassword with valid password with only lower case letters',
        () {
          // arrange
          const validPassword = '_mystrongp4ss@rd';
          // act
          final result = SignUpPassword(validPassword, validator);
          // assert
          expect(result.value, right(validPassword));
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
      test(
        'constructs an SignUpPassword valid password with only upper case letters',
        () {
          // arrange
          const validPassword = '_MYSTRONGP4SS@RD';
          // act
          final result = SignUpPassword(validPassword, validator);
          // assert
          expect(result.value, right(validPassword));
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
      test('return true for equals SignUpPassword', () {
        // arrange
        const validPassword = '_myStrongP4ss@rd';
        // act
        final password = SignUpPassword(validPassword, validator);
        final password2 = SignUpPassword(validPassword, validator);
        // assert
        expect(password == password2, true);
      });

      test('return false for different SignUpPassword', () {
        // arrange
        const validPassword = '_myStrongP4ss@rd';
        const validPassword2 = '_myStrongP2ss@rd';
        // act
        final password = SignUpPassword(validPassword, validator);
        final password2 = SignUpPassword(validPassword2, validator);
        // assert
        expect(password == password2, false);
      });
    },
  );
}
