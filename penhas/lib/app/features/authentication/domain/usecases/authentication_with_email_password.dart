import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';

class AuthenticationWithEmailAndPassword {
  final IAuthenticationRepository _repository;
  final IAppConfiguration _appConfiguration;

  factory AuthenticationWithEmailAndPassword({
    @required IAuthenticationRepository authenticationRepository,
    @required IAppConfiguration appConfiguration,
  }) {
    return AuthenticationWithEmailAndPassword._(
      authenticationRepository,
      appConfiguration,
    );
  }

  AuthenticationWithEmailAndPassword._(
    this._repository,
    this._appConfiguration,
  );

  Future<Either<Failure, SessionEntity>> call({
    @required EmailAddress email,
    @required Password password,
  }) async {
    final response = await _repository.signInWithEmailAndPassword(
      emailAddress: email,
      password: password,
    );

    return response.fold<Future<Either<Failure, SessionEntity>>>(
      (failure) => Future.value(left(failure)),
      (session) => _saveAthenticationToken(session),
    );
  }

  Future<Either<Failure, SessionEntity>> _saveAthenticationToken(
      SessionEntity session) async {
    await _appConfiguration.saveApiToken(token: session.sessionToken);
    return Future.value(right(session));
  }
}
