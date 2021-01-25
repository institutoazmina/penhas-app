import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_up_password.dart';

void main() {
  final validator = PasswordValidator();
  group(
    "Password",
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
          final result = SignInPassword("", validator);

          expect(result.value, left(EmptyRule()));
          expect(result.isValid, false);
          expect(result.rawValue, null);
        },
      );
      test(
        'should get PasswordInvalidFailure for password without min length require',
        () {
          final result = SignInPassword("1Ba@2cD", validator);

          expect(result.value, left(MinLengthRule()));
          expect(result.mapFailure, 'Senha precisa ter no mínimo 8 caracteres');
          expect(result.isValid, false);
          expect(result.rawValue, null);
        },
      );
      test(
        'should get value from a valid password',
        () {
          final validPassword = "_myStrongP4ss@rd";
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
          final validPassword = "_mystrongp4ss@rd";
          final result = SignInPassword(validPassword, validator);

          expect(result.value, right(validPassword));
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
      test(
        'should get value from a valid password with only upper case letters',
        () {
          final validPassword = "_MYSTRONGP4SS@RD";
          final result = SignInPassword(validPassword, validator);

          expect(result.value, right(validPassword));
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
      test(
        'should get value from a valid password without letters',
        () {
          final validPassword = "12345678@";
          final result = SignInPassword(validPassword, validator);

          expect(result.value, right(validPassword));
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
      test(
        'should get value from a valid password without numbers',
        () {
          final validPassword = "@bcdefgh";
          final result = SignInPassword(validPassword, validator);

          expect(result.value, right(validPassword));
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
      test(
        'should get value from a valid password without special characters',
        () {
          final validPassword = "1bcdefgh";
          final result = SignInPassword(validPassword, validator);

          expect(result.value, right(validPassword));
          expect(result.isValid, true);
          expect(result.rawValue, validPassword);
        },
      );
    },
  );
}
