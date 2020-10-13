import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';

part 'chat_controller.g.dart';

class ChatController extends _ChatControllerBase with _$ChatController {
  ChatController();
}

abstract class _ChatControllerBase with Store, MapFailureMessage {
  @action
  void blockChat() {}

  @action
  void deleteSession() {}
}
