import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/managers/local_store.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:penhas/app/features/splash/splash_controller.dart';
import 'package:penhas/app/features/splash/splash_page.dart';

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
        ChildRoute(Modular.initialRoute, child: (_, args) => SplashPage()),
      ];
}
