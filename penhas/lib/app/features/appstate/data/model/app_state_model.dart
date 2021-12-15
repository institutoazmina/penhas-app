import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:penhas/app/features/appstate/data/model/user_profile_model.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';

class AppStateModel extends AppStateEntity {
  @override
  final QuizSessionEntity? quizSession;
  @override
  final UserProfileEntity? userProfile;
  @override
  final AppStateModeEntity appMode;
  @override
  final List<AppStateModuleEntity> modules;

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

  factory AppStateModel.fromJson(Map<String, dynamic> jsonData) {
    final qtyActiveGuardians = jsonData['qtde_guardioes_ativos'] ?? 0;
    final appMode = AppStateModeEntity(
      hasActivedGuardian: qtyActiveGuardians > 0,
    );

    final quizSession = _parseQuizSession(jsonData['quiz_session']);
    final userProfile = _parseUserProfile(jsonData['user_profile']);
    final List<AppStateModuleEntity> modules = jsonData.containsKey('modules')
        ? _parseAppModules(jsonData['modules'] as List<dynamic>)
        : [];
    return AppStateModel(quizSession, userProfile, appMode, modules);
  }

  static QuizSessionEntity? _parseQuizSession(Map<String, dynamic>? session) {
    if (session == null || session.isEmpty) {
      return null;
    }

    final currentMessage = _parseQuizMessage(session['current_msgs']);
    final previousMessage = _parseQuizMessage(session['prev_msgs']);
    final isFinished = session['finished'] != null && session['finished'] == 1;

    if (previousMessage != null) {
      currentMessage?.insertAll(0, previousMessage);
    }

    final String sessionId = "${session['session_id']}";
    return QuizSessionEntity(
      currentMessage: currentMessage,
      sessionId: sessionId,
      isFinished: isFinished,
      endScreen: session['end_screen'],
    );
  }

  static List<QuizMessageEntity>? _parseQuizMessage(List<dynamic>? data) {
    if (data == null || data.isEmpty) {
      return null;
    }

    return data
        .map((e) => e as Map<String, dynamic>)
        .expand((e) => _buildMessage(e))
        .toList();
  }

  static List<AppStateModuleEntity> _parseAppModules(List<dynamic>? data) {
    if (data == null || data.isEmpty) {
      return [];
    }

    return data.map((e) => _buildModule(e)).whereNotNull().toList();
  }

  static AppStateModuleEntity? _buildModule(Map<String, dynamic> module) {
    if (module.isEmpty) {
      return null;
    }

    final String? code = module['code'];
    if (code == null || code.isEmpty) {
      return null;
    }

    final String meta = module['meta'] == null ? '{}' : jsonEncode(module['meta']);
    return AppStateModuleEntity(code: code, meta: meta);
  }

  static List<QuizMessageEntity> _buildMessage(Map<String, dynamic> message) {
    if (message['display_response'] != null) {
      return _buildDisplayResponseMessage(message);
    }

    return [
      QuizMessageEntity(
        content: message['content'],
        ref: message['ref'] ?? '',
        style: message['style'],
        action: message['action'],
        buttonLabel: message['label'],
        type: _mapMessageType(message),
        options: _mapToOptions(message['options']),
      )
    ];
  }

  static QuizMessageType _mapMessageType(Map<String, dynamic> message) {
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
      Map<String, dynamic> message) {
    return [
      QuizMessageEntity(
        content: message['content'],
        type: QuizMessageType.displayText,
        style: 'normal',
      ),
      QuizMessageEntity(
        content: message['display_response'],
        type: QuizMessageType.displayTextResponse,
        style: 'normal',
      )
    ];
  }

  static List<QuizMessageMultiplechoicesOptions>? _mapToOptions(
      List<dynamic>? options) {
    if (options == null || options.isEmpty) {
      return null;
    }

    return options
        .map((e) => e as Map<String, dynamic>)
        .map(
          (e) => QuizMessageMultiplechoicesOptions(
            index: e['index'],
            display: e['display'],
          ),
        )
        .toList();
  }

  static UserProfileEntity? _parseUserProfile(Map<String, dynamic>? jsonData) {
    if (jsonData == null || jsonData.isEmpty) {
      return null;
    }

    return UserProfileModel.fromJson(jsonData);
  }
}
