import 'package:flutter_modular/flutter_modular.dart';

import '../../chat/domain/usecases/get_chat_channel_token_usecase.dart';
import '../../feed/domain/usecases/feed_use_cases.dart';
import '../data/repositories/users_repository.dart';
import '../domain/usecases/block_user_usecase.dart';
import '../domain/usecases/report_user_usecase.dart';
import 'user_profile_controller.dart';
import 'user_profile_page.dart';

class UserProfileModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory(
          (i) => UserProfileController(
            person: i.args.data,
            getChatChannelToken: i.get<GetChatChannelTokenUseCase>(),
            reportUser: i.get<ReportUserUseCase>(),
            blockUser: i.get<BlockUserUseCase>(),
          ),
        ),
        Bind.factory(
          (i) => ReportUserUseCase(repository: i.get<IUsersRepository>()),
        ),
        Bind.factory(
          (i) => BlockUserUseCase(
            repository: i.get<IUsersRepository>(),
            feedUseCases: i.get<FeedUseCases>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/profile',
          child: (_, args) => UserProfilePage(
            controller: Modular.get<UserProfileController>(),
          ),
        ),
        ChildRoute(
          '/profile_from_feed',
          child: (_, args) => UserProfilePage(
            controller: Modular.get<UserProfileController>(),
          ),
          transition: TransitionType.noTransition,
        ),
      ];
}
