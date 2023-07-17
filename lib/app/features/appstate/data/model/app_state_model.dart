import 'dart:convert';

import 'package:collection/collection.dart';

import '../../domain/entities/app_state_entity.dart';
import '../../domain/entities/user_profile_entity.dart';
import 'quiz_session_model.dart';
import 'user_profile_model.dart';

class AppStateModel extends AppStateEntity {
  const AppStateModel(
    QuizSessionEntity? quizSession,
    UserProfileEntity? userProfile,
    AppStateModeEntity appMode,
    List<AppStateModuleEntity> modules,
  ) : super(
          quizSession: quizSession,
          userProfile: userProfile,
          appMode: appMode,
          modules: modules,
        );

  factory AppStateModel.fromJson(Map<String, dynamic> jsonData) {
    final int qtyActiveGuardians = jsonData['qtde_guardioes_ativos'] ?? 0;
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
    return QuizSessionModel.fromJson(session);
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

    final String meta =
        module['meta'] == null ? '{}' : jsonEncode(module['meta']);
    return AppStateModuleEntity(code: code, meta: meta);
  }

  static UserProfileEntity? _parseUserProfile(Map<String, dynamic>? jsonData) {
    if (jsonData == null || jsonData.isEmpty) {
      return null;
    }

    return UserProfileModel.fromJson(jsonData);
  }
}
