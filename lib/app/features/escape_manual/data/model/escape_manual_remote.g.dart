// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'escape_manual_remote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EscapeManualRemoteModel _$EscapeManualRemoteModelFromJson(
        Map<String, dynamic> json) =>
    EscapeManualRemoteModel(
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
        EscapeManualRemoteModel instance) =>
    <String, dynamic>{
      'mf_assistant': instance.assistant,
      'tarefas': instance.tasks.toList(),
      'tarefas_removidas': instance.removedTasks.toList(),
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
      type: json['tipo'] as String,
      group: json['agrupador'] as String,
      title: const JsonEmptyStringToNullConverter()
          .fromJson(json['titulo'] as String?),
      description: json['descricao'] as String,
      isDone: json['checkbox_feito'] == null
          ? false
          : const JsonBoolConverter().fromJson(json['checkbox_feito']),
      isEditable: json['eh_customizada'] == null
          ? false
          : const JsonBoolConverter().fromJson(json['eh_customizada']),
      userInputValue: json['campo_livre'],
      updatedAt: const JsonSecondsFromEpochConverter()
          .fromJson(json['atualizado_em'] as int),
    );

Map<String, dynamic> _$EscapeManualTaskRemoteModelToJson(
    EscapeManualTaskRemoteModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'tipo': instance.type,
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
  writeNotNull('campo_livre', instance.userInputValue);
  writeNotNull(
      'eh_customizada', const JsonBoolConverter().toJson(instance.isEditable));
  writeNotNull(
      'checkbox_feito', const JsonBoolConverter().toJson(instance.isDone));
  writeNotNull('atualizado_em',
      const JsonSecondsFromEpochConverter().toJson(instance.updatedAt));
  return val;
}
