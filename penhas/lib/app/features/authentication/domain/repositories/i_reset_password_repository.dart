import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/entities/reset_password_response_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';

abstract class IResetPasswordRepository {
  Future<Either<Failure, ResetPasswordResponseEntity>> request({
    @required EmailAddress emailAddress,
  });
}

abstract class IChangePasswordRepository {
  Future<Either<Failure, ValidField>> reset({
    @required EmailAddress emailAddress,
    @required Password password,
    @required String resetToken,
  });
}
