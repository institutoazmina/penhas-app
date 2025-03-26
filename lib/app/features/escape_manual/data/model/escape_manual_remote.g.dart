// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'escape_manual_remote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EscapeManualRemoteModel _$EscapeManualRemoteModelFromJson(
        Map<String, dynamic> json) =>
    EscapeManualRemoteModel(
      lastModifiedAt: const JsonSecondsFromEpochConverter()
          .fromJson((json['consultado_em'] as num).toInt()),
      assistant: EscapeManualAssistantRemoteModel.fromJson(
          json['mf_assistant'] as Map<String, dynamic>),
      tasks: json['tarefas'] == null
          ? const []
          : parseTasksFromJson(json['tarefas'] as List?),
      removedTasks: json['tarefas_removidas'] == null
          ? const []
          : FromJson.parseAsStringList(json['tarefas_removidas'] as List),
    );

Map<String, dynamic> _$EscapeManualRemoteModelToJson(
        EscapeManualRemoteModel instance) =>
    <String, dynamic>{
      'mf_assistant': instance.assistant,
      'tarefas': instance.tasks.toList(),
      'tarefas_removidas': instance.removedTasks.toList(),
      'consultado_em':
          const JsonSecondsFromEpochConverter().toJson(instance.lastModifiedAt),
    };

EscapeManualAssistantRemoteModel _$EscapeManualAssistantRemoteModelFromJson(
        Map<String, dynamic> json) =>
    EscapeManualAssistantRemoteModel(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      quizSession: QuizSessionModel.fromJson(
          json['quiz_session'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EscapeManualAssistantRemoteModelToJson(
        EscapeManualAssistantRemoteModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      if (instance.subtitle case final value?) 'subtitle': value,
      'quiz_session': instance.quizSession,
    };

EscapeManualTaskRemoteModel _$EscapeManualTaskRemoteModelFromJson(
        Map<String, dynamic> json) =>
    EscapeManualTaskRemoteModel(
      id: FromJson.parseAsString(json['id']),
      type: $enumDecode(_$EscapeManualTaskTypeEnumMap, json['tipo'],
          unknownValue: EscapeManualTaskType.unknown),
      group: json['agrupador'] as String,
      title: const JsonEmptyStringToNullConverter()
          .fromJson(json['titulo'] as String?),
      description: json['descricao'] as String? ?? '',
      isDone: json['checkbox_feito'] == null
          ? false
          : const JsonBoolConverter().fromJson(json['checkbox_feito']),
      value: userInputValueFromJson(
          readUserInputValue(json, 'campo_livre') as Map<String, dynamic>),
      updatedAt: const JsonSecondsFromEpochConverter()
          .fromJson((json['atualizado_em'] as num).toInt()),
      rawType: readRawType(json, 'rawType') as String?,
    );

Map<String, dynamic> _$EscapeManualTaskRemoteModelToJson(
        EscapeManualTaskRemoteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tipo': _$EscapeManualTaskTypeEnumMap[instance.type]!,
      if (instance.rawType case final value?) 'rawType': value,
      'agrupador': instance.group,
      if (const JsonEmptyStringToNullConverter().toJson(instance.title)
          case final value?)
        'titulo': value,
      'descricao': instance.description,
      if (instance.value case final value?) 'campo_livre': value,
      if (const JsonBoolConverter().toJson(instance.isDone) case final value?)
        'checkbox_feito': value,
      'atualizado_em':
          const JsonSecondsFromEpochConverter().toJson(instance.updatedAt),
    };

const _$EscapeManualTaskTypeEnumMap = {
  EscapeManualTaskType.unknown: 'unknown',
  EscapeManualTaskType.normal: 'checkbox',
  EscapeManualTaskType.contacts: 'checkbox_contato',
  EscapeManualTaskType.button: 'button',
};
