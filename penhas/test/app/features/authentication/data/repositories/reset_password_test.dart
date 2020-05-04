import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/entities/reset_password_response_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';

class ChangePasswordRepository
    implements IResetPasswordRepository, IChangePasswordRepository {
  @override
  Future<Either<Failure, ResetPasswordResponseEntity>> request(
      {EmailAddress emailAddress}) {
    // TODO: implement request
    return null;
  }

  @override
  Future<Either<Failure, ValidField>> reset(
      {EmailAddress emailAddress, Password password, String resetToken}) async {
    // TODO: implement reset
    return right(ValidField());
  }
}

void main() {
  setUp(() {});

  group('ChangePasswordRepository', () {
    group('reset', () {
      test('should return ValidField for successfull password changed',
          () async {
        // arrange
        final sut = ChangePasswordRepository();
        final EmailAddress emailAddress = EmailAddress('valid@email.com');
        final Password password = Password('my_new_str0ng_P4ssw0rd');
        final String resetToken = '666242';
        // act
        final result = await sut.reset(
          emailAddress: emailAddress,
          password: password,
          resetToken: resetToken,
        );
        // assert
        expect(result, right(ValidField()));
      });
    });
  });
}
