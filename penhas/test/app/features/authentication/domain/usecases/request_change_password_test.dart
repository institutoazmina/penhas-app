import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/change_password.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_up_password.dart';

class MockChangePasswordRepository extends Mock
    implements IChangePasswordRepository {}

void main() {
  EmailAddress emailAddress;
  SignUpPassword password;
  String resetToken;
  IChangePasswordRepository repository;
  ChangePassword sut;

  setUp(() {
    emailAddress = EmailAddress('valid_email@exemple.com');
    password = SignUpPassword('my_very_strong_P4ssw@rd', PasswordValidator());
    repository = MockChangePasswordRepository();
    resetToken = '666422';
    sut = ChangePassword(changePasswordRepository: repository);
  });

  group('Request change password', () {
    PostExpectation<Future<Either<Failure, ValidField>>> mockResquest() {
      return when(repository.reset(
          emailAddress: anyNamed('emailAddress'),
          password: anyNamed('password'),
          resetToken: anyNamed(
            'resetToken',
          )));
    }

    test('should received a ResetPasswordResponseEntity for successful request',
        () async {
      // arrange
      mockResquest().thenAnswer((_) async => right(ValidField()));
      // act
      final result = await sut(
        emailAddress: emailAddress,
        password: password,
        resetToken: resetToken,
      );
      // assert
      expect(result, right(ValidField()));
    });
    test(
        'should received a ServerSideFormFieldValidationFailure from invalid token',
        () async {
      // arrange
      final error = 'invalid_token';
      final message = 'Número não confere.';
      final field = 'token';
      final reason = 'invalid';
      mockResquest()
          .thenAnswer((_) async => left(ServerSideFormFieldValidationFailure(
                error: error,
                field: field,
                message: message,
                reason: reason,
              )));
      // act
      final result = await sut(
        emailAddress: emailAddress,
        resetToken: resetToken,
        password: password,
      );
      // assert
      expect(
        result,
        left(ServerSideFormFieldValidationFailure(
          error: error,
          field: field,
          message: message,
          reason: reason,
        )),
      );
    });
  });
}
