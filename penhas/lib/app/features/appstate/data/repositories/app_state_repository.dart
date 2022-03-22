import 'package:dartz/dartz.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/appstate/data/datasources/app_state_data_source.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/entities/update_user_profile_entity.dart';
import 'package:penhas/app/features/appstate/domain/repositories/i_app_state_repository.dart';
import 'package:penhas/app/shared/logger/log.dart';

class AppStateRepository implements IAppStateRepository {
  AppStateRepository({
    required INetworkInfo networkInfo,
    required IAppStateDataSource dataSource,
  })  : _dataSource = dataSource,
        _networkInfo = networkInfo;

  final INetworkInfo _networkInfo;
  final IAppStateDataSource _dataSource;

  @override
  Future<Either<Failure, AppStateEntity>> check() async {
    try {
      final appState = await _dataSource.check();
      return right(appState);
    } catch (e, stack) {
      logError(e, stack);
      return left(await _handleError(e));
    }
  }

  @override
  Future<Either<Failure, AppStateEntity>> update(
    UpdateUserProfileEntity update,
  ) async {
    try {
      final appState = await _dataSource.update(update);
      return right(appState);
    } catch (e, stack) {
      logError(e, stack);
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
        message: error.bodyContent['message'],
      );
    }

    if (error is ApiProviderSessionError) {
      return ServerSideSessionFailed();
    }

    return ServerFailure();
  }
}
