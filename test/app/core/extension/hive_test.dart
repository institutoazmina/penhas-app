import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/extension/hive.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';

void main() {
  group('HiveExt', () {
    late HiveInterface sut;

    setUp(() {
      sut = _MockHive();
    });

    test(
      'safeRegisterAdapter should register type adapter if it is not registered',
      () {
        // arrange
        final adapter = _FakeTypeAdapter();
        when(() => sut.isAdapterRegistered(adapter.typeId)).thenReturn(false);

        // act
        sut.safeRegisterAdapter(adapter);

        // assert
        verify(() => sut.registerAdapter(adapter)).called(1);
      },
    );

    test(
      'safeRegisterAdapter should not register type adapter if it is registered',
      () {
        // arrange
        final adapter = _FakeTypeAdapter();
        when(() => sut.isAdapterRegistered(adapter.typeId)).thenReturn(true);

        // act
        sut.safeRegisterAdapter(adapter);

        // assert
        verifyNever(() => sut.registerAdapter(adapter));
      },
    );

    test(
      'openSecureBox should open box with encryption key from storage',
      () async {
        // arrange
        final encryptionKeyBase64 =
            'Hki-NPifsJbbCGou0I9Z8VNyo3RKlFwP_LHnWBAu1NY=';
        final boxName = 'box_name';
        final encryptionKeyStorage = _MockLocalStorage();
        final box = _FakeBox();
        when(() => encryptionKeyStorage.get(hiveKey))
            .thenAnswer((_) async => encryptionKeyBase64);
        when(
          () => sut.openBox(
            any(),
            encryptionCipher: any(named: 'encryptionCipher'),
          ),
        ).thenAnswer((_) async => box);

        // act
        final result = await sut.openSecureBox(
          boxName,
          encryptionKeyStorage: encryptionKeyStorage,
        );

        // assert
        verify(() => encryptionKeyStorage.get(hiveKey)).called(1);
        verify(
          () => sut.openBox(
            boxName,
            encryptionCipher: any(named: 'encryptionCipher'),
          ),
        ).called(1);
        expect(result, box);
      },
    );

    test(
      'openSecureBox should create encryption key and open box with it if storage is empty',
      () async {
        // arrange
        final boxName = 'box_name';
        final encryptionKeyStorage = _MockLocalStorage();
        final box = _FakeBox();
        when(() => encryptionKeyStorage.get(hiveKey))
            .thenAnswer((_) async => null);
        when(() => sut.generateSecureKey()).thenReturn(
          Uint8List.fromList(List.generate(32, (index) => index + 1)),
        );
        when(() => encryptionKeyStorage.put(hiveKey, any()))
            .thenAnswer((_) => Future.value());
        when(
          () => sut.openBox(
            any(),
            encryptionCipher: any(named: 'encryptionCipher'),
          ),
        ).thenAnswer((_) async => box);

        // act
        final result = await sut.openSecureBox(
          boxName,
          encryptionKeyStorage: encryptionKeyStorage,
        );

        // assert
        verify(() => encryptionKeyStorage.get(hiveKey)).called(1);
        verify(
          () => encryptionKeyStorage.put(
            hiveKey,
            'AQIDBAUGBwgJCgsMDQ4PEBESExQVFhcYGRobHB0eHyA=',
          ),
        ).called(1);
        verify(
          () => sut.openBox(
            boxName,
            encryptionCipher: any(named: 'encryptionCipher'),
          ),
        ).called(1);
        expect(result, box);
      },
    );
  });
}

class _MockLocalStorage extends Mock implements ILocalStorage {}

class _MockHive extends Mock implements HiveInterface {}

class _FakeBox<T> extends Fake implements Box<T> {}

class _FakeTypeAdapter<T> extends Fake implements TypeAdapter<T> {
  @override
  int get typeId => 42;
}
