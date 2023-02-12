import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/appstate/data/datasources/app_state_data_source.dart';
import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';
import 'package:penhas/app/features/appstate/data/repositories/app_state_repository.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/entities/update_user_profile_entity.dart';
import 'package:penhas/app/features/appstate/domain/repositories/i_app_state_repository.dart';

import '../../../../../utils/json_util.dart';

class MockNetworkInfo extends Mock implements INetworkInfo {}

class MockAppStateDataSource extends Mock implements IAppStateDataSource {}

void main() {
  late INetworkInfo networkInfo;
  late IAppStateRepository sut;
  late IAppStateDataSource dataSource;
  late Map<String, dynamic> jsonData;

  setUpAll(() {
    registerFallbackValue(UpdateUserProfileEntity());
  });

  setUp(() async {
    networkInfo = MockNetworkInfo();
    dataSource = MockAppStateDataSource();
    sut = AppStateRepository(
      dataSource: dataSource,
      networkInfo: networkInfo,
    );
    jsonData =
        await JsonUtil.getJson(from: 'profile/about_with_quiz_session.json');
    when(() => networkInfo.isConnected).thenAnswer((_) async => true);
  });

  group(AppStateRepository, () {
    group('check()', () {
      test('return valid AppStateEntity for a valid session', () async {
        // arrange
        final expectedModel = AppStateModel.fromJson(jsonData);
        final AppStateEntity expectedEntity = expectedModel;
        when(() => dataSource.check()).thenAnswer((_) async => expectedModel);
        // act
        final received = await sut.check();
        // assert
        expect(received, right(expectedEntity));
      });

      test('return ServerSideSessionFailed for a invalid session', () async {
        // arrange
        when(() => dataSource.check()).thenThrow(ApiProviderSessionError());
        final expected = left(ServerSideSessionFailed());
        // act
        final received = await sut.check();
        // assert
        expect(received, expected);
      });

      test('return ServerSideSessionFailed for a invalid JWT', () async {
        // arrange
        when(() => dataSource.check()).thenThrow(
          const ApiProviderException(
            bodyContent: {
              'error': 'expired_jwt',
              'nessage': 'Bad request - Invalid JWT'
            },
          ),
        );
        final expected = left(ServerSideSessionFailed());
        // act
        final received = await sut.check();
        // assert
        expect(received, expected);
      });

      test(
          'return ServerSideFormFieldValidationFailure for ApiProviderException',
          () async {
        // arrange
        const exception = ApiProviderException(
          bodyContent: {
            'error': 'other_error',
            'message': 'my message',
          },
        );
        when(() => dataSource.check()).thenThrow(exception);
        final expected = left(
          ServerSideFormFieldValidationFailure(
            error: 'other_error',
            message: 'my message',
          ),
        );
        // act
        final received = await sut.check();
        // assert
        expect(received, expected);
      });
    });

    group('update', () {
      test('return valid AppStateEntity for a valid session', () async {
        // arrange
        final expectedModel = AppStateModel.fromJson(jsonData);
        final AppStateEntity expectedEntity = expectedModel;
        when(() => dataSource.update(any()))
            .thenAnswer((_) async => expectedModel);
        final profile = UpdateUserProfileEntity();
        // act
        final received = await sut.update(profile);
        // assert
        expect(received, right(expectedEntity));
      });

      test('return ServerSideSessionFailed for a invalid session', () async {
        // arrange
        when(() => dataSource.update(any()))
            .thenThrow(ApiProviderSessionError());
        final expected = left(ServerSideSessionFailed());
        final profile = UpdateUserProfileEntity();
        // act
        final received = await sut.update(profile);
        // assert
        expect(received, expected);
      });

      test('return ServerSideSessionFailed for a invalid JWT', () async {
        // arrange
        when(() => dataSource.update(any())).thenThrow(
          const ApiProviderException(
            bodyContent: {
              'error': 'expired_jwt',
              'nessage': 'Bad request - Invalid JWT'
            },
          ),
        );
        final expected = left(ServerSideSessionFailed());
        final profile = UpdateUserProfileEntity();
        // act
        final received = await sut.update(profile);
        // assert
        expect(received, expected);
      });

      test(
          'return ServerSideFormFieldValidationFailure for ApiProviderException',
          () async {
        // arrange
        const exception = ApiProviderException(
          bodyContent: {
            'error': 'other_error',
            'message': 'my message',
          },
        );
        when(() => dataSource.update(any())).thenThrow(exception);
        final expected = left(
          ServerSideFormFieldValidationFailure(
            error: 'other_error',
            message: 'my message',
          ),
        );
        final profile = UpdateUserProfileEntity();
        // act
        final received = await sut.update(profile);
        // assert
        expect(received, expected);
      });
    });
  });
}
