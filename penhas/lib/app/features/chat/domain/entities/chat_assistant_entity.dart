import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';

class ChatAssistantEntity extends Equatable {
  final String title;
  final String subtitle;
  final String avatar;
  final QuizSessionEntity quizSession;

  ChatAssistantEntity({
    @required this.title,
    @required this.subtitle,
    @required this.avatar,
    @required this.quizSession,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        title,
        subtitle,
        avatar,
        quizSession,
      ];
}