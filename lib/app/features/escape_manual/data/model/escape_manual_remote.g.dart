// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'escape_manual_remote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EscapeManualRemoteModel _$EscapeManualRemoteModelFromJson(
        Map<String, dynamic> json) =>
    EscapeManualRemoteModel(
      lastModifiedAt: const JsonSecondsFromEpochConverter()
          .fromJson(json['consultado_em'] as int),
      assistant: EscapeManualAssistantRemoteModel.fromJson(
          json['mf_assistant'] as Map<String, dynamic>),
      tasks: (json['tarefas'] as List<dynamic>?)?.map((e) =>
              EscapeManualTaskRemoteModel.fromJson(
                  e as Map<String, dynamic>)) ??
          const [],
      removedTasks: json['tarefas_removidas'] == null
          ? const []
          : FromJson.parseAsStringList(json['tarefas_removidas'] as List),
    );

Map<String, dynamic> _$EscapeManualRemoteModelToJson(
    EscapeManualRemoteModel instance) {
  final val = <String, dynamic>{
    'mf_assistant': instance.assistant,
    'tarefas': instance.tasks.toList(),
    'tarefas_removidas': instance.removedTasks.toList(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('consultado_em',
      const JsonSecondsFromEpochConverter().toJson(instance.lastModifiedAt));
  return val;
}

EscapeManualAssistantRemoteModel _$EscapeManualAssistantRemoteModelFromJson(
        Map<String, dynamic> json) =>
    EscapeManualAssistantRemoteModel(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      quizSession: QuizSessionModel.fromJson(
          json['quiz_session'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EscapeManualAssistantRemoteModelToJson(
    EscapeManualAssistantRemoteModel instance) {
  final val = <String, dynamic>{
    'title': instance.title,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('subtitle', instance.subtitle);
  val['quiz_session'] = instance.quizSession;
  return val;
}

EscapeManualTaskRemoteModel _$EscapeManualTaskRemoteModelFromJson(
        Map<String, dynamic> json) =>
    EscapeManualTaskRemoteModel(
      id: FromJson.parseAsString(json['id']),
      type: $enumDecode(_$EscapeManualTaskTypeEnumMap, json['tipo']),
      group: json['agrupador'] as String,
      title: const JsonEmptyStringToNullConverter()
          .fromJson(json['titulo'] as String?),
      description: json['descricao'] as String,
      isDone: json['checkbox_feito'] == null
          ? false
          : const JsonBoolConverter().fromJson(json['checkbox_feito']),
      value: userInputValueFromJson(
          readUserInputValue(json, 'campo_livre') as Map<String, dynamic>),
      updatedAt: const JsonSecondsFromEpochConverter()
          .fromJson(json['atualizado_em'] as int),
    );

Map<String, dynamic> _$EscapeManualTaskRemoteModelToJson(
    EscapeManualTaskRemoteModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'tipo': _$EscapeManualTaskTypeEnumMap[instance.type]!,
    'agrupador': instance.group,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'titulo', const JsonEmptyStringToNullConverter().toJson(instance.title));
  val['descricao'] = instance.description;
  writeNotNull('campo_livre', instance.value);
  writeNotNull(
      'checkbox_feito', const JsonBoolConverter().toJson(instance.isDone));
  writeNotNull('atualizado_em',
      const JsonSecondsFromEpochConverter().toJson(instance.updatedAt));
  return val;
}

const _$EscapeManualTaskTypeEnumMap = {
  EscapeManualTaskType.normal: 'checkbox',
  EscapeManualTaskType.contacts: 'checkbox_contato',
  EscapeManualTaskType.unknown: 'unknown',
};
