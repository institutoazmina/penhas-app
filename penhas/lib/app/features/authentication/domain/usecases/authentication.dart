import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';

class Authentication {
  final IAuthenticationRepository repository;

  Authentication(this.repository);

  Future<Either<Failure, SessionEntity>> execute({
    @required EmailAddress email,
    @required Password password,
  }) async {
    return await repository.signInWithEmailAndPassword(
        emailAddress: email, password: password);
  }
}
