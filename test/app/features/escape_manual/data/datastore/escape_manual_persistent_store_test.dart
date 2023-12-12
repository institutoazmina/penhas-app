import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/storage/collection_store.dart';
import 'package:penhas/app/core/storage/persistent_storage.dart';
import 'package:penhas/app/features/escape_manual/data/datastore/escape_manual_persistent_store.dart';
import 'package:penhas/app/features/escape_manual/data/model/escape_manual_local.dart';

void main() {
  group(EscapeManualTasksStore, () {
    late ICollectionStore<EscapeManualTaskLocalModel> sut;

    late IPersistentStorageFactory mockStorageFactory;
    late IPersistentStorage mockStorage;

    setUp(() {
      mockStorageFactory = _MockPersistentStorageFactory();
      mockStorage = _MockPersistentStorage();

      sut = EscapeManualTasksStore(storageFactory: mockStorageFactory);

      when(() => mockStorageFactory.create(any())).thenReturn(mockStorage);
    });

    test(
      'should call factory with correct name',
      () async {
        // arrange
        when(() => mockStorage.all<String>()).thenAnswer((_) async => []);

        // act
        await sut.all();

        // assert
        verify(() => mockStorageFactory.create('escape_manual_tasks'))
            .called(1);
      },
    );

    test(
      'all should return deserialized values',
      () async {
        // arrange
        when(() => mockStorage.all<String>()).thenAnswer(
          (_) async => [
            '{"id":"id 0","type":"checkbox","isDone":false,"isRemoved":true,"updatedAt":"2023-11-06T18:29:33.000"}',
            '{"id":"id 1","type":"checkbox_contato","isDone":true,"isRemoved":false,"updatedAt":"2023-11-06T18:34:24.000"}',
          ],
        );

        // act
        final result = await sut.all();

        // assert
        expect(
          result,
          [
            EscapeManualTaskLocalModel(
              id: 'id 0',
              isDone: false,
              isRemoved: true,
              updatedAt: DateTime(2023, 11, 06, 18, 29, 33),
            ),
            EscapeManualTaskLocalModel(
              id: 'id 1',
              type: EscapeManualTaskType.contacts,
              isDone: true,
              isRemoved: false,
              updatedAt: DateTime(2023, 11, 06, 18, 34, 24),
            ),
          ],
        );
        verify(() => mockStorage.all<String>()).called(1);
      },
    );

    test(
      'watchAll emits deserialized values',
      () async {
        // arrange
        when(() => mockStorage.watchAll<String>()).thenAnswer(
          (_) => Stream.fromIterable([
            [
              '{"id":"id 0","type":"checkbox_contato","isDone":false,"isRemoved":true,"updatedAt":"2023-11-06T18:47:08.000"}',
              '{"id":"id 1","type":"checkbox","isDone":true,"isRemoved":false,"updatedAt":"2023-11-06T18:48:10.000"}',
            ],
          ]),
        );

        // act / assert
        expectLater(
          sut.watchAll(),
          emits([
            EscapeManualTaskLocalModel(
              id: 'id 0',
              type: EscapeManualTaskType.contacts,
              isDone: false,
              isRemoved: true,
              updatedAt: DateTime(2023, 11, 06, 18, 47, 08),
            ),
            EscapeManualTaskLocalModel(
              id: 'id 1',
              isDone: true,
              isRemoved: false,
              updatedAt: DateTime(2023, 11, 06, 18, 48, 10),
            ),
          ]),
        );
        verify(() => mockStorage.watchAll<String>()).called(1);
      },
    );

    test(
      'put should store serialized value',
      () async {
        // arrange
        final taskId = 'some id key';
        when(() => mockStorage.put(any(), any<String>()))
            .thenAnswer((_) => Future.value());
        final expected = {
          "id": "some id key",
          "type": "checkbox",
          "isDone": false,
          "isRemoved": false,
          "updatedAt": "2023-11-06T18:29:33.000",
        };

        // act
        await sut.put(
          taskId,
          EscapeManualTaskLocalModel(
            id: taskId,
            isDone: false,
            isRemoved: false,
            updatedAt: DateTime(2023, 11, 06, 18, 29, 33),
          ),
        );

        // assert
        final verifier =
            verify(() => mockStorage.put(taskId, captureAny<String>()));
        verifier.called(1);
        expect(jsonDecode(verifier.captured.single), expected);
      },
    );

    test(
      'removeAll should call storage.removeAll',
      () async {
        // arrange
        final keys = ['first key', 'second key', 'third key'];
        when(() => mockStorage.removeAll(any())).thenAnswer(
          (_) => Future.value(),
        );

        // act
        await sut.removeAll(keys);

        // assert
        verify(() => mockStorage.removeAll(keys)).called(1);
      },
    );
  });
}

class _MockPersistentStorageFactory extends Mock
    implements IPersistentStorageFactory {}

class _MockPersistentStorage extends Mock implements IPersistentStorage {}
