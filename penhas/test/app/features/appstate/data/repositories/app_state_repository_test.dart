import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';
import 'package:penhas/app/features/appstate/data/repositories/app_state_repository.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/repositories/i_app_state_repository.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

void main() {
<<<<<<< HEAD
  late final INetworkInfo networkInfo = MockINetworkInfo();
  late final MockIAppStateDataSource dataSource = MockIAppStateDataSource();
  late Map<String, dynamic> jsonData;

  late final IAppStateRepository sut = AppStateRepository(
    dataSource: dataSource,
    networkInfo: networkInfo,
  );
=======
  late IAppStateRepository sut;
  INetworkInfo networkInfo;
  late Map<String, Object> jsonData;
  IAppStateDataSource? dataSource;
>>>>>>> Migrate code to nullsafety

  setUp(() async {
    when(networkInfo.isConnected).thenAnswer((_) => Future.value(true));
    jsonData =
        await JsonUtil.getJson(from: 'profile/about_with_quiz_session.json');
  });

  group('AppStateRepository', () {
    test('should return valid AppStateEntity for a valid session', () async {
      // arrange
      final expectedModel = AppStateModel.fromJson(jsonData);
      final AppStateEntity expectedEntity = expectedModel;
      when(dataSource!.check()).thenAnswer((_) => Future.value(expectedModel));
      // act
      final received = await sut.check();
      // assert
      expect(received, right(expectedEntity));
    });

    test('should return ServerSideSessionFailed for a invalid session',
        () async {
      // arrange
<<<<<<< HEAD
      when(dataSource.check()).thenThrow(ApiProviderSessionError());
=======
      when(dataSource!.check()).thenThrow(ApiProviderSessionExpection());
>>>>>>> Migrate code to nullsafety
      final expected = left(ServerSideSessionFailed());
      // act
      final received = await sut.check();
      // assert
      expect(received, expected);
    });

    test('should return ServerSideSessionFailed for a invalid JWT', () async {
      // arrange
<<<<<<< HEAD
      when(dataSource.check()).thenThrow(
        const ApiProviderException(
          bodyContent: {
            'error': 'expired_jwt',
            'nessage': 'Bad request - Invalid JWT'
          },
        ),
=======
      when(dataSource!.check()).thenThrow(
        ApiProviderException(bodyContent: {
          "error": "expired_jwt",
          "nessage": "Bad request - Invalid JWT"
        }),
>>>>>>> Migrate code to nullsafety
      );
      final expected = left(ServerSideSessionFailed());
      // act
      final received = await sut.check();
      // assert
      expect(received, expected);
    });
  });
}
