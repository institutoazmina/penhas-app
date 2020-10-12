import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/chat/domain/repositories/chat_channel_repository.dart';
import 'package:penhas/app/features/chat/domain/usecases/chat_toggle_feature.dart';
import 'package:penhas/app/features/chat/presentation/chat_main_controller.dart';
import 'package:penhas/app/features/chat/presentation/chat_main_page.dart';
import 'package:penhas/app/features/users/data/repositories/users_repository.dart';
import 'package:penhas/app/features/users/domain/presentation/user_profile_module.dart';

import 'chat_main_people_controller.dart';
import 'chat_main_talks_controller.dart';

class ChatMainModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => ChatMainController(
            chatToggleFeature: i.get<ChatToggleFeature>(),
          ),
        ),
        Bind<ChatToggleFeature>(
          (i) => ChatToggleFeature(
            modulesServices: i.get<IAppModulesServices>(),
          ),
        ),
        Bind(
          (i) => ChatMainTalksController(
            chatChannelRepository: i.get<IChatChannelRepository>(),
          ),
        ),
        Bind((i) => ChatMainPeopleController(
            usersRepository: i.get<IUsersRepository>())),
        Bind<IUsersRepository>((i) => UsersRepository(
              apiProvider: i.get<IApiProvider>(),
            )),
        Bind<IChatChannelRepository>(
          (i) => ChatChannelRepository(
            apiProvider: i.get<IApiProvider>(),
          ),
        ),
      ];

  @override
  Widget get view => ChatMainPage();

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/users', module: UserProfileModule()),
      ];

  static Inject get to => Inject<ChatMainModule>.of();
}
