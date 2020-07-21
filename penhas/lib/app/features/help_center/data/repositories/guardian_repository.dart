import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/help_center/data/datasources/guardian_data_source.dart';
import 'package:penhas/app/features/help_center/domain/entities/guardian_session_entity.dart';

abstract class IGuardianRepository {
  Future<Either<Failure, GuardianSessioEntity>> fetch();
  Future<Either<Failure, ValidField>> create(GuardianContactEntity guardian);
  Future<Either<Failure, ValidField>> update(GuardianContactEntity guardian);
  Future<Either<Failure, ValidField>> delete(GuardianContactEntity guardian);
}

@immutable
class GuardianRepository extends IGuardianRepository {
  final IGuardianDataSource _dataSource;
  final INetworkInfo _networkInfo;

  GuardianRepository({
    @required IGuardianDataSource dataSource,
    @required INetworkInfo networkInfo,
  })  : this._networkInfo = networkInfo,
        this._dataSource = dataSource;

  @override
  Future<Either<Failure, GuardianSessioEntity>> fetch() async {
    try {
      final result = await _dataSource.fetch();
      return right(result);
    } catch (e) {
      return left(await _handleError(e));
    }
  }

  @override
  Future<Either<Failure, ValidField>> create(
      GuardianContactEntity guardian) async {
    try {
      final result = await _dataSource.create(guardian);
      return right(result);
    } catch (e) {
      return left(await _handleError(e));
    }
  }

  @override
  Future<Either<Failure, ValidField>> update(
      GuardianContactEntity guardian) async {
    try {
      final result = await _dataSource.update(guardian);
      return right(result);
    } catch (e) {
      return left(await _handleError(e));
    }
  }

  @override
  Future<Either<Failure, ValidField>> delete(
      GuardianContactEntity guardian) async {
    try {
      final result = await _dataSource.delete(guardian);
      return right(result);
    } catch (e) {
      return left(await _handleError(e));
    }
  }

  Future<Failure> _handleError(Object error) async {
    if (await _networkInfo.isConnected == false) {
      return InternetConnectionFailure();
    }

    if (error is ApiProviderException) {
      if (error.bodyContent['error'] == 'expired_jwt') {
        return ServerSideSessionFailed();
      }

      return ServerSideFormFieldValidationFailure(
          error: error.bodyContent['error'],
          field: error.bodyContent['field'],
          reason: error.bodyContent['reason'],
          message: error.bodyContent['message']);
    }

    if (error is ApiProviderSessionExpection) {
      return ServerSideSessionFailed();
    }

    return ServerFailure();
  }
}
