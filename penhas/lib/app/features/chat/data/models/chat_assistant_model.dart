import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_assistant_entity.dart';

class ChatAssistantModel extends ChatAssistantEntity {
  const ChatAssistantModel({
    required String? title,
    required String? subtitle,
    required String? avatar,
    required QuizSessionEntity? quizSession,
  }) : super(
          title: title,
          subtitle: subtitle,
          avatar: avatar,
          quizSession: quizSession,
        );

  factory ChatAssistantModel.fromJson(Map<String, dynamic> jsonData) {
    final appModel = AppStateModel.fromJson(jsonData);

    return ChatAssistantModel(
      title: jsonData['title'],
      subtitle: jsonData['subtitle'],
      avatar: jsonData['avatar_url'],
      quizSession: appModel.quizSession,
    );
  }
}
