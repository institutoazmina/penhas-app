import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/storage/hive_local_storage.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';

void main() {
  late ILocalStorage sut;

  late FlutterSecureStorage mockStorage;
  late LazyBox<String> mockBox;

  setUp(() {
    mockStorage = _MockFlutterSecureStorage();
    mockBox = _MockLazyBox();

    sut = HiveLocalStorage(
      storage: mockStorage,
      box: mockBox,
    );
  });

  group(HiveLocalStorage, () {
    test(
      'hasKey should call containsKey',
      () async {
        // arrange
        const key = 'key';
        when(() => mockBox.containsKey(key)).thenReturn(true);

        // act
        await sut.hasKey(key);

        // assert
        verify(() => mockBox.containsKey(key)).called(1);
      },
    );

    test(
      'get should return box.get value',
      () async {
        // arrange
        const key = 'key';
        const expectedValue = 'value';
        when(() => mockBox.get(any())).thenAnswer((_) async => expectedValue);

        // act
        final value = await sut.get(key);

        // assert
        verify(() => mockBox.get(key)).called(1);
        expect(value, expectedValue);
      },
    );

    test(
      'put should call box.put value',
      () async {
        // arrange
        const key = 'key';
        const value = 'value';

        when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

        // act
        await sut.put(key, value);

        // assert
        verify(() => mockBox.put(key, value)).called(1);
      },
    );

    test(
      'put should call box.delete when value is null',
      () async {
        // arrange
        const key = 'key';

        when(() => mockBox.delete(any())).thenAnswer((_) async {});

        // act
        await sut.put(key, null);

        // assert
        verify(() => mockBox.delete(key)).called(1);
      },
    );

    test(
      'delete should call box.delete',
      () async {
        // arrange
        const key = 'key';

        when(() => mockBox.delete(any())).thenAnswer((_) async {});

        // act
        await sut.delete(key);

        // assert
        verify(() => mockBox.delete(key)).called(1);
      },
    );
  });
}

class _MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

class _MockLazyBox extends Mock implements LazyBox<String> {}
