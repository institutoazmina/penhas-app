import 'package:equatable/equatable.dart';

import '../../../appstate/data/model/quiz_session_model.dart';

class EscapeManualRemoteModel extends Equatable {
  const EscapeManualRemoteModel({
    required this.assistant,
    this.tasks = const [],
    this.removedTasks = const [],
  });

  final EscapeManualAssistantRemoteModel assistant;

  final Iterable<EscapeManualTaskRemoteModel> tasks;

  final Iterable<String> removedTasks;

  @override
  List<Object?> get props => [assistant, tasks.toList(), removedTasks.toList()];
}

class EscapeManualAssistantRemoteModel extends Equatable {
  const EscapeManualAssistantRemoteModel({
    required this.title,
    required this.subtitle,
    required this.quizSession,
  });

  final String title;

  final String? subtitle;

  final QuizSessionModel quizSession;

  @override
  List<Object?> get props => [title, subtitle, quizSession];
}

class EscapeManualTaskRemoteModel extends Equatable {
  const EscapeManualTaskRemoteModel({
    required this.id,
    required this.type,
    required this.group,
    this.title,
    required this.description,
    this.isDone = false,
    this.isEditable = false,
    this.userInputValue,
    required this.updatedAt,
  });

  final String id;

  final String type;

  final String group;

  final String? title;

  final String description;

  final String? userInputValue;

  final bool isEditable;

  final bool isDone;

  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        type,
        group,
        title,
        description,
        isDone,
        isEditable,
        userInputValue,
        updatedAt,
      ];
}
