import 'package:dartz/dartz.dart';

import '../../../../core/entities/valid_fiel.dart';
import '../../../../core/error/failures.dart';
import '../entities/reset_password_response_entity.dart';
import '../usecases/email_address.dart';
import '../usecases/sign_up_password.dart';

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
