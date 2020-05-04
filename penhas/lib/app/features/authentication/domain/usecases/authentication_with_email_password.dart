import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';

class AuthenticationWithEmailAndPassword {
  final IAuthenticationRepository _repository;

  factory AuthenticationWithEmailAndPassword(
      {IAuthenticationRepository authenticationRepository}) {
    return AuthenticationWithEmailAndPassword._(authenticationRepository);
  }

  AuthenticationWithEmailAndPassword._(this._repository);

  Future<Either<Failure, SessionEntity>> call({
    @required EmailAddress email,
    @required Password password,
  }) async {
    return await _repository.signInWithEmailAndPassword(
      emailAddress: email,
      password: password,
    );
  }
}
