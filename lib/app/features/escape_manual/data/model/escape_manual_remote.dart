import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/extension/date_time.dart';
import '../../../../core/extension/json_serializer.dart';
import '../../../appstate/data/model/quiz_session_model.dart';

part 'escape_manual_remote.g.dart';

@JsonSerializable()
class EscapeManualRemoteModel extends Equatable {
  EscapeManualRemoteModel({
    required this.assistant,
    this.tasks = const [],
    this.removedTasks = const [],
  });

  factory EscapeManualRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$EscapeManualRemoteModelFromJson(json);

  @JsonKey(name: 'mf_assistant')
  final EscapeManualAssistantRemoteModel assistant;

  @JsonKey(name: 'tarefas')
  final Iterable<EscapeManualTaskRemoteModel> tasks;

  @JsonKey(name: 'tarefas_removidas', fromJson: FromJson.parseAsStringList)
  final Iterable<String> removedTasks;

  late final DateTime lastModifiedAt = tasks.fold<DateTime>(
    DateTimeExt.epoch,
    (acc, cur) => acc > cur.updatedAt ? acc : cur.updatedAt,
  );

  @override
  List<Object?> get props => [assistant, tasks.toList(), removedTasks.toList()];

  Map<String, dynamic> toJson() => _$EscapeManualRemoteModelToJson(this);

  EscapeManualRemoteModel copyWith({
    EscapeManualAssistantRemoteModel? assistant,
    Iterable<EscapeManualTaskRemoteModel>? tasks,
  }) =>
      EscapeManualRemoteModel(
        assistant: assistant ?? this.assistant,
        tasks: tasks ?? this.tasks,
      );
}

@JsonSerializable()
class EscapeManualAssistantRemoteModel extends Equatable {
  const EscapeManualAssistantRemoteModel({
    required this.title,
    required this.subtitle,
    required this.quizSession,
  });

  factory EscapeManualAssistantRemoteModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$EscapeManualAssistantRemoteModelFromJson(json);

  @JsonKey()
  final String title;

  @JsonKey()
  final String? subtitle;

  @JsonKey(name: 'quiz_session')
  final QuizSessionModel quizSession;

  @override
  List<Object?> get props => [title, subtitle, quizSession];

  Map<String, Object?> toJson() =>
      _$EscapeManualAssistantRemoteModelToJson(this);
}

@JsonSerializable()
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

  factory EscapeManualTaskRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$EscapeManualTaskRemoteModelFromJson(json);

  @JsonKey(fromJson: FromJson.parseAsString)
  final String id;

  @JsonKey(name: 'tipo')
  final String type;

  @JsonKey(name: 'agrupador')
  final String group;

  @JsonKey(name: 'titulo')
  @JsonEmptyStringToNullConverter()
  final String? title;

  @JsonKey(name: 'descricao')
  final String description;

  @JsonKey(name: 'campo_livre')
  final dynamic userInputValue;

  @JsonKey(name: 'eh_customizada')
  @JsonBoolConverter()
  final bool isEditable;

  @JsonKey(name: 'checkbox_feito')
  @JsonBoolConverter()
  final bool isDone;

  @JsonKey(name: 'atualizado_em')
  @JsonSecondsFromEpochConverter()
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

  Map<String, Object?> toJson() => _$EscapeManualTaskRemoteModelToJson(this);

  EscapeManualTaskRemoteModel copyWith({
    dynamic userInputValue,
    bool? isDone,
  }) =>
      EscapeManualTaskRemoteModel(
        id: id,
        type: type,
        group: group,
        title: title,
        description: description,
        isEditable: isEditable,
        userInputValue: userInputValue ?? this.userInputValue,
        isDone: isDone ?? this.isDone,
        updatedAt: updatedAt,
      );
}
