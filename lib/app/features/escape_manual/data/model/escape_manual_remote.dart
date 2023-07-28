import 'package:equatable/equatable.dart';

import '../../../appstate/data/model/quiz_session_model.dart';
import '../../domain/entity/escape_manual.dart';
import 'escape_manual.dart';

class EscapeManualRemoteModel extends Equatable {
  const EscapeManualRemoteModel({
    required this.assistant,
    this.tasks = const [],
  });

  factory EscapeManualRemoteModel.fromJson(Map<String, dynamic> json) =>
      EscapeManualRemoteModel(
        assistant: EscapeManualAssistantRemoteModel.fromJson(
          json['mf_assistant'],
        ),
        tasks: EscapeManualTaskRemoteModel.fromJsonList(
          json['tarefas'] ?? [],
        ),
      );

  final EscapeManualAssistantRemoteModel assistant;
  final Iterable<EscapeManualTaskModel> tasks;

  @override
  List<Object?> get props => [assistant, tasks];

  EscapeManualRemoteModel copyWith({
    EscapeManualAssistantRemoteModel? assistant,
    Iterable<EscapeManualTaskModel>? tasks,
  }) =>
      EscapeManualRemoteModel(
        assistant: assistant ?? this.assistant,
        tasks: tasks ?? this.tasks,
      );

  EscapeManualEntity toEntity() => EscapeManualEntity(
        assistant: assistant.toEntity(),
        sections: EscapeManualTasksSectionModel.fromList(tasks),
      );
}

class EscapeManualAssistantRemoteModel extends Equatable {
  const EscapeManualAssistantRemoteModel({
    required this.title,
    required this.subtitle,
    required this.quizSession,
  });

  factory EscapeManualAssistantRemoteModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      EscapeManualAssistantRemoteModel(
        title: json['title'] ?? '',
        subtitle: json['subtitle'],
        quizSession: QuizSessionModel.fromJson(json['quiz_session']),
      );

  final String title;
  final String subtitle;
  final QuizSessionModel quizSession;

  @override
  List<Object?> get props => [title, subtitle, quizSession];

  EscapeManualAssistantEntity toEntity() => EscapeManualAssistantEntity(
        explanation: subtitle,
        action: EscapeManualAssistantActionEntity(
          text: title,
          quizSession: quizSession,
        ),
      );
}

class EscapeManualTaskRemoteModel extends EscapeManualTaskModel {
  const EscapeManualTaskRemoteModel({
    required String id,
    required String type,
    required String group,
    required String title,
    required String description,
    required bool isEditable,
    String? userInputValue,
    required bool isDone,
    required int updatedAt,
  }) : super(
          id: id,
          type: type,
          group: group,
          title: title,
          description: description,
          isEditable: isEditable,
          userInputValue: userInputValue,
          isDone: isDone,
          updatedAt: updatedAt,
        );

  factory EscapeManualTaskRemoteModel.fromJson(Map<String, dynamic> json) =>
      EscapeManualTaskRemoteModel(
        id: '${json['id']!}',
        type: json['tipo'],
        group: json['agrupador'],
        title: json['titulo'],
        description: json['descricao'],
        isEditable: '${json['eh_customizada']}' == '1',
        userInputValue: json['campo_livre'],
        isDone: '${json['checkbox_feito']}' == '1',
        updatedAt: json['atualizado_em'],
      );

  static Iterable<EscapeManualTaskRemoteModel> fromJsonList(
    List<dynamic> json,
  ) =>
      json.map<EscapeManualTaskRemoteModel>(
        (task) => EscapeManualTaskRemoteModel.fromJson(task),
      );
}
