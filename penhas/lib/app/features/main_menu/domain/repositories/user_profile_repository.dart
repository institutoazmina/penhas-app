import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_exception_to_failure.dart';

abstract class IUserProfileRepository {
  Future<Either<Failure, ValidField>> stealthMode({@required bool toggle});
  Future<Either<Failure, ValidField>> anonymousMode({@required bool toggle});
  Future<Either<Failure, ValidField>> deleteNotice();
  Future<Either<Failure, ValidField>> delete({@required String password});
}

class UserProfileRepository implements IUserProfileRepository {
  final IApiProvider _apiProvider;

  UserProfileRepository({
    @required IApiProvider apiProvider,
  }) : this._apiProvider = apiProvider;

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
    final parameters = {'senha_atual': password};

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
}
