import '../../../appstate/data/model/app_state_model.dart';
import '../../domain/entities/chat_assistant_entity.dart';

class ChatAssistantModel extends ChatAssistantEntity {
  const ChatAssistantModel({
    required super.title,
    required super.subtitle,
    required super.avatar,
    required super.quizSession,
  });

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
