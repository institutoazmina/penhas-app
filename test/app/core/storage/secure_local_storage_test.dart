import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/core/storage/secure_local_storage.dart';

void main() {
  group('SecureLocalStorageTest', () {
    late FlutterSecureStorage storage;
    late ILocalStorage secureLocalStorage;

    setUp(() {
      storage = FlutterSecureStorageMock();
      secureLocalStorage = SecureLocalStorage(storage: storage);
    });

    test(
      '`put` should call `storage.write`',
      () async {
        // arrange
        const key = 'this key will be created';
        const value = 'with this value';

        when(
          () => storage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async {});

        // act
        await secureLocalStorage.put(key, value);

        // arrange
        verify(() => storage.write(key: key, value: value)).called(1);
      },
    );

    test(
      '`hasKey` should return `storage.containsKey` value',
      () async {
        // arrange
        const key = 'just a key';
        final expectedHasKey = Random().nextBool();

        when(() => storage.containsKey(key: key))
            .thenAnswer((_) async => expectedHasKey);

        // act
        final actualHasKey = await secureLocalStorage.hasKey(key);

        // arrange
        expect(actualHasKey, expectedHasKey);
        verify(() => storage.containsKey(key: key)).called(1);
      },
    );

    test(
      'when value is cached `hasKey` should not call `storage.containsKey`',
      () async {
        // arrange
        const key = 'another key';
        const value = 'just a value';

        when(() => storage.containsKey(key: key))
            .thenAnswer((_) async => false);
        when(() => storage.write(key: key, value: any(named: 'value')))
            .thenAnswer((_) async {});

        await secureLocalStorage.put(key, value);

        // act
        final actualHasKey = await secureLocalStorage.hasKey(key);

        // arrange
        expect(actualHasKey, true);
        verifyNever(() => storage.containsKey(key: key));
      },
    );

    test(
      '`get` should return `storage.read` value',
      () async {
        // arrange
        const key = 'it is a key';
        const expectedValue = 'a expected value';

        when(() => storage.read(key: key))
            .thenAnswer((_) async => expectedValue);

        // act
        final actualValue = await secureLocalStorage.get(key);

        // assert
        expect(actualValue, expectedValue);
        verify(() => storage.read(key: key)).called(1);
      },
    );

    test(
      'when value is cached `get` should not call `storage.read`',
      () async {
        // arrange
        const key = 'is it a piano key?';
        const expectedValue = 'valeu';

        when(() => storage.write(key: key, value: any(named: 'value')))
            .thenAnswer((_) async {});

        await secureLocalStorage.put(key, expectedValue);

        // act
        final actualValue = await secureLocalStorage.get(key);

        // assert
        expect(actualValue, expectedValue);
        verifyNever(() => storage.read(key: key));
      },
    );

    test(
      '`delete` should call `storage.delete`',
      () async {
        // arrange
        const key = 'bye bye key';

        when(() => storage.delete(key: key)).thenAnswer((_) async {});

        // act
        await secureLocalStorage.delete(key);

        // assert
        verify(() => storage.delete(key: key)).called(1);
      },
    );

    test(
      'when delete key `hasKey` should call `storage.containsKey`',
      () async {
        // arrange
        const key = 'this key is really removed?';
        const value = 'any value';
        final expectedHasKey = Random().nextBool();

        when(() => storage.delete(key: key)).thenAnswer((_) async {});
        when(() => storage.containsKey(key: key))
            .thenAnswer((_) async => expectedHasKey);
        when(() => storage.write(key: key, value: value))
            .thenAnswer((_) async {});

        await secureLocalStorage.put(key, value);
        await secureLocalStorage.delete(key);

        // act
        final actualHasKey = await secureLocalStorage.hasKey(key);

        // assert
        expect(actualHasKey, expectedHasKey);
        verify(() => storage.containsKey(key: key)).called(1);
      },
    );
  });
}

class FlutterSecureStorageMock extends Mock implements FlutterSecureStorage {}
