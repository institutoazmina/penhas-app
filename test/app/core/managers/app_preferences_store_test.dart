import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/app_preferences_store.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/features/appstate/data/model/app_preferences_model.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_preferences_entity.dart';

void main() {
  group('AppPreferencesStoreTest', () {
    late AppPreferencesStore appPreferencesStore;
    late ILocalStorage storage;

    const key = 'br.com.penhas.app_preferences';

    setUp(() {
      storage = _LocalStorageMock();
      appPreferencesStore = AppPreferencesStore(storage: storage);
    });

    test(
      '`save` should call `storage.put`',
      () async {
        // arrange
        const expectedData = {
          'inactive_app_since': 42,
          'inactive_app_logout_time': 123,
        };
        when(() => storage.put(key, any())).thenAnswer((_) async {});

        const appPreferencesEntity = AppPreferencesEntity(
          inactiveAppSince: 42,
          inactiveAppLogoutTimeInSeconds: 123,
        );

        // act
        appPreferencesStore.save(appPreferencesEntity);

        // assert
        final captured = verify(() => storage.put(key, captureAny())).captured;
        expect(captured.length, 1);

        final actualData = jsonDecode(captured.last);
        expect(actualData, equals(expectedData));
      },
    );

    test(
      '`retrieve` should return data from `storage`',
      () async {
        // arrange
        const expectedAppPreferences = AppPreferencesModel(
          inactiveAppSince: 12,
          inactiveAppLogoutTimeInSeconds: 34,
        );
        const serializedData =
            '{"inactive_app_since":12,"inactive_app_logout_time":34}';

        when(() => storage.get(key)).thenAnswer((_) async => serializedData);

        // act
        final actualAppPreferences = await appPreferencesStore.retrieve();

        // assert
        expect(actualAppPreferences, equals(expectedAppPreferences));
      },
    );

    test(
      'when key not exists in storage `retrieve` should return default value',
      () async {
        // arrange
        const expectedAppPreferences = AppPreferencesEntity(
          inactiveAppSince: null,
          inactiveAppLogoutTimeInSeconds: 30,
        );

        when(() => storage.get(key)).thenAnswer((_) async => null);

        // act
        final actualAppPreferences = await appPreferencesStore.retrieve();

        // assert
        expect(actualAppPreferences, equals(expectedAppPreferences));
      },
    );

    test(
      '`retrieve` should return same saved data',
      () async {
        // arrange
        const expectedAppPreferences = AppPreferencesModel(
          inactiveAppSince: 321,
          inactiveAppLogoutTimeInSeconds: 0x12,
        );

        String? savedData;
        when(() => storage.put(key, any())).thenAnswer((invocation) async {
          savedData = invocation.positionalArguments[1];
        });
        when(() => storage.get(key)).thenAnswer((_) async => savedData);

        // act
        await appPreferencesStore.save(expectedAppPreferences);
        final actualAppPreferences = await appPreferencesStore.retrieve();

        // assert
        expect(actualAppPreferences, equals(expectedAppPreferences));
      },
    );

    test(
      '`delete` should call `storage.delete`',
      () async {
        // arrange
        when(() => storage.delete(key)).thenAnswer((_) async {});

        // act
        appPreferencesStore.delete();

        // assert
        verify(() => storage.delete(key)).called(1);
      },
    );
  });
}

class _LocalStorageMock extends Mock implements ILocalStorage {}
