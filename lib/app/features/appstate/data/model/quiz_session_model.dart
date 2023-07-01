import '../../domain/entities/app_state_entity.dart';

class QuizSessionModel extends QuizSessionEntity {
  const QuizSessionModel({
    required String sessionId,
    List<QuizMessageEntity>? currentMessage,
    bool isFinished = false,
    String? endScreen,
  }) : super(
          currentMessage: currentMessage,
          sessionId: sessionId,
          isFinished: isFinished,
          endScreen: endScreen,
        );

  factory QuizSessionModel.fromJson(Map<String, dynamic> jsonData) {
    final currentMessage = jsonData['current_msgs'] ?? [];
    final previousMessage = jsonData['prev_msgs'] ?? [];
    final messages = _parseQuizMessage(previousMessage + currentMessage);

    final isFinished = jsonData['finished'] == 1;

    return QuizSessionModel(
      sessionId: "${jsonData['session_id']}",
      currentMessage: messages,
      endScreen: jsonData['end_screen'],
      isFinished: isFinished,
    );
  }

  static List<QuizMessageModel>? _parseQuizMessage(List<dynamic> data) {
    if (data.isEmpty) return null;

    return data
        .map((e) => e as Map<String, dynamic>)
        .expand((e) => _buildMessage(e))
        .toList();
  }

  static List<QuizMessageModel> _buildMessage(Map<String, dynamic> message) {
    if (message['display_response'] != null) {
      return _buildDisplayResponseMessage(message);
    }

    return [
      QuizMessageModel.fromJson(message),
    ];
  }

  static List<QuizMessageModel> _buildDisplayResponseMessage(
    Map<String, dynamic> message,
  ) {
    return [
      QuizMessageModel(
        content: message['content'],
        type: QuizMessageType.displayText,
        style: 'normal',
      ),
      QuizMessageModel(
        content: message['display_response'],
        type: QuizMessageType.displayTextResponse,
        style: 'normal',
      )
    ];
  }
}

class QuizMessageModel extends QuizMessageEntity {
  const QuizMessageModel({
    required String? content,
    required QuizMessageType type,
    String? ref,
    String? style,
    String? action,
    String? buttonLabel,
    List<QuizMessageMultiplechoicesOptions>? options,
  }) : super(
          content: content,
          type: type,
          ref: ref ?? '',
          style: style,
          action: action,
          buttonLabel: buttonLabel,
          options: options,
        );

  factory QuizMessageModel.fromJson(Map<String, dynamic> jsonData) {
    final QuizMessageType type = _parseMessageType(jsonData);
    final List<MultiplechoicesOptionModel>? options =
        _parseOptions(jsonData['options'] ?? []);

    return QuizMessageModel(
      content: jsonData['content'],
      type: type,
      ref: jsonData['ref'],
      style: jsonData['style'],
      action: jsonData['action'],
      buttonLabel: jsonData['label'],
      options: options,
    );
  }

  static QuizMessageType _parseMessageType(Map<String, dynamic> message) {
    switch (message['action']) {
      case 'botao_tela_modo_camuflado':
        return QuizMessageType.showStealthTutorial;
      case 'botao_tela_socorro':
        return QuizMessageType.showHelpTutorial;
      case 'reload':
        return QuizMessageType.forceReload;
      default:
        return QuizMessageType.values.byName(message['type'] as String);
    }
  }

  static List<MultiplechoicesOptionModel>? _parseOptions(List<dynamic> data) {
    if (data.isEmpty) return null;
    return data.map((e) => MultiplechoicesOptionModel.fromJson(e)).toList();
  }
}

class MultiplechoicesOptionModel extends QuizMessageMultiplechoicesOptions {
  const MultiplechoicesOptionModel({
    required String? display,
    required String? index,
  }) : super(display: display, index: index);

  factory MultiplechoicesOptionModel.fromJson(Map<String, dynamic> jsonData) {
    return MultiplechoicesOptionModel(
      display: jsonData['display'],
      index: '${jsonData['index']}',
    );
  }
}
