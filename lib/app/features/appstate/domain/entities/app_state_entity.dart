import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';

enum QuizMessageType {
  from,
  button,
  yesno,
  displayText,
  showStealthTutorial,
  showHelpTutorial,
  forceReload,
  multipleChoices,
  displayTextResponse,
}

extension QuizMessageTypeExtension on QuizMessageType {
  QuizMessageType operator [](String key) {
    var type = QuizMessageType.displayText;
    switch (key.toLowerCase()) {
      case 'button':
        type = QuizMessageType.button;
        break;
      case 'show_tutorial':
        type = QuizMessageType.showStealthTutorial;
        break;
      case 'yesno':
        type = QuizMessageType.yesno;
        break;
      case 'displaytext':
        type = QuizMessageType.displayText;
        break;
      case 'display_response':
        type = QuizMessageType.displayTextResponse;
        break;
      case 'multiplechoices':
        type = QuizMessageType.multipleChoices;
        break;
    }

    return type;
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

  @override
  String toString() {
    return 'QuizSessionEntity{currentMessage: ${currentMessage.toString()}, sessionId: $sessionId, endScreen: ${endScreen.toString()}, isFinished: ${isFinished.toString()} }';
  }
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
  final List<QuizMessageMultiplechoicesOptions>? options;

  @override
  List<dynamic> get props =>
      [content, style, action, type, ref, options, buttonLabel];

  @override
  String toString() {
    return 'QuizMessageEntity{content: ${content.toString()}, type: ${type.toString()}, style: ${style.toString()}, action: ${action.toString()}, ref: $ref}, buttonLabel: ${buttonLabel.toString()}, options: ${options.toString()}';
  }
}

class QuizMessageMultiplechoicesOptions extends Equatable {
  const QuizMessageMultiplechoicesOptions({
    required this.display,
    required this.index,
  });

  final String? display;
  final String? index;

  @override
  List<Object?> get props => [display, index!];

  @override
  String toString() {
    return 'QuizMessageMultiplechoicesOptions{index: ${index.toString()}, display: ${display.toString()}}';
  }
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
  bool get stringify => true;

  @override
  List<Object?> get props => [code, meta];
}
