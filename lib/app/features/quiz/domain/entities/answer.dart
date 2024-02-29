import 'package:equatable/equatable.dart';

import 'quiz_message.dart';

enum AnswerStatus { sending, sent, failed }

class UserAnswer extends Equatable {
  const UserAnswer({
    required this.value,
    required this.message,
  });

  final AnswerValue value;
  final QuizMessage message;

  String get reference => message.reference;

  @override
  List<Object?> get props => [value, message];
}

class AnswerValue extends Equatable {
  const AnswerValue(
    this.raw, {
    String? readable,
  }) : readable = readable ?? raw;

  final String raw;
  final String readable;

  @override
  List<Object?> get props => [raw, readable];
}
