import '../../../appstate/data/model/quiz_session_model.dart';
import '../../domain/entity/escape_manual.dart';

class EscapeManualModel extends EscapeManualEntity {
  const EscapeManualModel({
    required EscapeManualAssistantModel assistant,
  }) : super(assistant: assistant);

  factory EscapeManualModel.fromJson(Map<String, dynamic> json) {
    return EscapeManualModel(
      assistant: EscapeManualAssistantModel.fromJson(json['mf_assistant']),
    );
  }
}

class EscapeManualAssistantModel extends EscapeManualAssistantEntity {
  const EscapeManualAssistantModel({
    required String explanation,
    required EscapeManualAssistantActionModel action,
  }) : super(
          explanation: explanation,
          action: action,
        );

  factory EscapeManualAssistantModel.fromJson(Map<String, dynamic> json) {
    return EscapeManualAssistantModel(
      explanation: json['subtitle'],
      action: EscapeManualAssistantActionModel.fromJson(json),
    );
  }
}

class EscapeManualAssistantActionModel
    extends EscapeManualAssistantActionEntity {
  const EscapeManualAssistantActionModel({
    required String text,
    required QuizSessionModel quizSession,
  }) : super(text: text, quizSession: quizSession);

  factory EscapeManualAssistantActionModel.fromJson(Map<String, dynamic> json) {
    return EscapeManualAssistantActionModel(
      text: json['title'],
      quizSession: QuizSessionModel.fromJson(json['quiz_session']),
    );
  }
}
