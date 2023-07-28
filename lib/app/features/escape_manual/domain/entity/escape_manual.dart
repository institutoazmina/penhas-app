import 'package:equatable/equatable.dart';

import '../../../appstate/domain/entities/app_state_entity.dart';

class EscapeManualEntity extends Equatable {
  const EscapeManualEntity({
    required this.assistant,
    this.sections = const [],
  });

  final EscapeManualAssistantEntity assistant;
  final Iterable<EscapeManualTasksSectionEntity> sections;

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
  final Iterable<EscapeManualTaskEntity> tasks;

  @override
  List<Object?> get props => [title, tasks];
}

class EscapeManualTaskEntity extends Equatable {
  const EscapeManualTaskEntity({
    required this.id,
    required this.type,
    required this.group,
    required this.title,
    required this.description,
    required this.isEditable,
    required this.userInputValue,
    required this.isDone,
    required this.updatedAt,
  });

  final String id;
  final String type;
  final String group;
  final String title;
  final String description;
  final bool isEditable;
  final String? userInputValue;
  final bool isDone;
  final int updatedAt;

  @override
  List<Object?> get props => [
        id,
        type,
        group,
        title,
        description,
        isEditable,
        userInputValue,
        isDone,
        updatedAt,
      ];

  EscapeManualTaskEntity copyWith({
    String? id,
    String? type,
    String? group,
    String? title,
    String? description,
    bool? isEditable,
    String? userInputValue,
    bool? isDone,
    int? updatedAt,
  }) =>
      EscapeManualTaskEntity(
        id: id ?? this.id,
        type: type ?? this.type,
        group: group ?? this.group,
        title: title ?? this.title,
        description: description ?? this.description,
        isEditable: isEditable ?? this.isEditable,
        userInputValue: userInputValue ?? this.userInputValue,
        isDone: isDone ?? this.isDone,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
