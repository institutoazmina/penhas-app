import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_exception_to_failure.dart';
import 'package:penhas/app/features/main_menu/data/model/account_preference_model.dart';
import 'package:penhas/app/shared/logger/log.dart';

abstract class IUserProfileRepository {
  Future<Either<Failure, ValidField>> stealthMode({required bool toggle});
  Future<Either<Failure, ValidField>> anonymousMode({required bool toggle});
  Future<Either<Failure, ValidField>> deleteNotice();
  Future<Either<Failure, ValidField>> delete({required String password});
  Future<Either<Failure, ValidField>> reactivate({required String? token});
  Future<Either<Failure, AccountPreferenceSessionModel>> preferences();
  Future<Either<Failure, AccountPreferenceSessionModel>> updatePreferences({
    required String? key,
    required bool status,
  });
}

class UserProfileRepository implements IUserProfileRepository {
  final IApiProvider? _apiProvider;
  final IApiServerConfigure _serverConfiguration;

  UserProfileRepository({
    required IApiProvider? apiProvider,
    required IApiServerConfigure serverConfiguration,
  })  : this._apiProvider = apiProvider,
        this._serverConfiguration = serverConfiguration;

  @override
  Future<Either<Failure, ValidField>> stealthMode({required bool toggle}) async {
    final endPoint = ['me', 'modo-camuflado-toggle'].join('/');
    final parameters = {'active': toggle ? '1' : '0'};

    try {
      final response = await _apiProvider!
          .post(path: endPoint, parameters: parameters)
          .parseValidField();
      return right(response);
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ValidField>> anonymousMode({required bool toggle}) async {
    final endPoint = ['me', 'modo-anonimo-toggle'].join('/');
    final parameters = {'active': toggle ? '1' : '0'};

    try {
      final response = await _apiProvider!
          .post(path: endPoint, parameters: parameters)
          .parseValidField();
      return right(response);
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ValidField>> delete(
      {required String password}) async {
    final endPoint = '/me';

    final parameters = {
      'senha_atual': password,
      'app_version': await _serverConfiguration.userAgent
    };

    try {
      await _apiProvider!.delete(path: endPoint, parameters: parameters);
      return right(ValidField());
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ValidField>> deleteNotice() async {
    final endPoint = ['me', 'delete-text'].join('/');

    try {
      final response = await _apiProvider!.get(path: endPoint).parseValidField();
      return right(response);
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ValidField>> reactivate(
      {required String? token}) async {
    final endPoint = '/reactivate';

    final parameters = {
      'app_version': await _serverConfiguration.userAgent,
      'api_key': token,
    };

    try {
      await _apiProvider!.post(path: endPoint, parameters: parameters);
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
      final data = await _apiProvider!.get(path: endPoint);
      final jsonData = jsonDecode(data) as Map<String, Object>;
      final session = AccountPreferenceSessionModel.fromJson(jsonData);
      return right(session);
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, AccountPreferenceSessionModel>> updatePreferences(
      {String? key, required bool status}) async {
    final endPoint = '/me/preferences';
    final parameters = {key: status ? "1" : "0"};

    try {
      final data =
          await _apiProvider!.post(path: endPoint, parameters: parameters);
      final jsonData = jsonDecode(data) as Map<String, Object>;
      final session = AccountPreferenceSessionModel.fromJson(jsonData);
      return right(session);
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }
}
