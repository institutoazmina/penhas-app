import '../../../appstate/data/model/quiz_session_model.dart';
import '../model/escape_manual_remote.dart';
import '../model/escape_manual_task.dart';

abstract class IEscapeManualDatasource {
  /// Saves the task
  Future<EscapeManualTaskModel> saveTask(EscapeManualTaskModel task);
}

abstract class IEscapeManualRemoteDatasource extends IEscapeManualDatasource {
  /// Starts a new escape manual session
  Future<QuizSessionModel> start(String sessionId);

  /// Fetch remote escape manual data
  Future<EscapeManualRemoteModel> fetch();
}

abstract class IEscapeManualLocalDatasource extends IEscapeManualDatasource {
  /// Retrieves the tasks not synced with the server from the local database
  /// and emits new data every time the local data changes
  Stream<Iterable<EscapeManualTaskModel>> fetchTasks();

  /// Removes all tasks before the given date from the local database
  /// This is used to clear the local database after the tasks have been synced with the server
  Future<void> clearBefore(DateTime date);
}
