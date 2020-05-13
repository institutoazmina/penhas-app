import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/appstate/data/datasources/app_state_data_source.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/repositories/i_app_state_repository.dart';

class AppStateRepository implements IAppStateRepository {
  final INetworkInfo _networkInfo;
  final IAppStateDataSource _dataSource;

  AppStateRepository({
    @required INetworkInfo networkInfo,
    @required IAppStateDataSource dataSource,
  })  : this._dataSource = dataSource,
        this._networkInfo = networkInfo;

  @override
  Future<Either<Failure, AppStateEntity>> check() async {
    try {
      final appState = await _dataSource.check();
      return right(appState);
    } catch (e) {
      return left(await _handleError(e));
    }
  }

  Future<Failure> _handleError(Object error) async {
    if (await _networkInfo.isConnected == false) {
      return InternetConnectionFailure();
    }

    if (error is ApiProviderException) {
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
