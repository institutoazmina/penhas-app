import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/chat/domain/repositories/chat_channel_repository.dart';
import 'package:penhas/app/features/users/domain/presentation/user_profile_controller.dart';
import 'package:penhas/app/features/users/domain/presentation/user_profile_page.dart';

class UserProfileModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => UserProfileController(
            channelRepository: i.get<IChatChannelRepository>(),
            person: i.args.data,
          ),
        ),
        Bind<IChatChannelRepository>(
          (i) => ChatChannelRepository(
            apiProvider: i.get<IApiProvider>(),
          ),
        ),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/profile', child: (_, args) => UserProfilePage()),
      ];

  static Inject get to => Inject<UserProfileModule>.of();
}
