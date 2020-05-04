import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/entities/reset_password_response_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';
import 'package:penhas/app/features/authentication/domain/usecases/request_reset_password.dart';

class MockChangePasswordRepository extends Mock
    implements IChangePasswordRepository {}

class ChangePassword {
  final IChangePasswordRepository _repository;

  factory ChangePassword(
      {@required IChangePasswordRepository changePasswordRepository}) {
    return ChangePassword._(changePasswordRepository);
  }

  ChangePassword._(this._repository);

  Future<Either<Failure, ValidField>> call({
    @required EmailAddress emailAddress,
    @required Password password,
    @required String resetToken,
  }) async {
    return _repository.reset(
      emailAddress: emailAddress,
      password: password,
      resetToken: resetToken,
    );
  }
}

void main() {
  EmailAddress emailAddress;
  Password password;
  String resetToken;
  IChangePasswordRepository repository;
  ChangePassword sut;

  setUp(() {
    emailAddress = EmailAddress('valid_email@exemple.com');
    password = Password('my_very_strong_P4ssw@rd');
    repository = MockChangePasswordRepository();
    resetToken = '666422';
    sut = ChangePassword(changePasswordRepository: repository);
  });

  group('Request change password', () {
    test(
        'should received a ResetPasswordResponseEntity for successfull request',
        () async {
      // arrange
      when(repository.reset(
          emailAddress: anyNamed('emailAddress'),
          password: anyNamed('password'),
          resetToken: anyNamed(
            'resetToken',
          ))).thenAnswer((_) async => right(ValidField()));
      // act
      final result = await sut(
        emailAddress: emailAddress,
        password: password,
        resetToken: resetToken,
      );
      // assert
      expect(result, right(ValidField()));
    });
  });
}
