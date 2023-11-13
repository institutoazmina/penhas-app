import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/storage/collection_store.dart';
import 'package:penhas/app/features/escape_manual/data/datasource/impl/escape_manual_local_datasource.dart';
import 'package:penhas/app/features/escape_manual/data/model/escape_manual_local.dart';

void main() {
  late IEscapeManualLocalDatasource sut;
  late ICollectionStore<EscapeManualTaskLocalModel> mockStore;

  setUpAll(() {
    registerFallbackValue(_FakeEscapeManualTaskLocalModel());
  });

  setUp(() {
    mockStore = _MockEscapeManualTaskStore();
    sut = EscapeManualLocalDatasource(store: mockStore);
  });

  group(EscapeManualLocalDatasource, () {
    test('should call store watchAll', () {
      // arrange
      final tasks = [
        EscapeManualTaskLocalModel(id: '1'),
        EscapeManualTaskLocalModel(id: '2'),
      ];
      when(() => mockStore.watchAll()).thenAnswer(
        (_) => Stream.fromIterable([tasks]),
      );

      // act / assert
      expectLater(sut.fetchTasks(), emits(tasks));
      verify(() => mockStore.watchAll()).called(1);
    });

    test('should call store put', () async {
      // arrange
      final task = EscapeManualTaskLocalModel(
        id: 'id',
        updatedAt: DateTime.now(),
        isDone: Random().nextBool(),
        isRemoved: Random().nextBool(),
      );
      when(() => mockStore.put(any(), any())).thenAnswer((_) => Future.value());

      // act
      await sut.saveTask(task);

      // assert
      verify(() => mockStore.put(task.id, task)).called(1);
    });

    test('should call store put with isRemoved true', () async {
      // arrange
      final task = EscapeManualTaskLocalModel(
        id: 'id',
        updatedAt: DateTime.now(),
      );
      when(() => mockStore.put(any(), any())).thenAnswer((_) => Future.value());

      // act
      await sut.removeTask(task);

      // assert
      verify(() => mockStore.put(task.id, task.copyWith(isRemoved: true)))
          .called(1);
    });

    test('should call store removeAll', () async {
      // arrange
      final tasks = [
        EscapeManualTaskLocalModel(
          id: '0',
          updatedAt: DateTime(2023, 11, 13, 12, 0, 0),
        ),
        EscapeManualTaskLocalModel(
          id: '1',
          updatedAt: DateTime(2023, 11, 13, 13, 57, 59),
        ),
        EscapeManualTaskLocalModel(
          id: '2',
          updatedAt: DateTime(2023, 11, 13, 13, 58, 0),
        ),
        EscapeManualTaskLocalModel(id: '3'),
        EscapeManualTaskLocalModel(id: '4'),
      ];

      when(() => mockStore.all()).thenAnswer((_) async => tasks);
      when(() => mockStore.removeAll(any())).thenAnswer((_) => Future.value());

      // act
      await sut.clearBefore(DateTime(2023, 11, 13, 13, 58, 0));

      // assert
      verify(() => mockStore.removeAll(['0', '1'])).called(1);
    });
  });
}

class _MockEscapeManualTaskStore extends Mock
    implements ICollectionStore<EscapeManualTaskLocalModel> {}

class _FakeEscapeManualTaskLocalModel extends Fake
    implements EscapeManualTaskLocalModel {}
