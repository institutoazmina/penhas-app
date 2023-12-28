import '../../../appstate/data/model/quiz_session_model.dart';
import '../model/escape_manual_remote.dart';
import '../model/escape_manual_task.dart';

abstract class IEscapeManualDatasource {}

abstract class IEscapeManualRemoteDatasource extends IEscapeManualDatasource {
  Future<QuizSessionModel> start(String sessionId);
  Future<EscapeManualRemoteModel> fetch();
}

abstract class IEscapeManualLocalDatasource extends IEscapeManualDatasource {
  /// Retrieves the tasks not synced with the server from the local database
  Stream<Iterable<EscapeManualTaskModel>> fetchTasks();

  /// Saves the task to the local database to be synced with the server later
  Future<void> saveTask(EscapeManualTaskModel task);

  /// Delete the task logically from the local database
  Future<void> removeTask(EscapeManualTaskModel task);

  /// Removes all tasks before the given date from the local database
  /// This is used to clear the local database after the tasks have been synced with the server
  Future<void> clearBefore(DateTime date);
}
