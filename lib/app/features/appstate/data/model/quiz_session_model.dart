import '../../domain/entities/app_state_entity.dart';

class QuizSessionModel extends QuizSessionEntity {
  const QuizSessionModel({
    required super.sessionId,
    super.currentMessage,
    super.isFinished,
    super.endScreen,
  });

  factory QuizSessionModel.fromJson(Map<String, dynamic> jsonData) {
    final currentMessage = jsonData['current_msgs'] ?? [];
    final previousMessage = jsonData['prev_msgs'] ?? [];
    final messages = _parseQuizMessage(previousMessage + currentMessage);

    final isFinished = jsonData['finished'] == 1;

    return QuizSessionModel(
      sessionId: "${jsonData['session_id'] ?? ''}",
      currentMessage: messages,
      endScreen: jsonData['end_screen'],
      isFinished: isFinished,
    );
  }

  static List<QuizMessageModel> _parseQuizMessage(List<dynamic> data) {
    if (data.isEmpty) return [];

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

  Map<String, Object?> toJson() => {
        'session_id': sessionId,
        'current_msgs': currentMessage
            .whereType<QuizMessageModel>()
            .map((e) => e.toJson())
            .toList(),
        'finished': isFinished ? 1 : 0,
        'end_screen': endScreen,
      };
}

class QuizMessageModel extends QuizMessageEntity {
  const QuizMessageModel({
    required super.content,
    required super.type,
    String? ref,
    super.style,
    super.action,
    super.buttonLabel,
    super.options,
  }) : super(
          ref: ref ?? '',
        );

  factory QuizMessageModel.fromJson(Map<String, dynamic> jsonData) {
    final QuizMessageType type = _parseMessageType(jsonData);
    final List<QuizMessageChoiceOptionModel>? options =
        _parseOptions(jsonData['type'], jsonData['options'] ?? []);

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

  static List<QuizMessageChoiceOptionModel>? _parseOptions(
    String rawType,
    List<dynamic> data,
  ) {
    if (rawType == 'yesnomaybe') {
      return const [
        QuizMessageChoiceOptionModel(index: 'Y', display: 'Sim'),
        QuizMessageChoiceOptionModel(index: 'N', display: 'Não'),
        QuizMessageChoiceOptionModel(index: 'M', display: 'Talvez'),
      ];
    }

    if (data.isEmpty) return null;
    return data.map((e) => QuizMessageChoiceOptionModel.fromJson(e)).toList();
  }

  Map<String, Object?> toJson() => {
        'content': content,
        'type': type.name,
        'ref': ref,
        'style': style,
        'action': action,
        'label': buttonLabel,
        'options': options
            ?.whereType<QuizMessageChoiceOptionModel>()
            .map((e) => e.toJson())
            .toList(),
      };
}

class QuizMessageChoiceOptionModel extends QuizMessageChoiceOption {
  const QuizMessageChoiceOptionModel({
    required super.display,
    required super.index,
  });

  factory QuizMessageChoiceOptionModel.fromJson(Map<String, dynamic> jsonData) {
    return QuizMessageChoiceOptionModel(
      display: jsonData['display'],
      index: '${jsonData['index']}',
    );
  }

  Map<String, Object?> toJson() => {
        'display': display,
        'index': index,
      };
}
