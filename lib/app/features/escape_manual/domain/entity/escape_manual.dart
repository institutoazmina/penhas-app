import 'package:equatable/equatable.dart';

import '../../../appstate/domain/entities/app_state_entity.dart';

class EscapeManualEntity extends Equatable {
  const EscapeManualEntity({
    required this.assistant,
    this.sections = const [],
  });

  final EscapeManualAssistantEntity assistant;
  final List<EscapeManualTasksSectionEntity> sections;

  @override
  List<Object?> get props => [assistant, sections];
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
}

class EscapeManualTaskEntity extends Equatable {
  const EscapeManualTaskEntity({
    required this.id,
    required this.type,
    required this.description,
    required this.isEditable,
    required this.userInputValue,
    required this.isDone,
  });

  final String id;
  final String type;
  final String description;
  final bool isEditable;
  final String? userInputValue;
  final bool isDone;

  @override
  List<Object?> get props => [
        id,
        type,
        description,
        isEditable,
        userInputValue,
        isDone,
      ];
}
