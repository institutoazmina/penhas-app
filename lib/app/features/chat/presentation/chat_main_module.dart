import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/managers/modules_sevices.dart';
import '../../../core/network/api_client.dart';
import '../../filters/data/repositories/filter_skill_repository.dart';
import '../../users/data/repositories/users_repository.dart';
import '../domain/repositories/chat_channel_repository.dart';
import '../domain/usecases/chat_toggle_feature.dart';
import 'chat_main_controller.dart';
import 'chat_main_page.dart';
import 'people/chat_main_people_controller.dart';
import 'talk/chat_main_talks_controller.dart';

class ChatMainModule extends WidgetModule {
  ChatMainModule({Key? key}) : super(key: key);

  @override
  List<Bind> get binds => [
        Bind.factory(
          (i) => ChatMainController(
            chatToggleFeature: i.get<ChatPrivateToggleFeature>(),
          ),
        ),
        Bind.factory<ChatPrivateToggleFeature>(
          (i) => ChatPrivateToggleFeature(
            modulesServices: i.get<IAppModulesServices>(),
          ),
        ),
        Bind.factory<ChatMainTalksController>(
          (i) => ChatMainTalksController(
            chatChannelRepository: i.get<IChatChannelRepository>(),
          ),
        ),
        Bind.factory(
          (i) => ChatMainPeopleController(
            usersRepository: i.get<IUsersRepository>(),
            skillRepository: i.get<IFilterSkillRepository>(),
          ),
        ),
        Bind.factory<IUsersRepository>(
          (i) => UsersRepository(
            apiProvider: i.get<IApiProvider>(),
          ),
        ),
        Bind.factory<IChatChannelRepository>(
          (i) => ChatChannelRepository(
            apiProvider: i.get<IApiProvider>(),
          ),
        ),
      ];

  @override
  Widget get view => ChatMainPage(
        chatMainPeopleController: Modular.get<ChatMainPeopleController>(),
        controller: Modular.get<ChatMainController>(),
        chatMainTalksController: Modular.get<ChatMainTalksController>(),
      );
}
