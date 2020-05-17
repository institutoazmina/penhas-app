import 'package:mobx/mobx.dart';

part 'quiz_controller.g.dart';

class QuizController = _QuizControllerBase with _$QuizController;

abstract class _QuizControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
