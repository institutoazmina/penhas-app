import 'package:mobx/mobx.dart';

part 'feed_controller.g.dart';

class FeedController = _FeedControllerBase with _$FeedController;

abstract class _FeedControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
