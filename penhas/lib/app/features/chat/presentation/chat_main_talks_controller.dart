import 'package:mobx/mobx.dart';

part 'chat_main_talks_controller.g.dart';

class ChatMainTalksController extends _ChatMainTalksControllerBase
    with _$ChatMainTalksController {
  ChatMainTalksController();
}

abstract class _ChatMainTalksControllerBase with Store {}
