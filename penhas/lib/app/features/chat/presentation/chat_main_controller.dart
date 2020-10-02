import 'package:mobx/mobx.dart';

part 'chat_main_controller.g.dart';

class ChatMainController extends _ChatMainControllerBase
    with _$ChatMainController {}

abstract class _ChatMainControllerBase with Store {}
