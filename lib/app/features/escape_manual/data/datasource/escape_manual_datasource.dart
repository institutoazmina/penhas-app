import '../../../appstate/data/model/quiz_session_model.dart';
import '../model/escape_manual_remote.dart';

abstract class IEscapeManualDatasource {}

abstract class IEscapeManualRemoteDatasource extends IEscapeManualDatasource {
  Future<QuizSessionModel> start(String sessionId);
  Future<EscapeManualRemoteModel> fetch();
}
