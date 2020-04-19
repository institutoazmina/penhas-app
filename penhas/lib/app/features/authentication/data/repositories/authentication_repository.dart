import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/i_network_info.dart';
import 'package:penhas/app/features/authentication/data/datasources/authentication_data_source.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  final AuthenticationDataSource dataSource;
  final INetworkInfo networkInfo;

  AuthenticationRepository({
    @required this.dataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, SessionEntity>> signInWithEmailAndPassword(
      {EmailAddress emailAddress, Password password}) async {
    return _mapFromDataSource(
      emailAddress: emailAddress,
      password: password,
    );
  }

  Future<Either<Failure, SessionEntity>> _mapFromDataSource(
      {EmailAddress emailAddress, Password password}) async {
    try {
      final resultado = await dataSource.signInWithEmailAndPassword(
        emailAddress: emailAddress,
        password: password,
      );
      return right(resultado);
    } on ApiProviderException catch (error) {
      return _handleError(error);
    }
  }

  Future<Either<Failure, SessionEntity>> _handleError(Object error) async {
    if (await networkInfo.isConnected == false) {
      return (left(InternetConnectionFailure()));
    }

    if (error is ApiProviderException &&
        error.bodyContent['error'] == 'wrongpassword') {
      return left(UserAuthenticationFailure());
    }

    return left(ServerFailure());
  }
}
