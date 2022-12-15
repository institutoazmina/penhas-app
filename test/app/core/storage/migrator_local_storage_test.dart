import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/core/storage/local_storage_shared_preferences.dart';
import 'package:penhas/app/core/storage/migrator_local_storage.dart';
import 'package:penhas/app/core/storage/secure_local_storage.dart';

void main() {
  group('MigratorLocalStorageTest', () {
    late LocalStorageSharedPreferences sharedPreferencesStorage;
    late SecureLocalStorage secureLocalStorage;
    late ILocalStorage migratorLocalStorage;

    setUp(() {
      sharedPreferencesStorage = LocalStorageSharedPreferencesMock();
      secureLocalStorage = SecureLocalStorageMock();

      migratorLocalStorage = MigratorLocalStorage(
        sharedPreferencesStorage: sharedPreferencesStorage,
        secureLocalStorage: secureLocalStorage,
      );
    });

    test(
      'when `secureLocalStorage.hasKey` returns true `hasKey` should not call `sharedPreferencesStorage.hasKey`',
      () async {
        // arrange
        const key = 'any key';

        when(() => secureLocalStorage.hasKey(any()))
            .thenAnswer((_) async => true);

        // act
        final actualHasKey = await migratorLocalStorage.hasKey(key);

        // assert
        verify(() => secureLocalStorage.hasKey(key)).called(1);
        verifyNever(() => sharedPreferencesStorage.hasKey(key));
        expect(actualHasKey, true);
      },
    );

    test(
      'when `secureLocalStorage.hasKey` returns false `hasKey` should return `sharedPreferencesStorage.hasKey` result',
      () async {
        // arrange
        const key = 'any key';
        final expectedHasKey = Random().nextBool();

        when(() => secureLocalStorage.hasKey(any()))
            .thenAnswer((_) async => false);

        when(() => sharedPreferencesStorage.hasKey(any()))
            .thenAnswer((_) async => expectedHasKey);

        // act
        final actualHasKey = await migratorLocalStorage.hasKey(key);

        // assert
        verify(() => secureLocalStorage.hasKey(key)).called(1);
        verify(() => sharedPreferencesStorage.hasKey(key)).called(1);
        expect(actualHasKey, expectedHasKey);
      },
    );

    test(
      'when key exists `get` should return value from `secureLocalStorage`',
      () async {
        // arrange
        const key = 'generic key';
        const expectedValue = 'value from secure storage';

        when(() => secureLocalStorage.hasKey(key))
            .thenAnswer((_) async => true);
        when(() => secureLocalStorage.get(key))
            .thenAnswer((_) async => expectedValue);

        // act
        final actualValue = await migratorLocalStorage.get(key);

        // assert
        verifyZeroInteractions(sharedPreferencesStorage);
        expect(actualValue, expectedValue);
      },
    );

    test(
      'when key not exists `get` should return value from `sharedPreferencesStorage`',
      () async {
        // arrange
        const key = 'unsafe key';
        const expectedValue = 'value from shared preferences';

        when(() => secureLocalStorage.hasKey(key))
            .thenAnswer((_) async => false);
        when(() => sharedPreferencesStorage.get(key))
            .thenAnswer((_) async => expectedValue);
        when(() => secureLocalStorage.put(key, expectedValue))
            .thenAnswer((_) async {});
        when(() => sharedPreferencesStorage.delete(key))
            .thenAnswer((_) async {});

        // act
        final actualValue = await migratorLocalStorage.get(key);

        // assert
        expect(actualValue, expectedValue);
      },
    );

    test(
      'when key not exists `get` should set value from `sharedPreferencesStorage`',
      () async {
        // arrange
        const key = 'this key will be ok';
        const value = 'and this value will be safe';

        when(() => secureLocalStorage.hasKey(key))
            .thenAnswer((_) async => false);
        when(() => sharedPreferencesStorage.get(key))
            .thenAnswer((_) async => value);
        when(() => secureLocalStorage.put(key, value)).thenAnswer((_) async {});
        when(() => sharedPreferencesStorage.delete(key))
            .thenAnswer((_) async {});

        // act
        await migratorLocalStorage.get(key);

        // assert
        verify(() => secureLocalStorage.put(key, value)).called(1);
        verify(() => sharedPreferencesStorage.delete(key)).called(1);
      },
    );

    test(
      '`put` should call `sharedPreferencesStorage.delete`',
      () async {
        // arrange
        const key = 'the key';
        const value = 'value only for secure storage';

        when(() => secureLocalStorage.put(key, value)).thenAnswer((_) async {});
        when(() => sharedPreferencesStorage.delete(key))
            .thenAnswer((_) async {});

        // act
        await migratorLocalStorage.put(key, value);

        // assert
        verify(() => sharedPreferencesStorage.delete(key)).called(1);
      },
    );

    test(
      '`put` should call `secureLocalStorage.put`',
      () async {
        const key = 'the key';
        const value = 'value only for secure storage';

        when(() => secureLocalStorage.put(key, value)).thenAnswer((_) async {});
        when(() => sharedPreferencesStorage.delete(key))
            .thenAnswer((_) async {});

        await migratorLocalStorage.put(key, value);

        verify(() => secureLocalStorage.put(key, value)).called(1);
      },
    );

    test(
      '`delete` should be called for all storages',
      () async {
        const key = 'this key have to go now';

        when(() => secureLocalStorage.delete(key)).thenAnswer((_) async {});
        when(() => sharedPreferencesStorage.delete(key))
            .thenAnswer((_) async {});

        await migratorLocalStorage.delete(key);

        verify(() => secureLocalStorage.delete(key)).called(1);
        verify(() => sharedPreferencesStorage.delete(key)).called(1);
      },
    );
  });
}

class LocalStorageSharedPreferencesMock extends Mock
    implements LocalStorageSharedPreferences {}

class SecureLocalStorageMock extends Mock implements SecureLocalStorage {}
