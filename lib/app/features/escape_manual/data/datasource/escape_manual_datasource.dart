import '../../../appstate/data/model/quiz_session_model.dart';
import '../model/escape_manual.dart';
import '../model/escape_manual_remote.dart';

abstract class IEscapeManualRemoteDatasource {
  Future<QuizSessionModel> start(String sessionId);
  Future<EscapeManualRemoteModel> fetch({int lastChangeAt = 0});
}

abstract class IEscapeManualLocalDatasource {
  Future<int> lastChangeAt();
  Future<Iterable<EscapeManualTaskModel>> fetchTasks();
  Future<void> saveTask(EscapeManualTaskModel escapeManual);
  Future<void> saveAllTasks(Iterable<EscapeManualTaskModel> items);
  Future<void> removeTask(EscapeManualTaskModel task);
}
