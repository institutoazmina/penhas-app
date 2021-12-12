import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:penhas/app/features/appstate/data/model/user_profile_model.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';

class AppStateModel extends AppStateEntity {
  final QuizSessionEntity? quizSession;
  final UserProfileEntity? userProfile;
  final AppStateModeEntity appMode;
  final List<AppStateModuleEntity?>? modules;

  AppStateModel(
    this.quizSession,
    this.userProfile,
    this.appMode,
    this.modules,
  ) : super(
          quizSession: quizSession,
          userProfile: userProfile,
          appMode: appMode,
          modules: modules,
        );

  factory AppStateModel.fromJson(Map<String, Object> jsonData) {
    final hasActivedGuardian =
        ((jsonData['qtde_guardioes_ativos'] as num?)?.toInt() ?? 0) > 0;
    final appMode = AppStateModeEntity(
      hasActivedGuardian: qtyActiveGuardians > 0,
    );

    final quizSession = _parseQuizSession(jsonData['quiz_session'] as Map<String, Object>?);
    final userProfile = _parseUserProfile(jsonData['user_profile'] as Map<String, Object>?);
    final modules = _parseAppModules(jsonData['modules'] as List<Object>?);
    return AppStateModel(quizSession, userProfile, appMode, modules);
  }

  static QuizSessionEntity? _parseQuizSession(Map<String, Object>? session) {
    if (session == null || session.isEmpty) {
      return null;
    }

    final currentMessage = _parseQuizMessage(session["current_msgs"] as List<Object>?);
    final previousMessage = _parseQuizMessage(session['prev_msgs'] as List<Object>?);
    final isFinished = (session['finished'] != null && session['finished'] == 1)
        ? true
        : false;

    if (previousMessage != null) {
      currentMessage!.insertAll(0, previousMessage);
    }

    final String sessionId = "${session['session_id']}";
    return QuizSessionEntity(
        currentMessage: currentMessage,
        sessionId: sessionId,
        isFinished: isFinished,
        endScreen: session['end_screen'] as String?);
  }

  static List<QuizMessageEntity>? _parseQuizMessage(List<Object>? data) {
    if (data == null || data.isEmpty) {
      return null;
    }

    return data
        .map((e) => e as Map<String, dynamic>)
        .expand((e) => _buildMessage(e))
        .toList();
  }

  static List<AppStateModuleEntity?>? _parseAppModules(List<Object>? data) {
    if (data == null || data.isEmpty) {
      return [];
    }

    List<AppStateModuleEntity?> result = data
        .map((e) => e as Map<String, Object>)
        .map((e) => _buildModule(e))
        .toList();

    result.removeWhere((e) => e == null);
    return result;
  }

  static AppStateModuleEntity? _buildModule(Map<String, Object> message) {
    if (message == null || message.isEmpty) {
      return null;
    }

    String? code = message['code'] as String?;
    if (message['code'] == null || message['code'].toString().isEmpty) {
      return null;
    }

    final String meta =
        module['meta'] == null ? '{}' : jsonEncode(module['meta']);
    return AppStateModuleEntity(code: code, meta: meta);
  }

  static List<QuizMessageEntity> _buildMessage(Map<String, dynamic> message) {
    if (message['display_response'] != null) {
      return _buildDisplayResponseMessage(message);
    }

    return [
      QuizMessageEntity(
        content: message['content'] as String?,
        ref: message['ref'] as String?,
        style: message['style'] as String?,
        action: message['action'] as String?,
        buttonLabel: message['label'] as String?,
        type: _mapMessageType(message),
        options: _mapToOptions(message['options'] as List<Object>?),
      )
    ];
  }

  static QuizMessageType _mapMessageType(Map<String, Object> message) {
    QuizMessageType type = QuizMessageType.from[message['type'] as String];
    if (message['action'] == 'botao_tela_modo_camuflado') {
      type = QuizMessageType.showStealthTutorial;
    }
    if (message['action'] == 'botao_tela_socorro') {
      type = QuizMessageType.showHelpTutorial;
    }
    if (message['action'] == 'reload') {
      type = QuizMessageType.forceReload;
    }

    return type;
  }

  static List<QuizMessageEntity> _buildDisplayResponseMessage(
    Map<String, dynamic> message,
  ) {
    return [
      QuizMessageEntity(
        content: message['content'] as String?,
        type: QuizMessageType.displayText,
        style: 'normal',
      ),
      QuizMessageEntity(
        content: message['display_response'] as String?,
        type: QuizMessageType.displayTextResponse,
        style: 'normal',
      )
    ];
  }

  static List<QuizMessageMultiplechoicesOptions>? _mapToOptions(
      List<Object>? options) {
    if (options == null || options.isEmpty) {
      return null;
    }

    return options
        .map((e) => e as Map<String, dynamic>)
        .map(
          (e) => QuizMessageMultiplechoicesOptions(
            index: e['index'] as String?,
            display: e['display'] as String?,
          ),
        )
        .toList();
  }

  static UserProfileEntity? _parseUserProfile(Map<String, Object>? jsonData) {
    if (jsonData == null || jsonData.isEmpty) {
      return null;
    }

    return UserProfileModel.fromJson(jsonData);
  }
}
