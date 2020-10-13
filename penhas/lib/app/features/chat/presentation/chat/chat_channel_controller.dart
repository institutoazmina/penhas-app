import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';

part 'chat_channel_controller.g.dart';

class ChatChannelController extends _ChatChannelControllerBase
    with _$ChatChannelController {
  ChatChannelController();
}

abstract class _ChatChannelControllerBase with Store, MapFailureMessage {
  @action
  void blockChat() {}

  @action
  void deleteSession() {}
}
