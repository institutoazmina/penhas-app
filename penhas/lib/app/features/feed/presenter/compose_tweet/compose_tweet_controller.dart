import 'package:mobx/mobx.dart';

part 'compose_tweet_controller.g.dart';

class ComposeTweetController = _ComposeTweetControllerBase
    with _$ComposeTweetController;

abstract class _ComposeTweetControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
