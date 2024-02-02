import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/background_task_manager.dart';
import 'package:penhas/app/core/managers/impl/background_task_manager.dart';
import 'package:workmanager/workmanager.dart';

import '../../../../utils/aditional_bind_module.dart';
import '../../../../utils/test_utils.dart';

typedef BackgroundTaskHandler = Future<bool> Function(
    String taskName, Map<String, dynamic>? inputData);

void main() {
  group(BackgroundTaskManager, () {
    late IBackgroundTaskManager sut;

    late IBackgroundTaskRegistry mockRegistry;
    late Workmanager mockWorkManager;
    BackgroundTaskHandler? taskHandler;

    setUp(() {
      mockRegistry = _MockBackgroundTaskRegistry();
      mockWorkManager = _MockWorkManager();

      sut = BackgroundTaskManager(
        workManager: mockWorkManager,
      );

      when(() => mockWorkManager.executeTask(any())).thenAnswer(
        (invocation) async {
          taskHandler =
              invocation.positionalArguments.first as BackgroundTaskHandler;
        },
      );
    });

    tearDown(() {
      taskHandler = null;
    });

    test('registerDispatcher should initialize workManager', () {
      // arrange
      final mockDispatcher = () {};
      when(
        () => mockWorkManager.initialize(
          any(),
          isInDebugMode: any(named: 'isInDebugMode'),
        ),
      ).thenAnswer((_) => Future.value());

      // act
      sut.registerDispatcher(mockDispatcher);

      // assert
      verify(
        () => mockWorkManager.initialize(
          mockDispatcher,
          isInDebugMode: any(named: 'isInDebugMode'),
        ),
      ).called(1);
    });

    test(
      'schedule should schedule task',
      () async {
        // arrange
        const taskName = 'taskName';
        when(
          () => mockWorkManager.registerOneOffTask(
            any(),
            any(),
            existingWorkPolicy: any(named: 'existingWorkPolicy'),
            constraints: any(named: 'constraints'),
          ),
        ).thenAnswer((_) => Future.value());

        // act
        sut.schedule(taskName);

        // assert
        final verification = verify(
          () => mockWorkManager.registerOneOffTask(
            taskName,
            taskName,
            existingWorkPolicy: ExistingWorkPolicy.replace,
            constraints: captureAny(named: 'constraints'),
          ),
        )..called(1);
        final constraints = verification.captured.first as Constraints;
        expect(constraints.networkType, NetworkType.connected);
      },
    );

    test(
      'runPendingTasks should run pending tasks',
      () async {
        // arrange
        const taskName = 'taskName';
        final task = _MockBackgroundTask();
        final module = AditionalBindModule(
          binds: [
            Bind<BackgroundTask>((i) => task),
          ],
        );
        final taskDefinition = TaskDefinition(
          taskProvider: () => Modular.get<BackgroundTask>(),
          dependencies: [module],
        );
        sut = BackgroundTaskManager(
          registry: mockRegistry,
          workManager: mockWorkManager,
        );
        when(() => task.execute()).thenAnswer((_) async => true);
        when(() => mockRegistry.definitionByName(taskName))
            .thenReturn(taskDefinition);

        // act
        sut.runPendingTasks();
        final actual = await taskHandler?.call(taskName, null);

        // assert
        verify(() => mockRegistry.definitionByName(taskName)).called(1);
        verify(() => task.execute()).called(1);
        expect(actual, isTrue);
      },
    );

    test(
      'task handler should return false when task throws an exception',
      () async {
        // arrange
        final taskName = 'UnimplementedTask';

        // act
        sut.runPendingTasks();
        final actual = await taskHandler?.call(taskName, null);

        // assert
        expect(actual, isFalse);
      },
    );
  });

  group(BackgroundTaskRegistry, () {
    late IBackgroundTaskRegistry sut;

    setUp(() {
      sut = BackgroundTaskRegistry();
    });

    parameterizedGroup<List<Bind>>(
      'definitionByName should return task definition for task',
      () => {},
      (name, item) {
        test(
          name,
          () {
            // arrange
            final taskName = name;
            Modular.init(AditionalBindModule(binds: item));

            // act
            final actual = sut.definitionByName(taskName);
            actual.dependencies.forEach((element) {
              Modular.bindModule(element);
            });

            // assert
            expect(actual.taskProvider(), isNotNull);
          },
        );
      },
    );
  });
}

class _MockBackgroundTaskRegistry extends Mock
    implements IBackgroundTaskRegistry {}

class _MockWorkManager extends Mock implements Workmanager {}

class _MockBackgroundTask extends Mock implements BackgroundTask {}
