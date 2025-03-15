import '../../../appstate/data/model/quiz_session_model.dart';
import '../../domain/entity/button.dart';

class ButtonModel extends ButtonEntity {
  const ButtonModel({
    required super.label,
    required super.route,
    super.arguments,
  });

  factory ButtonModel.fromJson(Map<String, dynamic> json) => ButtonModel(
        label: json['label'] as String,
        route: json['route'] as String,
        arguments: _parseArguments(json['route'], json['arguments']),
      );

  static dynamic _parseArguments(String route, dynamic arguments) {
    if (route == '/quiz') {
      return QuizSessionModel.fromJson(arguments);
    }
    if (arguments != null) {
      throw UnsupportedError(
        'Arguments "$arguments" for "$route" are not supported',
      );
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
        'label': label,
        'route': route,
        'arguments': arguments,
      };
}
