import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/extension/json_serializer.dart';
import '../../../appstate/data/model/quiz_session_model.dart';
import 'escape_manual_mapper.dart'
    show readUserInputValue, userInputValueFromJson;
import 'escape_manual_task.dart';
import 'escape_manual_task_type.dart';

export 'contact.dart';
export 'escape_manual_task_type.dart';

part 'escape_manual_remote.g.dart';

@JsonSerializable()
class EscapeManualRemoteModel extends Equatable {
  const EscapeManualRemoteModel({
    required this.lastModifiedAt,
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

  @JsonKey(name: 'consultado_em')
  @JsonSecondsFromEpochConverter()
  final DateTime lastModifiedAt;

  @override
  List<Object?> get props =>
      [lastModifiedAt, assistant, tasks.toList(), removedTasks.toList()];

  Map<String, dynamic> toJson() => _$EscapeManualRemoteModelToJson(this);

  EscapeManualRemoteModel copyWith({
    DateTime? lastModifiedAt,
    EscapeManualAssistantRemoteModel? assistant,
    Iterable<EscapeManualTaskRemoteModel>? tasks,
  }) =>
      EscapeManualRemoteModel(
        lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
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
class EscapeManualTaskRemoteModel extends EscapeManualTaskModel {
  const EscapeManualTaskRemoteModel({
    required this.id,
    required this.type,
    required this.group,
    this.title,
    this.description = '',
    this.isDone = false,
    this.value,
    required this.updatedAt,
    this.isRemoved = false,
  }) : super(type: type, value: value);

  factory EscapeManualTaskRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$EscapeManualTaskRemoteModelFromJson(json);

  @override
  @JsonKey(fromJson: FromJson.parseAsString)
  final String id;

  @override
  @JsonKey(
    name: 'tipo',
    unknownEnumValue: EscapeManualTaskType.unknown,
  )
  final EscapeManualTaskType type;

  @JsonKey(name: 'agrupador')
  final String group;

  @JsonKey(name: 'titulo')
  @JsonEmptyStringToNullConverter()
  final String? title;

  @JsonKey(name: 'descricao')
  final String description;

  @override
  @JsonKey(
    name: 'campo_livre',
    readValue: readUserInputValue,
    fromJson: userInputValueFromJson,
  )
  final dynamic value;

  @override
  @JsonKey(name: 'checkbox_feito')
  @JsonBoolConverter()
  final bool isDone;

  @override
  @JsonKey(name: 'atualizado_em')
  @JsonSecondsFromEpochConverter()
  final DateTime updatedAt;

  @override
  final bool isRemoved;

  @override
  List<Object?> get props => [
        ...super.props,
        group,
        title,
        description,
      ];

  @override
  Map<String, Object?> toJson() => _$EscapeManualTaskRemoteModelToJson(this);

  @override
  EscapeManualTaskRemoteModel copyWith({
    dynamic value,
    bool? isDone,
    bool? isRemoved,
    DateTime? updatedAt,
  }) =>
      EscapeManualTaskRemoteModel(
        id: id,
        type: type,
        group: group,
        title: title,
        description: description,
        value: value ?? this.value,
        isDone: isDone ?? this.isDone,
        isRemoved: isRemoved ?? this.isRemoved,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
