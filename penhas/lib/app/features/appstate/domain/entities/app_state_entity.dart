import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

enum QuizMessageType {
  from,
  button,
  yesno,
  displayText,
  multipleChoices,
}

extension QuizMessageTypeExtension on QuizMessageType {
  operator [](String key) {
    var type = QuizMessageType.displayText;
    switch (key.toLowerCase()) {
      case 'button':
        type = QuizMessageType.button;
        break;
      case 'yesno':
        type = QuizMessageType.yesno;
        break;
      case 'displaytext':
        type = QuizMessageType.displayText;
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

  AppStateEntity({
    @required this.quizSession,
  });

  @override
  List<Object> get props => [quizSession];
}

@immutable
class QuizSessionEntity extends Equatable {
  final List<QuizMessageEntity> currentMessage;
  final List<QuizMessageEntity> previousMessage;
  final int sessionId;

  QuizSessionEntity({
    @required this.currentMessage,
    @required this.previousMessage,
    @required this.sessionId,
  });

  @override
  List<Object> get props => [currentMessage, previousMessage, sessionId];
}

@immutable
class QuizMessageEntity extends Equatable {
  final String content;
  final QuizMessageType type;
  final String style;
  final String action;
  final String ref;

  QuizMessageEntity({
    @required this.content,
    @required this.type,
    this.ref,
    this.style,
    this.action,
  });

  @override
  List<Object> get props => [content, style, action, type, ref];
}
