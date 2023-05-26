import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';

void main() {
  late PasswordValidator validator;

  setUp(() {
    validator = PasswordValidator();
  });

  group(
    SignInPassword,
    () {
      test('constructs an SignInPassword with valid password', () {
        // arrange
        const passwordString = '_myStrongP4ss@rd';
        // act
        final password = SignInPassword(passwordString, validator);
        // assert
        expect(password.isValid, true);
        expect(password.rawValue, passwordString);
        expect(password.mapFailure, '');
        expect(password.value, right(passwordString));
      });

      test('returns invalid SignInPassword when constructed with null', () {
        // act
        final password = SignInPassword(null, validator);
        // assert
        expect(password.isValid, false);
        expect(password.mapFailure, '');
        expect(password.value, left(EmptyRule()));
      });
      test(
          'returns invalid SignInPassword when constructed with empty password',
          () {
        // act
        final password = SignInPassword('', validator);
        // assert
        expect(password.isValid, false);
        expect(password.mapFailure, '');
        expect(password.value, left(EmptyRule()));
      });

      test(
        'constructs an SignInPassword from a valid password with only lower case letters',
        () {
          // arrange
          const validPassword = '_mystrongp4ss@rd';
          // act
          final result = SignInPassword(validPassword, validator);
          // assert
          expect(result.value, right(validPassword));
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
      test(
        'constructs an SignInPassword from a valid password with only upper case letters',
        () {
          // arrange
          const validPassword = '_MYSTRONGP4SS@RD';
          // act
          final result = SignInPassword(validPassword, validator);
          // assert
          expect(result.value, right(validPassword));
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
      test(
        'constructs an SignInPassword from a valid password without letters',
        () {
          // arrange
          const validPassword = '12345678@';
          // act
          final result = SignInPassword(validPassword, validator);
          // assert
          expect(result.value, right(validPassword));
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
      test(
        'constructs an SignInPassword from a valid password without numbers',
        () {
          // arrange
          const validPassword = '@bcdefgh';
          // act
          final result = SignInPassword(validPassword, validator);
          // assert
          expect(result.value, right(validPassword));
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
      test(
        'constructs an SignInPassword from a valid password without special characters',
        () {
          // arrange
          const validPassword = '1bcdefgh';
          // act
          final result = SignInPassword(validPassword, validator);
          // assert
          expect(result.value, right(validPassword));
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );

      test(
        'return true for equal SignInPassword',
        () {
          // arrange
          const passwordString = '_myStrongP4ss@rd';
          // act
          final password = SignInPassword(passwordString, validator);
          final password2 = SignInPassword(passwordString, validator);
          // assert
          expect(password == password2, true);
        },
      );

      test(
        'return false for different SignInPassword',
        () {
          // arrange
          const passwordString = '_myStrongP4ss@rd';
          const passwordString2 = '_myStrongP4ss@rd2';
          // act
          final password = SignInPassword(passwordString, validator);
          final password2 = SignInPassword(passwordString2, validator);
          // assert
          expect(password == password2, false);
        },
      );
    },
  );
}
