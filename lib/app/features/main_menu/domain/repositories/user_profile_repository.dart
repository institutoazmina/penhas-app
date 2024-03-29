import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/entities/valid_fiel.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_server_configure.dart';
import '../../../../shared/logger/log.dart';
import '../../../authentication/presentation/shared/map_exception_to_failure.dart';
import '../../data/model/account_preference_model.dart';

abstract class IUserProfileRepository {
  Future<Either<Failure, ValidField>> stealthMode({required bool toggle});
  Future<Either<Failure, ValidField>> anonymousMode({required bool toggle});
  Future<Either<Failure, ValidField>> deleteNotice();
  Future<Either<Failure, ValidField>> delete({required String password});
  Future<Either<Failure, ValidField>> reactivate({required String? token});
  Future<Either<Failure, AccountPreferenceSessionModel>> preferences();
  Future<Either<Failure, AccountPreferenceSessionModel>> updatePreferences({
    required String key,
    required bool status,
  });
}

class UserProfileRepository implements IUserProfileRepository {
  UserProfileRepository({
    required IApiProvider apiProvider,
    required IApiServerConfigure serverConfiguration,
  })  : _apiProvider = apiProvider,
        _serverConfiguration = serverConfiguration;

  final IApiProvider _apiProvider;
  final IApiServerConfigure _serverConfiguration;

  @override
  Future<Either<Failure, ValidField>> stealthMode({
    required bool toggle,
  }) async {
    const endPoint = '/me/modo-camuflado-toggle';
    final parameters = {'active': toggle ? '1' : '0'};

    try {
      final response = await _apiProvider
          .post(path: endPoint, parameters: parameters)
          .parseValidField();
      return right(response);
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ValidField>> anonymousMode({
    required bool toggle,
  }) async {
    const endPoint = '/me/modo-anonimo-toggle';
    final parameters = {'active': toggle ? '1' : '0'};

    try {
      final response = await _apiProvider
          .post(path: endPoint, parameters: parameters)
          .parseValidField();
      return right(response);
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ValidField>> delete({
    required String password,
  }) async {
    const endPoint = '/me';

    final parameters = {
      'senha_atual': password,
      'app_version': await _serverConfiguration.userAgent
    };

    try {
      await _apiProvider.delete(path: endPoint, parameters: parameters);
      return right(const ValidField());
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ValidField>> deleteNotice() async {
    const endPoint = '/me/delete-text';

    try {
      final response = await _apiProvider.get(path: endPoint).parseValidField();
      return right(response);
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ValidField>> reactivate({
    required String? token,
  }) async {
    const endPoint = '/reactivate';
    final parameters = {
      'app_version': await _serverConfiguration.userAgent,
      'api_key': token,
    };

    try {
      await _apiProvider.post(path: endPoint, parameters: parameters);
      return right(ValidField(message: token));
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, AccountPreferenceSessionModel>> preferences() async {
    const endPoint = '/me/preferences';

    try {
      final data = await _apiProvider.get(path: endPoint);
      final jsonData = jsonDecode(data) as Map<String, dynamic>;
      final session = AccountPreferenceSessionModel.fromJson(jsonData);
      return right(session);
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, AccountPreferenceSessionModel>> updatePreferences({
    required String key,
    required bool status,
  }) async {
    const endPoint = '/me/preferences';
    final parameters = {key: status ? '1' : '0'};

    try {
      final data =
          await _apiProvider.post(path: endPoint, parameters: parameters);
      final jsonData = jsonDecode(data) as Map<String, dynamic>;
      final session = AccountPreferenceSessionModel.fromJson(jsonData);
      return right(session);
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }
}
