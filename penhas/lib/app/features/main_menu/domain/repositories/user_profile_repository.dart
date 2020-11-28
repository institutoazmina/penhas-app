import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_exception_to_failure.dart';

abstract class IUserProfileRepository {
  Future<Either<Failure, ValidField>> stealthMode({@required bool toggle});
  Future<Either<Failure, ValidField>> anonymousMode({@required bool toggle});
  Future<Either<Failure, ValidField>> deleteNotice();
  Future<Either<Failure, ValidField>> delete({@required String password});
  Future<Either<Failure, ValidField>> reactivate();
}

class UserProfileRepository implements IUserProfileRepository {
  final IApiProvider _apiProvider;
  final IApiServerConfigure _serverConfiguration;

  UserProfileRepository({
    @required IApiProvider apiProvider,
    @required IApiServerConfigure serverConfiguration,
  })  : this._apiProvider = apiProvider,
        this._serverConfiguration = serverConfiguration;

  @override
  Future<Either<Failure, ValidField>> stealthMode({bool toggle}) async {
    final endPoint = ['me', 'modo-camuflado-toggle'].join('/');
    final parameters = {'active': toggle ? '1' : '0'};

    try {
      final response = await _apiProvider
          .post(path: endPoint, parameters: parameters)
          .parseValidField();
      return right(response);
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ValidField>> anonymousMode({bool toggle}) async {
    final endPoint = ['me', 'modo-anonimo-toggle'].join('/');
    final parameters = {'active': toggle ? '1' : '0'};

    try {
      final response = await _apiProvider
          .post(path: endPoint, parameters: parameters)
          .parseValidField();
      return right(response);
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ValidField>> delete(
      {@required String password}) async {
    final endPoint = '/me';

    final parameters = {
      'senha_atual': password,
      'app_version': await _serverConfiguration.userAgent
    };

    try {
      await _apiProvider.delete(path: endPoint, parameters: parameters);
      return right(ValidField());
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ValidField>> deleteNotice() async {
    final endPoint = ['me', 'delete-text'].join('/');

    try {
      final response = await _apiProvider.get(path: endPoint).parseValidField();
      return right(response);
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ValidField>> reactivate() async {
    final endPoint = '/reactivate';

    final parameters = {'app_version': await _serverConfiguration.userAgent};

    try {
      await _apiProvider.post(path: endPoint, parameters: parameters);
      return right(ValidField());
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }
}
