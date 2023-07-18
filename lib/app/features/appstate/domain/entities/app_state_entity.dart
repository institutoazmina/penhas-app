import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'user_profile_entity.dart';

enum QuizMessageType {
  button,
  yesno,
  displayText,
  showStealthTutorial,
  showHelpTutorial,
  forceReload,
  multipleChoices,
  singleChoice,
  displayTextResponse,
}

extension QuizMessageTypeExtension on List<QuizMessageType> {
  QuizMessageType byName(String key) {
    switch (key.toLowerCase()) {
      case 'button':
        return QuizMessageType.button;
      case 'show_tutorial':
        return QuizMessageType.showStealthTutorial;
      case 'yesno':
        return QuizMessageType.yesno;
      case 'displaytext':
        return QuizMessageType.displayText;
      case 'display_response':
        return QuizMessageType.displayTextResponse;
      case 'multiplechoices':
        return QuizMessageType.multipleChoices;
      case 'onlychoice':
      case 'singlechoice':
        return QuizMessageType.singleChoice;
      default:
        return QuizMessageType.displayText;
    }
  }
}

@immutable
class AppStateEntity extends Equatable {
  const AppStateEntity({
    required this.quizSession,
    required this.userProfile,
    required this.appMode,
    required this.modules,
  });

  final QuizSessionEntity? quizSession;
  final UserProfileEntity? userProfile;
  final AppStateModeEntity appMode;
  final List<AppStateModuleEntity> modules;

  @override
  List<Object?> get props => [
        quizSession,
        userProfile,
        appMode,
        modules,
      ];

  @override
  bool get stringify => true;
}

@immutable
class QuizSessionEntity extends Equatable {
  const QuizSessionEntity({
    required this.currentMessage,
    required this.sessionId,
    required this.isFinished,
    required this.endScreen,
  });

  final List<QuizMessageEntity>? currentMessage;
  final String sessionId;
  final bool isFinished;
  final String? endScreen;

  @override
  List<Object?> get props => [currentMessage, sessionId, isFinished, endScreen];
}

@immutable
class QuizMessageEntity extends Equatable {
  const QuizMessageEntity({
    required this.content,
    required this.type,
    this.ref = '',
    this.style,
    this.action,
    this.options,
    this.buttonLabel,
  });

  final String? content;
  final QuizMessageType type;
  final String ref;
  final String? style;
  final String? action;
  final String? buttonLabel;
  final List<QuizMessageChoiceOption>? options;

  @override
  List<dynamic> get props =>
      [content, style, action, type, ref, options, buttonLabel];
}

class QuizMessageChoiceOption extends Equatable {
  const QuizMessageChoiceOption({
    required this.display,
    required this.index,
  });

  final String display;
  final String index;

  @override
  List<Object?> get props => [display, index];
}

@immutable
class AppStateModeEntity extends Equatable {
  const AppStateModeEntity({
    this.hasActivedGuardian = false,
  });

  final bool hasActivedGuardian;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        hasActivedGuardian,
      ];

  Map<String, Object?> toJson() => {
        'hasActivedGuardian': hasActivedGuardian,
      };
}

@immutable
class AppStateModuleEntity extends Equatable {
  const AppStateModuleEntity({
    required this.code,
    required this.meta,
  });

  final String code;
  final String meta;

  @override
  List<Object?> get props => [code, meta];
}
