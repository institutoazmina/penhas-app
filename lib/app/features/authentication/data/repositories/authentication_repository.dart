import 'dart:convert';

import 'package:crypt/crypt.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/api_provider_error_mapper.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/managers/app_configuration.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_server_configure.dart';
import '../../../../shared/logger/log.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/repositories/i_authentication_repository.dart';
import '../../domain/usecases/email_address.dart';
import '../../domain/usecases/sign_in_password.dart';
import '../models/session_model.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  AuthenticationRepository({
    required IApiProvider apiProvider,
    required IAppConfiguration appConfiguration,
    required IApiServerConfigure serverConfiguration,
  })  : _appConfiguration = appConfiguration,
        _apiProvider = apiProvider,
        _serverConfiguration = serverConfiguration;

  final IApiProvider _apiProvider;
  final IAppConfiguration _appConfiguration;
  final IApiServerConfigure _serverConfiguration;
  @override
  Future<Either<Failure, SessionEntity>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required SignInPassword password,
  }) async {
    try {
      final userAgent = await _serverConfiguration.userAgent;
      final parameters = {'app_version': userAgent};
      final body = 'email=${emailAddress.rawValue}&senha=${password.rawValue}';

      final result = await _apiProvider
          .post(
            path: '/login',
            parameters: parameters,
            body: body,
          )
          .then((value) => jsonDecode(value))
          .then((value) => SessionModel.fromJson(value));

      if (result.deletedScheduled == false) {
        await _saveAuthenticationCredentials(
          result: result,
          password: password,
          email: emailAddress,
        );
      }

      return right(result);
    } catch (e, stack) {
      logError(e, stack);
      return left(ApiProviderErrorMapper.map(e));
    }
  }

  @override
  Future<Either<Failure, SessionEntity>> signInOffline({
    required EmailAddress emailAddress,
    required SignInPassword password,
  }) async {
    final result = await signInWithEmailAndPassword(
      emailAddress: emailAddress,
      password: password,
    );

    if (result.isRight()) {
      return result;
    }

    try {
      final session = await _validateOfflineCredentials(
        password: password,
        email: emailAddress,
      );

      if (session != null) {
        return right(session);
      }

      return result;
    } catch (e, stack) {
      logError(e, stack);
      return left(ApiProviderErrorMapper.map(e));
    }
  }

  Crypt _generatePasswordHash({
    required EmailAddress email,
    required SignInPassword password,
  }) {
    return Crypt.sha256(
      password.rawValue ?? '',
      salt: email.rawValue ?? '',
    );
  }

  Future<SessionModel?> _validateOfflineCredentials({
    required EmailAddress email,
    required SignInPassword password,
  }) async {
    final currentHash = await _appConfiguration.offlineHash;
    final sessionToken = await _appConfiguration.apiToken;

    if (currentHash.isEmpty || sessionToken.isEmpty) {
      return null;
    }

    final newHash = _generatePasswordHash(password: password, email: email);

    if (Crypt(currentHash) == newHash) {
      return SessionModel(sessionToken: sessionToken);
    }

    return null;
  }

  Future<void> _saveAuthenticationCredentials({
    required SessionModel result,
    required EmailAddress email,
    required SignInPassword password,
  }) async {
    await _appConfiguration.saveApiToken(token: result.sessionToken);
    final hash = _generatePasswordHash(password: password, email: email);
    await _appConfiguration.saveHash(hash: hash.toString());
  }
}
