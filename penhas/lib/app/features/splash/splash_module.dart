import 'package:http/http.dart' as http;
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/managers/user_profile_store.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/appstate/data/datasources/app_state_data_source.dart';
import 'package:penhas/app/features/appstate/data/repositories/app_state_repository.dart';
import 'package:penhas/app/features/appstate/domain/repositories/i_app_state_repository.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:penhas/app/features/splash/splash_controller.dart';
import 'package:penhas/app/features/splash/splash_page.dart';

class SplashModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => SplashController(
            appConfiguration: i.get<IAppConfiguration>(),
            appStateUseCase: i.get<AppStateUseCase>(),
          ),
        ),
        Bind<AppStateUseCase>(
          (i) => AppStateUseCase(
            appStateRepository: i.get<IAppStateRepository>(),
            userProfileStore: i.get<IUserProfileStore>(),
          ),
        ),
        Bind<IAppStateRepository>(
          (i) => AppStateRepository(
            networkInfo: i.get<INetworkInfo>(),
            dataSource: i.get<IAppStateDataSource>(),
          ),
        ),
        Bind<IAppStateDataSource>(
          (i) => AppStateDataSource(
            apliClient: i.get<http.Client>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
        ),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => SplashPage()),
      ];

  static Inject get to => Inject<SplashModule>.of();
}
