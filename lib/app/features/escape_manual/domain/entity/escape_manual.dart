import 'package:equatable/equatable.dart';

import '../../../appstate/domain/entities/app_state_entity.dart';

class EscapeManualEntity extends Equatable {
  const EscapeManualEntity({
    required this.assistant,
  });

  final EscapeManualAssistantEntity assistant;

  @override
  List<Object?> get props => [assistant];
}

class EscapeManualAssistantEntity extends Equatable {
  const EscapeManualAssistantEntity({
    required this.explanation,
    required this.action,
  });

  final String explanation;
  final EscapeManualAssistantActionEntity action;

  @override
  List<Object?> get props => [explanation, action];
}

class EscapeManualAssistantActionEntity extends Equatable {
  const EscapeManualAssistantActionEntity({
    required this.text,
    required this.quizSession,
  });

  final String text;
  final QuizSessionEntity quizSession;

  @override
  List<Object?> get props => [text, quizSession];
}
