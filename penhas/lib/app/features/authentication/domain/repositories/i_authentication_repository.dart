import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';

abstract class IAuthenticationRepository {
  Future<Either<Failure, SessionEntity>> signInWithEmailAndPassword({
    @required EmailAddress emailAddress,
    @required SignInPassword password,
  });
}
