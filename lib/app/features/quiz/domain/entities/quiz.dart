import 'package:equatable/equatable.dart';

import 'quiz_message.dart';

class Quiz extends Equatable {
  const Quiz({
    required this.id,
    required this.messages,
    this.redirectTo,
  });

  final String id;
  final List<QuizMessage> messages;
  final String? redirectTo;
  bool get isFinished => redirectTo != null;

  @override
  List<Object?> get props => [id, messages, redirectTo, isFinished];
}
