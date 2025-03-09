import 'dart:async';

typedef BackgroundTaskProvider = BackgroundTask Function();

/// The background task manager is used to schedule and run tasks in background.
abstract class IBackgroundTaskManager {
  const IBackgroundTaskManager();

  void registerDispatcher(Function callbackDispatcher);

  void schedule(String taskName);

  void runPendingTasks();
}

/// Represents a task that can be executed in background.
abstract class BackgroundTask {
  /// Executes the task and returns true if the task was executed successfully.
  /// Otherwise, returns false.
  FutureOr<bool> execute();
}

abstract class IBackgroundTaskRegistry {
  const IBackgroundTaskRegistry();

  TaskDefinition definitionByName(String taskName);
}

/// The task definition is used to register a new task.
class TaskDefinition {
  const TaskDefinition({
    required this.taskProvider,
  });

  /// The task provider is used to create a new instance of the task.
  final BackgroundTaskProvider taskProvider;
}
