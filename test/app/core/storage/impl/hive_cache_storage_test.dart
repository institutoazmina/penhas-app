import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/storage/cache_storage.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/core/storage/impl/hive_cache_storage.dart';

void main() {
  group(HiveCacheStorage, () {
    late ICacheStorage sut;

    late ILocalStorage mockLocalStorage;
    late Box mockBox;

    setUp(() {
      mockLocalStorage = _MockLocalStorage();
      mockBox = _MockBox();

      sut = HiveCacheStorage(
        encryptionKeyStorage: mockLocalStorage,
        box: mockBox,
      );
    });

    test(
      'get should call box.get',
      () async {
        // arrange
        final key = 'cache key';
        final savedValue = 'saved value';
        when(() => mockBox.get(any())).thenAnswer((_) async => savedValue);

        // act
        final actual = await sut.getString(key);

        // assert
        verify(() => mockBox.get(key)).called(1);
        expect(actual, equals(savedValue));
      },
    );

    test(
      'put should call box.put',
      () async {
        // arrange
        final key = 'new cache key';
        final newValue = 'value to save';
        when(() => mockBox.put(any(), any())).thenAnswer((_) => Future.value());

        // act
        await sut.putString(key, newValue);

        // assert
        verify(() => mockBox.put(key, newValue)).called(1);
      },
    );

    test(
      'remove should call box.delete',
      () async {
        // arrange
        final key = 'key to remove';
        when(() => mockBox.delete(any())).thenAnswer((_) => Future.value());

        // act
        await sut.remove(key);

        // assert
        verify(() => mockBox.delete(key)).called(1);
      },
    );

    test(
      'removeAll should call box.deleteAll',
      () async {
        // arrange
        final keys = ['first key', 'second key', 'third key'];
        when(() => mockBox.deleteAll(any())).thenAnswer((_) => Future.value());

        // act
        await sut.removeAll(keys);

        // assert
        verify(() => mockBox.deleteAll(keys)).called(1);
      },
    );

    test(
      'clear should call box.clear',
      () async {
        // arrange
        when(() => mockBox.clear()).thenAnswer((_) => Future.value(0));

        // act
        await sut.clear();

        // assert
        verify(() => mockBox.clear()).called(1);
      },
    );
  });
}

class _MockLocalStorage extends Mock implements ILocalStorage {}

class _MockBox extends Mock implements Box {}
