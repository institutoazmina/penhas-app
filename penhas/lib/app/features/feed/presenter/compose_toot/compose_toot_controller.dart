import 'package:mobx/mobx.dart';

part 'compose_toot_controller.g.dart';

class ComposeTootController = _ComposeTootControllerBase
    with _$ComposeTootController;

abstract class _ComposeTootControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
