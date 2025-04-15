import '../../../appstate/domain/entities/app_state_entity.dart';

class QuizPageArgs {
  QuizPageArgs({
    required this.origin,
    required this.session,
  });
  final String origin;
  final QuizSessionEntity session;
}
