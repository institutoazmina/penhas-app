import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/change_password.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_up_password.dart';

import '../../../../../utils/helper.mocks.dart';

void main() {
<<<<<<< HEAD
  late EmailAddress emailAddress;
  late SignUpPassword password;
  late String resetToken;

  late final MockIChangePasswordRepository repository =
      MockIChangePasswordRepository();
=======
  EmailAddress? emailAddress;
  SignUpPassword? password;
  String? resetToken;
  IChangePasswordRepository? repository;
>>>>>>> Migrate code to nullsafety
  late ChangePassword sut;

  setUp(() {
    emailAddress = EmailAddress('valid_email@exemple.com');
    password = SignUpPassword('my_very_strong_P4ssw@rd', PasswordValidator());
    resetToken = '666422';
    sut = ChangePassword(changePasswordRepository: repository);
  });

  group('Request change password', () {
    PostExpectation<Future<Either<Failure, ValidField>>> mockResquest() {
<<<<<<< HEAD
      return when(
        repository.reset(
=======
      return when(repository!.reset(
>>>>>>> Migrate code to nullsafety
          emailAddress: anyNamed('emailAddress'),
          password: anyNamed('password'),
          resetToken: anyNamed(
            'resetToken',
          ),
        ),
      );
    }

    test('should received a ResetPasswordResponseEntity for successful request',
        () async {
      // arrange
      mockResquest().thenAnswer((_) async => right(const ValidField()));
      // act
<<<<<<< HEAD
      final Either<Failure, ValidField> result = await sut(
        emailAddress: emailAddress,
        password: password,
        resetToken: resetToken,
=======
      final Either<Failure, ValidField>? result = await sut(
        emailAddress: emailAddress!,
        password: password!,
        resetToken: resetToken!,
>>>>>>> Migrate code to nullsafety
      );
      // assert
      expect(result, right(const ValidField()));
    });
    test(
        'should received a ServerSideFormFieldValidationFailure from invalid token',
        () async {
      // arrange
      const error = 'invalid_token';
      const message = 'Número não confere.';
      const field = 'token';
      const reason = 'invalid';
      mockResquest().thenAnswer(
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
<<<<<<< HEAD
      final Either<Failure, ValidField> result = await sut(
        emailAddress: emailAddress,
        resetToken: resetToken,
        password: password,
=======
      final Either<Failure, ValidField>? result = await sut(
        emailAddress: emailAddress!,
        resetToken: resetToken!,
        password: password!,
>>>>>>> Migrate code to nullsafety
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
