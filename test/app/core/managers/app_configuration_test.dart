import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/data/authorization_status.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';

void main() {
  group('AppConfigurationTest', () {
    const apiTokenKey = 'br.com.penhas.tokenServer';
    const appModeKey = 'br.com.penhas.appConfigurationModes';

    late ILocalStorage localStorage;
    late IAppConfiguration appConfiguration;

    setUp(() {
      localStorage = LocalStorageMock();
      appConfiguration = AppConfiguration(storage: localStorage);
    });

    test(
      'should retrieve api key from storage',
      () async {
        // arrange
        const expectedApiKey = 'mocked api key';

        when(() => localStorage.get(apiTokenKey))
            .thenAnswer((_) async => expectedApiKey);

        // act
        final actualApiKey = await appConfiguration.apiToken;

        // assert
        expect(actualApiKey, expectedApiKey);
      },
    );

    test(
      'when api key is null `authorizationStatus` should be `anonymous`',
      () async {
        // arrange
        when(() => localStorage.get(apiTokenKey)).thenAnswer((_) async => null);

        // act
        final actualAuthorizationStatus =
            await appConfiguration.authorizationStatus;

        // assert
        expect(actualAuthorizationStatus, AuthorizationStatus.anonymous);
      },
    );

    test(
      'when api key is not null `authorizationStatus` should be `authenticated`',
      () async {
        // arrange
        when(() => localStorage.get(apiTokenKey))
            .thenAnswer((_) async => 'not null api key');

        // act
        final actualAuthorizationStatus =
            await appConfiguration.authorizationStatus;

        // assert
        expect(actualAuthorizationStatus, AuthorizationStatus.authenticated);
      },
    );

    test(
      'when app mode is null `appMode` should be default',
      () async {
        // arrange
        const expectedAppMode = AppStateModeEntity();

        when(() => localStorage.get(appModeKey)).thenAnswer((_) async => null);

        // act
        final actualAppMode = await appConfiguration.appMode;

        // assert
        expect(actualAppMode, expectedAppMode);
      },
    );

    test(
      'when app mode is not null `appMode` should be parsed',
      () async {
        // arrange
        const expectedAppMode = AppStateModeEntity(hasActivedGuardian: true);

        when(() => localStorage.get(appModeKey))
            .thenAnswer((_) async => jsonEncode(expectedAppMode.toJson()));

        // act
        final actualAppMode = await appConfiguration.appMode;

        // assert
        expect(actualAppMode, expectedAppMode);
      },
    );

    test(
      '`saveApiToken` should put value to storage',
      () async {
        // arrange
        const token = 'api token to be saved';

        when(() => localStorage.put(apiTokenKey, token))
            .thenAnswer((_) async {});

        // act
        await appConfiguration.saveApiToken(token: token);

        // assert
        verify(() => localStorage.put(apiTokenKey, token)).called(1);
      },
    );

    test(
      '`saveAppModes` should put value to storage',
      () async {
        // arrange
        const appMode = AppStateModeEntity();
        final expectedAppMode = jsonEncode(appMode.toJson());

        when(() => localStorage.put(appModeKey, expectedAppMode))
            .thenAnswer((_) async {});

        // act
        await appConfiguration.saveAppModes(appMode);

        // assert
        verify(() => localStorage.put(appModeKey, expectedAppMode)).called(1);
      },
    );
  });
}

class LocalStorageMock extends Mock implements ILocalStorage {}
