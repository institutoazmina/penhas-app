import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/appstate/data/app_state_model.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';

import '../../../../../utils/json_util.dart';

abstract class IAppStateRepository {
  Future<Either<Failure, AppStateEntity>> check();
}

abstract class IAppStateDataSource {
  Future<AppStateModel> check();
}

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

class MockAppStateDataSource extends Mock implements IAppStateDataSource {}

class MockNetworkInfo extends Mock implements INetworkInfo {}

void main() {
  IAppStateRepository sut;
  INetworkInfo networkInfo;
  Map<String, Object> jsonData;
  IAppStateDataSource dataSource;

  setUp(() async {
    networkInfo = MockNetworkInfo();
    dataSource = MockAppStateDataSource();
    sut = AppStateRepository(
      dataSource: dataSource,
      networkInfo: networkInfo,
    );
    jsonData =
        await JsonUtil.getJson(from: 'profile/about_with_quiz_session.json');
  });

  group('AppStateRepository', () {
    test('should return valid AppStateEntity for a valid session', () async {
      // arrange
      final expectedModel = AppStateModel.fromJson(jsonData);
      final AppStateEntity expectedEntity = expectedModel;
      when(dataSource.check()).thenAnswer((_) => Future.value(expectedModel));
      // act
      final received = await sut.check();
      // assert
      expect(received, right(expectedEntity));
    });
    test('should return ServerSideSessionFailed', () async {
      // arrange
      when(dataSource.check()).thenThrow(ApiProviderSessionExpection());
      final expected = left(ServerSideSessionFailed());
      // act
      final received = await sut.check();
      // assert
      expect(received, expected);
    });
  });
}
