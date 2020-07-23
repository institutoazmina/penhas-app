import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';

class AppStateModel extends AppStateEntity {
  final QuizSessionEntity quizSession;
  final UserProfileEntity userProfile;

  AppStateModel(this.quizSession, this.userProfile)
      : super(quizSession: quizSession, userProfile: userProfile);

  factory AppStateModel.fromJson(Map<String, Object> jsonData) {
    final quizSession = _parseQuizSession(jsonData['quiz_session']);
    final userProfile = _parseUserProfile(jsonData['user_profile']);
    return AppStateModel(quizSession, userProfile);
  }

  static QuizSessionEntity _parseQuizSession(Map<String, Object> session) {
    final currentMessage = _parseQuizMessage(session["current_msgs"]);
    final previousMessage = _parseQuizMessage(session['prev_msgs']);
    final isFinished = (session['finished'] != null && session['finished'] == 1)
        ? true
        : false;

    if (previousMessage != null) {
      currentMessage.insertAll(0, previousMessage);
    }

    final int sessionId = (session['session_id'] as num)?.toInt();
    return QuizSessionEntity(
        currentMessage: currentMessage,
        sessionId: sessionId,
        isFinished: isFinished,
        endScreen: session['end_screen']);
  }

  static List<QuizMessageEntity> _parseQuizMessage(List<Object> data) {
    if (data == null || data.isEmpty) {
      return null;
    }

    return data
        .map((e) => e as Map<String, Object>)
        .expand((e) => _buildMessage(e))
        .toList();
  }

  static List<QuizMessageEntity> _buildMessage(Map<String, Object> message) {
    if (message['display_response'] != null) {
      return _buildDisplayResponseMessage(message);
    }

    return [
      QuizMessageEntity(
        content: message['content'],
        ref: message['ref'],
        style: message['style'],
        action: message['action'],
        buttonLabel: message['label'],
        type: _mapMessageType(message),
        options: _mapToOptions(message['options']),
      )
    ];
  }

  static QuizMessageType _mapMessageType(Map<String, Object> message) {
    QuizMessageType type = QuizMessageType.from[message['type']];
    if (message['action'] == 'botao_tela_modo_camuflado') {
      type = QuizMessageType.showTutorial;
    }

    return type;
  }

  static List<QuizMessageEntity> _buildDisplayResponseMessage(
      Map<String, Object> message) {
    return [
      QuizMessageEntity(
        content: message['content'],
        type: QuizMessageType.displayText,
        style: "normal",
      ),
      QuizMessageEntity(
        content: message['display_response'],
        type: QuizMessageType.displayTextResponse,
        style: "normal",
      )
    ];
  }

  static List<QuizMessageMultiplechoicesOptions> _mapToOptions(
      List<Object> options) {
    if (options == null || options.isEmpty) {
      return null;
    }

    return options
        .map((e) => e as Map<String, Object>)
        .map(
          (e) => QuizMessageMultiplechoicesOptions(
            index: e['index'],
            display: e['display'],
          ),
        )
        .toList();
  }

  static UserProfileEntity _parseUserProfile(Map<String, Object> jsonData) {
    if (jsonData == null || jsonData.isEmpty) {
      return null;
    }

    String nickname = jsonData['apelido'];
    String avatar = jsonData['avatar_url'];

    return UserProfileEntity(nickname: nickname, avatar: avatar);
  }
}
