import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';

enum QuizMessageType {
  from,
  button,
  yesno,
  displayText,
  showTutorial,
  multipleChoices,
  displayTextResponse,
}

extension QuizMessageTypeExtension on QuizMessageType {
  operator [](String key) {
    var type = QuizMessageType.displayText;
    switch (key.toLowerCase()) {
      case 'button':
        type = QuizMessageType.button;
        break;
      case 'show_tutorial':
        type = QuizMessageType.showTutorial;
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
  final QuizSessionEntity quizSession;
  final UserProfileEntity userProfile;
  final bool enabledStealthMode;
  final bool hasActivedGuardian;
  final bool enabledAnonymousMode;

  AppStateEntity({
    @required this.enabledAnonymousMode,
    @required this.enabledStealthMode,
    @required this.hasActivedGuardian,
    @required this.quizSession,
    @required this.userProfile,
  });

  @override
  List<Object> get props => [
        quizSession,
        userProfile,
        enabledAnonymousMode,
        enabledStealthMode,
        hasActivedGuardian
      ];

  @override
  bool get stringify => true;
}

@immutable
class QuizSessionEntity extends Equatable {
  final List<QuizMessageEntity> currentMessage;
  final int sessionId;
  final bool isFinished;
  final String endScreen;

  QuizSessionEntity({
    @required this.currentMessage,
    @required this.sessionId,
    @required this.isFinished,
    @required this.endScreen,
  });

  @override
  List<Object> get props => [currentMessage, sessionId, isFinished, endScreen];

  @override
  String toString() {
    return "QuizSessionEntity{currentMessage: ${currentMessage.toString()}, sessionId: ${sessionId.toString()}, endScreen: ${endScreen.toString()}, isFinished: ${isFinished.toString()} }";
  }
}

@immutable
class QuizMessageEntity extends Equatable {
  final String content;
  final QuizMessageType type;
  final String ref;
  final String style;
  final String action;
  final String buttonLabel;
  final List<QuizMessageMultiplechoicesOptions> options;

  QuizMessageEntity({
    @required this.content,
    @required this.type,
    this.ref,
    this.style,
    this.action,
    this.options,
    this.buttonLabel,
  });

  @override
  List<Object> get props =>
      [content, style, action, type, ref, options, buttonLabel];

  @override
  String toString() {
    return "QuizMessageEntity{content: ${content.toString()}, type: ${type.toString()}, style: ${style.toString()}, action: ${action.toString()}, ref: ${ref.toString()}}, buttonLabel: ${buttonLabel.toString()}, options: ${options.toString()}";
  }
}

class QuizMessageMultiplechoicesOptions extends Equatable {
  final String display;
  final String index;

  QuizMessageMultiplechoicesOptions({
    @required this.display,
    @required this.index,
  });

  @override
  List<Object> get props => [display, index];

  @override
  String toString() {
    return "QuizMessageMultiplechoicesOptions{index: ${index.toString()}, display: ${display.toString()}}";
  }
}
