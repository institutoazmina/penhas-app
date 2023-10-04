import '../../../appstate/data/model/quiz_session_model.dart';
import '../model/escape_manual.dart';

abstract class IEscapeManualDatasource {
  Future<QuizSessionModel> start(String sessionId);
  Future<EscapeManualRemoteModel> fetch();
}
