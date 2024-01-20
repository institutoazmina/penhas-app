import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/session_entity.dart';
import '../usecases/email_address.dart';
import '../usecases/sign_in_password.dart';

abstract class IAuthenticationRepository {
  Future<Either<Failure, SessionEntity>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required SignInPassword password,
  });

  Future<Either<Failure, SessionEntity>> signInOffline({
    required EmailAddress emailAddress,
    required SignInPassword password,
  });
}
