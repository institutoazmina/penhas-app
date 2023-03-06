import 'package:flutter_modular/flutter_modular.dart';

import '../domain/usecases/block_user_usecase.dart';
import '../domain/usecases/report_user_usecase.dart';
import 'user_profile_controller.dart';
import 'user_profile_page.dart';

class UserProfileModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory(
          (i) => UserProfileController(
            person: i.args?.data,
            getChatChannelToken: i(),
            reportUser: i(),
            blockUser: i(),
          ),
        ),
        Bind.factory(
          (i) => ReportUserUseCase(repository: i()),
        ),
        Bind.factory(
          (i) => BlockUserUseCase(
            repository: i(),
            feedUseCases: i(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/profile', child: (_, args) => const UserProfilePage()),
        ChildRoute(
          '/profile_from_feed',
          child: (_, args) => const UserProfilePage(),
          transition: TransitionType.noTransition,
        ),
      ];
}
