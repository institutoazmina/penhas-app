import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/core/storage/local_storage_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('LocalStorageSharedPreferencesTest', () {
    late SharedPreferences storage;
    late ILocalStorage localStorageSharedPreferences;

    setUp(() {
      storage = SharedPreferencesMock();
      localStorageSharedPreferences = LocalStorageSharedPreferences(
        preferences: Future.value(storage),
      );
    });

    test(
      '`put` should call `storage.setString`',
      () async {
        // arrange
        const key = 'this key will be created';
        const value = 'with this value';

        when(() => storage.setString(any(), any()))
            .thenAnswer((_) async => true);
        when(() => storage.reload()).thenAnswer((_) async {});

        // act
        await localStorageSharedPreferences.put(key, value);

        // assert
        verify(() => storage.setString(key, value)).called(1);
      },
    );

    test(
      '`hasKey` should return `storage.containsKey` value',
      () async {
        // arrange
        const key = 'just a key';
        final expectedHasKey = Random().nextBool();

        when(() => storage.containsKey(key)).thenReturn(expectedHasKey);

        // act
        final actualHasKey = await localStorageSharedPreferences.hasKey(key);

        // assert
        expect(actualHasKey, expectedHasKey);
        verify(() => storage.containsKey(key)).called(1);
      },
    );

    test(
      '`get` should return `storage.read` value',
      () async {
        // arrange
        const key = 'it is a key';
        const expectedValue = 'a expected value';

        when(() => storage.getString(key)).thenReturn(expectedValue);

        // act
        final actualValue = await localStorageSharedPreferences.get(key);

        // assert
        expect(actualValue, expectedValue);
        verify(() => storage.getString(key)).called(1);
      },
    );

    test(
      '`delete` should call `storage.delete`',
      () async {
        // arrange
        const key = 'bye bye key';

        when(() => storage.remove(key)).thenAnswer((_) async => true);
        when(() => storage.reload()).thenAnswer((_) async {});

        // act
        await localStorageSharedPreferences.delete(key);

        // assert
        verify(() => storage.remove(key)).called(1);
      },
    );
  });
}

class SharedPreferencesMock extends Mock implements SharedPreferences {}
