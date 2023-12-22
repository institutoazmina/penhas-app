import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/storage/collection_store.dart';
import 'package:penhas/app/features/escape_manual/data/datasource/impl/escape_manual_local_datasource.dart';
import 'package:penhas/app/features/escape_manual/data/model/escape_manual_local.dart';
import 'package:penhas/app/features/escape_manual/data/model/escape_manual_task.dart';

void main() {
  late IEscapeManualLocalDatasource sut;
  late ICollectionStore<EscapeManualTaskModel> mockStore;

  setUpAll(() {
    registerFallbackValue(_FakeEscapeManualTaskLocalModel());
  });

  setUp(() {
    mockStore = _MockEscapeManualTaskStore();
    sut = EscapeManualLocalDatasource(store: mockStore);
  });

  group(EscapeManualLocalDatasource, () {
    test('getTasks should call store all', () async {
      // arrange
      final tasks = [
        EscapeManualTaskLocalModel(id: '1'),
        EscapeManualTaskLocalModel(id: '2'),
      ];
      when(() => mockStore.all()).thenAnswer((_) async => tasks);

      // act
      final actual = await sut.getTasks();

      // assert
      verify(() => mockStore.all()).called(1);
      expect(actual, tasks);
    });

    test('watchAll should call store watchAll', () {
      // arrange
      final tasks = [
        EscapeManualTaskLocalModel(id: '1'),
        EscapeManualTaskLocalModel(
          id: '2',
          type: EscapeManualTaskType.contacts,
        ),
      ];
      when(() => mockStore.watchAll()).thenAnswer(
        (_) => Stream.fromIterable([tasks]),
      );

      // act / assert
      expectLater(sut.fetchTasks(), emits(tasks));
      verify(() => mockStore.watchAll()).called(1);
    });

    test('saveTask should call store put', () async {
      // arrange
      final task = EscapeManualTaskLocalModel(
        id: 'id',
        type: EscapeManualTaskType.contacts,
        updatedAt: DateTime.now(),
        isDone: Random().nextBool(),
        isRemoved: Random().nextBool(),
      );
      when(() => mockStore.put(any(), any())).thenAnswer((_) => Future.value());

      // act
      final actual = await sut.saveTask(task);

      // assert
      verify(() => mockStore.put(task.id, task)).called(1);
      expect(actual, task);
    });

    test('saveTasks should call store putAll', () async {
      // arrange
      final tasks = [
        EscapeManualTaskLocalModel(id: '0'),
        EscapeManualTaskLocalModel(
          id: '1',
          type: EscapeManualTaskType.contacts,
          updatedAt: DateTime(2023, 11, 13, 13, 57, 59),
        ),
      ];
      when(() => mockStore.putAll(any())).thenAnswer((_) => Future.value());

      // act
      final actual = await sut.saveTasks(tasks);

      // assert
      verify(
        () => mockStore.putAll({'0': tasks[0], '1': tasks[1]}),
      ).called(1);
      expect(actual, tasks);
    });

    test('clearBefore should call store removeAll', () async {
      // arrange
      final tasks = [
        EscapeManualTaskLocalModel(
          id: '0',
          updatedAt: DateTime(2023, 11, 13, 12, 0, 0),
        ),
        EscapeManualTaskLocalModel(
          id: '1',
          type: EscapeManualTaskType.contacts,
          updatedAt: DateTime(2023, 11, 13, 13, 57, 59),
        ),
        EscapeManualTaskLocalModel(
          id: '2',
          updatedAt: DateTime(2023, 11, 13, 13, 58, 0),
        ),
        EscapeManualTaskLocalModel(
          id: '3',
          type: EscapeManualTaskType.contacts,
        ),
        EscapeManualTaskLocalModel(id: '4'),
      ];

      when(() => mockStore.all()).thenAnswer((_) async => tasks);
      when(() => mockStore.removeAll(any())).thenAnswer((_) => Future.value());

      // act
      await sut.removeWhere(
        isBefore: DateTime(2023, 11, 13, 13, 58, 0),
        orIdNotIn: tasks.map((e) => e.id).toList(),
      );

      // assert
      verify(() => mockStore.removeAll(['0', '1'])).called(1);
    });
  });
}

class _MockEscapeManualTaskStore extends Mock
    implements ICollectionStore<EscapeManualTaskModel> {}

class _FakeEscapeManualTaskLocalModel extends Fake
    implements EscapeManualTaskLocalModel {}
