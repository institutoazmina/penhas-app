import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'chat_main_controller.dart';
import 'chat_main_page.dart';
import 'people/chat_main_people_controller.dart';
import 'talk/chat_main_talks_controller.dart';

class ChatMainModule extends WidgetModule {
  ChatMainModule({Key? key}) : super(key: key);

  @override
  List<Bind> get binds => [];

  @override
  Widget get view => ChatMainPage(
        controller: Modular.get<ChatMainController>(),
        chatMainTalksController: Modular.get<ChatMainTalksController>(),
        chatMainPeopleController: Modular.get<ChatMainPeopleController>(),
      );
}
