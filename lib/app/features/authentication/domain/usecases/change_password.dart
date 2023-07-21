import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/entities/valid_fiel.dart';
import '../../../../core/error/failures.dart';
import '../repositories/i_reset_password_repository.dart';
import 'email_address.dart';
import 'sign_up_password.dart';

@immutable
class ChangePassword {
  factory ChangePassword({
    required IChangePasswordRepository? changePasswordRepository,
  }) {
    return ChangePassword._(changePasswordRepository);
  }

  const ChangePassword._(this._repository);

  final IChangePasswordRepository? _repository;

  Future<Either<Failure, ValidField>> call({
    required EmailAddress emailAddress,
    required SignUpPassword password,
    required String resetToken,
  }) async {
    return _repository!.reset(
      emailAddress: emailAddress,
      password: password,
      resetToken: resetToken,
    );
  }
}
