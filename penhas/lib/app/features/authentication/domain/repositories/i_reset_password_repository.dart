import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/entities/reset_password_response_entity.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';

abstract class IResetPasswordRepository {
  Future<Either<Failure, ResetPasswordResponseEntity>> request({
    @required EmailAddress emailAddress,
  });
}
