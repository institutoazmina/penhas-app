import 'dart:convert';
import 'package:crypto/crypto.dart';
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
import '../models/session_model.dart';

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
      if (await _networkInfo.isConnected == false) {
        final session = await _loginOffline(password: password.toString());
        if (session != null) {
          return right(session);
        }
      }

      final result = await _dataSource.signInWithEmailAndPassword(
        emailAddress: emailAddress,
        password: password,
      );

      if (!result.deletedScheduled) {
        await _saveUserData(result: result, password: password.toString());
      }

      return right(result);
    } catch (error, stack) {
      logError(error, stack);
      return _handleError(error);
    }
  }

  String _createsHash({required String password}) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<SessionModel?> _loginOffline({required String password}) async {
    var currentHash = await _appConfiguration.offlineHash;
    var sessionToken = await _appConfiguration.apiToken;
    final newHash = _createsHash(password: password);
    final isCorrectPassword = currentHash.toString() == newHash.toString();
    if (isCorrectPassword) {
      var result =
          _dataSource.signInWithOfflineHash(sessionToken: sessionToken);
      return result;
    }
    return null;
  }

  _saveUserData(
      {required SessionModel result, required String password}) async {
    await _appConfiguration.saveApiToken(token: result.sessionToken);
    final hash = _createsHash(password: password);
    await _appConfiguration.saveHash(hash: hash);
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
