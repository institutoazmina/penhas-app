import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/chat/domain/repositories/chat_channel_repository.dart';
import 'package:penhas/app/features/chat/domain/usecases/chat_channel_usecase.dart';
import 'package:penhas/app/features/chat/domain/usecases/chat_toggle_feature.dart';
import 'package:penhas/app/features/chat/presentation/chat/chat_channel_controller.dart';
import 'package:penhas/app/features/filters/domain/repositories/filter_skill_repository.dart';
import 'package:penhas/app/features/users/data/repositories/users_repository.dart';

import 'chat_main_controller.dart';
import 'chat_main_page.dart';
import 'people/chat_main_people_controller.dart';
import 'talk/chat_main_talks_controller.dart';

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
        Bind(
          (i) => ChatMainPeopleController(
            usersRepository: i.get<IUsersRepository>(),
            skillRepository: i.get<IFilterSkillRepository>(),
          ),
        ),
        Bind<IUsersRepository>(
          (i) => UsersRepository(
            apiProvider: i.get<IApiProvider>(),
          ),
        ),
        Bind<IChatChannelRepository>(
          (i) => ChatChannelRepository(
            apiProvider: i.get<IApiProvider>(),
          ),
        ),
        Bind<IFilterSkillRepository>(
          (i) => FilterSkillRepository(
            apiProvider: i.get<IApiProvider>(),
          ),
        ),
        Bind(
          (i) => ChatChannelController(
            useCase: i.get<ChatChannelUseCase>(),
          ),
          singleton: false,
        ),
        Bind<ChatChannelUseCase>(
          (i) => ChatChannelUseCase(
            session: i.args.data,
            channelRepository: i.get<IChatChannelRepository>(),
          ),
          singleton: false,
        )
      ];

  @override
  Widget get view => ChatMainPage();

  static Inject get to => Inject<ChatMainModule>.of();
}
