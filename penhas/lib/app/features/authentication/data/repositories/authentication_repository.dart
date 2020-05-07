import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/authentication/data/datasources/authentication_data_source.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  final IAuthenticationDataSource _dataSource;
  final INetworkInfo _networkInfo;
  final IAppConfiguration _appConfiguration;

  factory AuthenticationRepository({
    @required INetworkInfo networkInfo,
    @required IAppConfiguration appConfiguration,
    @required IAuthenticationDataSource dataSource,
  }) {
    return AuthenticationRepository._(
      dataSource,
      networkInfo,
      appConfiguration,
    );
  }

  AuthenticationRepository._(
    this._dataSource,
    this._networkInfo,
    this._appConfiguration,
  );

  @override
  Future<Either<Failure, SessionEntity>> signInWithEmailAndPassword({
    EmailAddress emailAddress,
    Password password,
  }) async {
    try {
      final result = await _dataSource.signInWithEmailAndPassword(
        emailAddress: emailAddress,
        password: password,
      );

      await _appConfiguration.saveApiToken(token: result.sessionToken);

      return right(result);
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<Either<Failure, SessionEntity>> _handleError(Object error) async {
    if (await _networkInfo.isConnected == false) {
      return (left(InternetConnectionFailure()));
    }

    if (error is ApiProviderException) {
      if (error.bodyContent['error'] == 'wrongpassword') {
        return left(UserAuthenticationFailure());
      } else {
        return left(
          ServerSideFormFieldValidationFailure(
            error: error.bodyContent['error'],
            field: error.bodyContent['field'],
            message: error.bodyContent['message'],
            reason: error.bodyContent['reason'],
          ),
        );
      }
    }

    return left(ServerFailure());
  }
}
