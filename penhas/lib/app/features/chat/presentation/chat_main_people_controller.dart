import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';

part 'chat_main_people_controller.g.dart';

class ChatMainPeopleController extends _ChatMainPeopleControllerBase
    with _$ChatMainPeopleController {
  ChatMainPeopleController();
}

abstract class _ChatMainPeopleControllerBase with Store, MapFailureMessage {}
