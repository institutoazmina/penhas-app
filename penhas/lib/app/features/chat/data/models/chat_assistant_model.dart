import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_assistant_entity.dart';

class ChatAssistantModel extends ChatAssistantEntity {
  final String? title;
  final String? subtitle;
  final String? avatar;
  final QuizSessionEntity? quizSession;

  ChatAssistantModel({
    required this.title,
    required this.subtitle,
    required this.avatar,
    required this.quizSession,
  }) : super(
          title: title,
          subtitle: subtitle,
          avatar: avatar,
          quizSession: quizSession,
        );

  factory ChatAssistantModel.fromJson(Map<String, dynamic> jsonData) {
    final appModel = AppStateModel.fromJson(jsonData);

    return ChatAssistantModel(
      title: title as String?,
      subtitle: subtitle as String?,
      avatar: avatar as String?,
      quizSession: appModel.quizSession,
    );
  }
}
