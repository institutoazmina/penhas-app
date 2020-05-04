import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';

@immutable
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
