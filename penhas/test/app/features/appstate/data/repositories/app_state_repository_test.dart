import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/appstate/data/datasources/app_state_data_source.dart';
import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';
import 'package:penhas/app/features/appstate/data/repositories/app_state_repository.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/repositories/i_app_state_repository.dart';

import '../../../../../utils/json_util.dart';

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
    test('should return ServerSideSessionFailed for a invalid session',
        () async {
      // arrange
      when(dataSource.check()).thenThrow(ApiProviderSessionExpection());
      final expected = left(ServerSideSessionFailed());
      // act
      final received = await sut.check();
      // assert
      expect(received, expected);
    });

    test('should return ServerSideSessionFailed for a invalid JWT', () async {
      // arrange
      when(dataSource.check()).thenThrow(
        ApiProviderException(bodyContent: {
          "error": "expired_jwt",
          "nessage": "Bad request - Invalid JWT"
        }),
      );
      final expected = left(ServerSideSessionFailed());
      // act
      final received = await sut.check();
      // assert
      expect(received, expected);
    });
  });
}
