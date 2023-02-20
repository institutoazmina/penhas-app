import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/change_password.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_up_password.dart';

class MockIChangePasswordRepository extends Mock
    implements IChangePasswordRepository {}

void main() {
  late String resetToken;
  late EmailAddress emailAddress;
  late SignUpPassword password;

  late ChangePassword sut;
  late IChangePasswordRepository repository;

  setUp(() {
    resetToken = '666422';
    emailAddress = EmailAddress('valid_email@exemple.com');
    password = SignUpPassword('my_very_strong_P4ssw@rd', PasswordValidator());

    repository = MockIChangePasswordRepository();
    sut = ChangePassword(changePasswordRepository: repository);
  });

  group(ChangePassword, () {
    test('received a ResetPasswordResponseEntity for successful request',
        () async {
      // arrange
      when(() => repository.reset(
            emailAddress: emailAddress,
            password: password,
            resetToken: resetToken,
          )).thenAnswer((_) async => right(const ValidField()));
      // act
      final Either<Failure, ValidField> result = await sut(
        emailAddress: emailAddress,
        password: password,
        resetToken: resetToken,
      );
      // assert
      expect(result, right(const ValidField()));
    });
    test('received a ServerSideFormFieldValidationFailure from invalid token',
        () async {
      // arrange
      const error = 'invalid_token';
      const message = 'Número não confere.';
      const field = 'token';
      const reason = 'invalid';
      when(() => repository.reset(
            emailAddress: emailAddress,
            password: password,
            resetToken: resetToken,
          )).thenAnswer(
        (_) async => left(
          ServerSideFormFieldValidationFailure(
            error: error,
            field: field,
            message: message,
            reason: reason,
          ),
        ),
      );
      // act
      final Either<Failure, ValidField> result = await sut(
        emailAddress: emailAddress,
        resetToken: resetToken,
        password: password,
      );
      // assert
      expect(
        result,
        left(
          ServerSideFormFieldValidationFailure(
            error: error,
            field: field,
            message: message,
            reason: reason,
          ),
        ),
      );
    });
  });
}
