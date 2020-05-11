import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class AppStateEntity {
  final QuizSessionEntity quizSession;

  AppStateEntity({
    @required this.quizSession,
  });
}

@immutable
class QuizSessionEntity {
  final List<QuizMessageEntity> currentMessage;
  final List<QuizMessageEntity> previousMessage;
  final int sessionId;

  QuizSessionEntity({
    @required this.currentMessage,
    @required this.previousMessage,
    @required this.sessionId,
  });
}

enum QuizMessageType {
  displaytext,
  button,
  yesno,
  multiplechoices,
}

@immutable
class QuizMessageEntity extends Equatable {
  final String content;
  final String style;
  final String action;
  final QuizMessageType type;
  final String ref;

  QuizMessageEntity({
    @required this.content,
    @required this.style,
    @required this.action,
    @required this.type,
    @required this.ref,
  });

  @override
  List<Object> get props => [content, style, action, type, ref];
}
