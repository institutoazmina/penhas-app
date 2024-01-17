import 'package:equatable/equatable.dart';

import '../../../appstate/domain/entities/app_state_entity.dart';
import 'escape_manual_task.dart';

export 'escape_manual_task.dart';

class EscapeManualEntity extends Equatable {
  const EscapeManualEntity({
    required this.assistant,
    required this.sections,
  });

  final EscapeManualAssistantEntity assistant;
  final List<EscapeManualTasksSectionEntity> sections;

  @override
  List<Object?> get props => [assistant, sections];

  EscapeManualEntity copyWith({
    required List<EscapeManualTasksSectionEntity> sections,
  }) =>
      EscapeManualEntity(
        assistant: assistant,
        sections: sections,
      );
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

class EscapeManualTasksSectionEntity extends Equatable {
  const EscapeManualTasksSectionEntity({
    required this.title,
    required this.tasks,
  });

  final String title;
  final List<EscapeManualTaskEntity> tasks;

  @override
  List<Object?> get props => [title, tasks];

  EscapeManualTasksSectionEntity copyWith({
    required List<EscapeManualTaskEntity> tasks,
  }) =>
      EscapeManualTasksSectionEntity(
        title: title,
        tasks: tasks,
      );
}
