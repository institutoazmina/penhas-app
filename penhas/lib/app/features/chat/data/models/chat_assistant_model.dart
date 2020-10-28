import 'package:meta/meta.dart';
import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_assistant_entity.dart';

class ChatAssistantModel extends ChatAssistantEntity {
  final String title;
  final String subtitle;
  final String avatar;
  final QuizSessionEntity quizSession;

  ChatAssistantModel({
    @required this.title,
    @required this.subtitle,
    @required this.avatar,
    @required this.quizSession,
  }) : super(
          title: title,
          subtitle: subtitle,
          avatar: avatar,
          quizSession: quizSession,
        );

  factory ChatAssistantModel.fromJson(Map<String, Object> jsonData) {
    final title = jsonData["title"];
    final subtitle = jsonData["subtitle"];
    final avatar = jsonData["avatar_url"];
    final appModel = AppStateModel.fromJson(jsonData);

    return ChatAssistantModel(
      title: title,
      subtitle: subtitle,
      avatar: avatar,
      quizSession: appModel.quizSession,
    );
  }
}
