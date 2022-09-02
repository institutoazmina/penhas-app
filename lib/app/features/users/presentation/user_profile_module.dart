import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/chat/domain/repositories/chat_channel_repository.dart';
import 'package:penhas/app/features/users/presentation/user_profile_controller.dart';
import 'package:penhas/app/features/users/presentation/user_profile_page.dart';

class UserProfileModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory(
          (i) => UserProfileController(
            channelRepository: i.get<IChatChannelRepository>(),
            person: i.args?.data,
          ),
        ),
        Bind.factory<IChatChannelRepository>(
          (i) => ChatChannelRepository(
            apiProvider: i.get<IApiProvider>(),
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
