import '../../../appstate/data/model/quiz_session_model.dart';
import '../model/escape_manual_remote.dart';
import '../model/escape_manual_task.dart';

abstract class IEscapeManualDatasource {
  /// Saves the task
  Future<EscapeManualTaskModel> saveTask(EscapeManualTaskModel task);

  /// Update remote escape manual tasks in batch
  /// Returns the updated tasks
  Future<List<EscapeManualTaskModel>> saveTasks(
    List<EscapeManualTaskModel> tasks,
  );
}

abstract class IEscapeManualRemoteDatasource extends IEscapeManualDatasource {
  /// Starts a new escape manual session
  Future<QuizSessionModel> start(String sessionId);

  /// Fetch remote escape manual data
  Future<EscapeManualRemoteModel> fetch();
}

abstract class IEscapeManualLocalDatasource extends IEscapeManualDatasource {
  /// Retrieves the tasks not synced with the server from the local database
  Future<Iterable<EscapeManualTaskModel>> getTasks();

  /// Retrieves the tasks not synced with the server from the local database
  /// and emits new data every time the local data changes
  Stream<Iterable<EscapeManualTaskModel>> fetchTasks();

  /// Removes all tasks before the given date from the local database
  /// and all tasks that are not in the given list
  /// This is used to clear the local database after the tasks have been synced with the server
  Future<void> removeWhere({
    required DateTime isBefore,
    required List<String> orIdNotIn,
  });
}
