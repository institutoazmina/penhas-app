import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/core/storage/impl/hive_persistent_storage.dart';
import 'package:penhas/app/core/storage/persistent_storage.dart';

void main() {
  group(HivePersistentStorage, () {
    late IPersistentStorage sut;
    late IPersistentStorageFactory factory;

    late ILocalStorage mockLocalStorage;
    late Box mockBox;
    late HiveInterface mockHive;

    setUp(() {
      mockLocalStorage = _MockLocalStorage();
      mockBox = _MockBox();
      mockHive = _MockHive();

      factory = HivePersistentStorageFactory(
        encryptionKeyStorage: mockLocalStorage,
        hive: mockHive,
      );

      when(() => mockLocalStorage.get(any())).thenAnswer(
        (_) async => 'Hki-NPifsJbbCGou0I9Z8VNyo3RKlFwP_LHnWBAu1NY=',
      );

      when(
        () => mockHive.openBox(
          any(),
          path: any(named: 'path'),
          encryptionCipher: any(named: 'encryptionCipher'),
        ),
      ).thenAnswer((_) async => mockBox);

      sut = factory.create('test');
    });

    test(
      'all should return values',
      () async {
        // arrange
        when(() => mockBox.values).thenReturn(['test']);

        // act
        final result = await sut.all<String>();

        // assert
        expect(result, ['test']);
      },
    );

    test(
      'watchAll should return values',
      () async {
        // arrange
        final events = [
          ['zero'],
          ['zero', 'one'],
        ];
        when(() => mockBox.watch()).thenAnswer(
          (_) => Stream.fromIterable([
            BoxEvent('0', 'zero', false),
            BoxEvent('1', 'one', false),
          ]),
        );
        when(() => mockBox.values).thenAnswer((_) => events.removeAt(0));

        // act / assert
        expectLater(
          sut.watchAll<String>(),
          emitsInOrder([
            ['zero'],
            ['zero', 'one'],
          ]),
        );
      },
    );

    test(
      'get should call box.get',
      () async {
        // arrange
        final key = 'persistent key';
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
        final key = 'new persistent key';
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

class _MockHive extends Mock implements HiveInterface {}
