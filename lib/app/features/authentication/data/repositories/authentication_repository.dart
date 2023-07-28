import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/managers/app_configuration.dart';
import '../../../../core/network/network_info.dart';
import '../../../../shared/logger/log.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/repositories/i_authentication_repository.dart';
import '../../domain/usecases/email_address.dart';
import '../../domain/usecases/sign_in_password.dart';
import '../datasources/authentication_data_source.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  AuthenticationRepository({
    required INetworkInfo networkInfo,
    required IAppConfiguration appConfiguration,
    required IAuthenticationDataSource dataSource,
  })  : _dataSource = dataSource,
        _networkInfo = networkInfo,
        _appConfiguration = appConfiguration;

  final IAuthenticationDataSource _dataSource;
  final INetworkInfo _networkInfo;
  final IAppConfiguration _appConfiguration;

  @override
  Future<Either<Failure, SessionEntity>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required SignInPassword password,
  }) async {
    try {
      final result = await _dataSource.signInWithEmailAndPassword(
        emailAddress: emailAddress,
        password: password,
      );

      if (!result.deletedScheduled) {
        await _appConfiguration.saveApiToken(token: result.sessionToken);
      }

      return right(result);
    } catch (error, stack) {
      logError(error, stack);
      return _handleError(error);
    }
  }

  Future<Either<Failure, SessionEntity>> _handleError(Object error) async {
    if (await _networkInfo.isConnected == false) {
      return left(InternetConnectionFailure());
    }

    if (error is ApiProviderException) {
      return left(
        ServerSideFormFieldValidationFailure(
          error: error.bodyContent['error'],
          field: error.bodyContent['field'],
          message: error.bodyContent['message'],
          reason: error.bodyContent['reason'],
        ),
      );
    }

    return left(ServerFailure());
  }
}
