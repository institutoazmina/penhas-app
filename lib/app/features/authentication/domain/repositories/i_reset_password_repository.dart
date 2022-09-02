import 'package:dartz/dartz.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/entities/reset_password_response_entity.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_up_password.dart';

abstract class IResetPasswordRepository {
  Future<Either<Failure, ResetPasswordResponseEntity>> request({
    required EmailAddress? emailAddress,
  });
}

abstract class IChangePasswordRepository {
  Future<Either<Failure, ValidField>> validToken({
    required EmailAddress? emailAddress,
    required String? resetToken,
  });

  Future<Either<Failure, ValidField>> reset({
    required EmailAddress? emailAddress,
    required SignUpPassword? password,
    required String? resetToken,
  });
}
