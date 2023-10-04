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

EscapeManualAssistantRemoteModel _$EscapeManualAssistantRemoteModelFromJson(
        Map<String, dynamic> json) =>
    EscapeManualAssistantRemoteModel(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      quizSession: QuizSessionModel.fromJson(
          json['quiz_session'] as Map<String, dynamic>),
    );

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
      userInputValue: json['campo_livre'] as String?,
      updatedAt: const JsonSecondsFromEpochConverter()
          .fromJson(json['atualizado_em'] as int),
    );
