import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';

class AppStateModel extends AppStateEntity {
  final QuizSessionEntity quizSession;

  AppStateModel(this.quizSession) : super(quizSession: quizSession);

  factory AppStateModel.fromJson(Map<String, Object> jsonData) {
    final quizSession = _parseQuizSession(jsonData['quiz_session']);
    return AppStateModel(quizSession);
  }

  static QuizSessionEntity _parseQuizSession(Map<String, Object> session) {
    final foo = session["current_msgs"];
    final currentMessage = _parseQuizMessage(foo);
    final previousMessage = _parseQuizMessage(session['prev_msgs']);
    final int sessionId = (session['session_id'] as num).toInt();
    return QuizSessionEntity(
      currentMessage: currentMessage,
      previousMessage: previousMessage,
      sessionId: sessionId,
    );
  }

  static List<QuizMessageEntity> _parseQuizMessage(List<Object> data) {
    if (data == null || data.isEmpty) {
      return null;
    }

    return data
        .map((e) => e as Map<String, Object>)
        .map((e) => QuizMessageEntity(
              content: e['content'],
              type: QuizMessageType.from[e['type']],
              action: e['action'],
              ref: e['ref'],
              style: e['style'],
            ))
        .toList();
  }
}
