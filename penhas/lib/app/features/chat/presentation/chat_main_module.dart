import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/chat/domain/repositories/chat_channel_repository.dart';
import 'package:penhas/app/features/chat/domain/usecases/chat_toggle_feature.dart';
import 'package:penhas/app/features/chat/presentation/chat_main_controller.dart';
import 'package:penhas/app/features/chat/presentation/chat_main_page.dart';
import 'package:penhas/app/features/chat/presentation/people/chat_main_people_controller.dart';
import 'package:penhas/app/features/chat/presentation/talk/chat_main_talks_controller.dart';
import 'package:penhas/app/features/filters/domain/repositories/filter_skill_repository.dart';
import 'package:penhas/app/features/users/data/repositories/users_repository.dart';

class ChatMainModule extends WidgetModule {
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
        Bind.factory(
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
<<<<<<< HEAD
      ];

  @override
  Widget get view => const ChatMainPage();
=======
        Bind(
          (i) => ChatChannelController(
            useCase: i.get<ChatChannelUseCase>(),
          ),
                  ),
        Bind<ChatChannelUseCase>(
          (i) => ChatChannelUseCase(
            session: i.args.data,
            channelRepository: i.get<IChatChannelRepository>(),
          ),
                  )
      ];

  @override
  Widget get view => ChatMainPage();
>>>>>>> Fix code syntax
}
