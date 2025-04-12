import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:penhas/app/core/data/authorization_status.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

void main() {
  group(AppConfiguration, () {
    const apiTokenKey = 'br.com.penhas.tokenServer';
    const offlineHashKey = 'br.com.penhas.offlineHash';
    const appModeKey = 'br.com.penhas.appConfigurationModes';

    late ILocalStorage localStorage;
    late IAppConfiguration appConfiguration;
    late MockHive mockHive;
    setUp(() {
      mockHive = MockHive();
      localStorage = LocalStorageMock();
      PathProviderPlatform.instance = MockPathProviderPlatform();

      appConfiguration = AppConfiguration(
        storage: localStorage,
        hive: mockHive,
      );
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
      'catch error on `authorizationStatus`',
      () async {
        // arrange
        when(() => localStorage.get(apiTokenKey)).thenAnswer((_) async {
          throw ('Some error');
        });

        // act
        final actualAuthorizationStatus =
            await appConfiguration.authorizationStatus;

        // assert
        expect(actualAuthorizationStatus, AuthorizationStatus.anonymous);
      },
    );

    test(
      'should retrieve offlineHash from storage',
      () async {
        // arrange
        const expectedOfflineHash = 'mocked offline hash';

        when(() => localStorage.get(offlineHashKey))
            .thenAnswer((_) async => expectedOfflineHash);

        // act
        final actualOfflineHash = await appConfiguration.offlineHash;

        // assert
        expect(actualOfflineHash, expectedOfflineHash);
      },
    );

    test(
      'should return empty string when offlineHash is null',
      () async {
        // arrange
        when(() => localStorage.get(offlineHashKey))
            .thenAnswer((_) async => null);

        // act
        final actualOfflineHash = await appConfiguration.offlineHash;

        // assert
        expect(actualOfflineHash, '');
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

    test(
      '`saveHash` should put value to storage',
      () async {
        // arrange
        const hash = 'hash to be saved';

        when(() => localStorage.put(any(), any()))
            .thenAnswer((_) => Future.value());

        // act
        await appConfiguration.saveHash(hash: hash);

        // assert
        verify(() => localStorage.put(offlineHashKey, hash)).called(1);
      },
    );

    test(
      '`logout` should delete api token and offline hash from storage',
      skip: true,
      () async {
        // arrange
        when(() => localStorage.delete(any()))
            .thenAnswer((_) => Future.value());

        when(() => mockHive.deleteFromDisk()).thenAnswer((_) => Future.value());

        // act
        await appConfiguration.logout();

        // assert
        verify(() => localStorage.delete(apiTokenKey)).called(1);
        verify(() => localStorage.delete(offlineHashKey)).called(1);
      },
    );
  });
}

class LocalStorageMock extends Mock implements ILocalStorage {}

class MockHive extends Mock implements HiveInterface {}

class MockPathProviderPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getTemporaryPath() async => '/tmp';

  @override
  Future<String?> getApplicationSupportPath() async =>
      '/tmp/invalid-app-support-path';
}
