import 'package:flutter_modular/flutter_modular.dart';

import '../../core/managers/app_configuration.dart';
import '../../core/managers/local_store.dart';
import '../appstate/domain/entities/user_profile_entity.dart';
import '../appstate/domain/usecases/app_state_usecase.dart';
import 'splash_controller.dart';
import 'splash_page.dart';

class SplashModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory(
          (i) => SplashController(
            appConfiguration: i.get<IAppConfiguration>(),
            appStateUseCase: i.get<AppStateUseCase>(),
            userProfileStore: i.get<LocalStore<UserProfileEntity>>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, args) => const SplashPage()),
      ];
}
