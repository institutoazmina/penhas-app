import 'package:dartz/dartz.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/entities/reset_password_response_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';

class RequestResetPassword {
  final IResetPasswordRepository? _repository;

  factory RequestResetPassword(
      {required IResetPasswordRepository? resetPasswordRepository}) {
    return RequestResetPassword._(resetPasswordRepository);
  }

  RequestResetPassword._(this._repository);

  final IResetPasswordRepository _repository;

  Future<Either<Failure, ResetPasswordResponseEntity>> call({
    required EmailAddress email,
  }) async {
    return _repository!.request(emailAddress: email);
  }
}
