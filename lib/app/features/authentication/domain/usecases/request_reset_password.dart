import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/reset_password_response_entity.dart';
import '../repositories/i_reset_password_repository.dart';
import 'email_address.dart';

class RequestResetPassword {
  factory RequestResetPassword({
    required IResetPasswordRepository resetPasswordRepository,
  }) {
    return RequestResetPassword._(resetPasswordRepository);
  }

  RequestResetPassword._(this._repository);

  final IResetPasswordRepository _repository;

  Future<Either<Failure, ResetPasswordResponseEntity>> call({
    required EmailAddress email,
  }) async {
    return _repository.request(emailAddress: email);
  }
}
