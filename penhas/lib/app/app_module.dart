import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/managers/app_preferences_store.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/features/appstate/data/datasources/app_state_data_source.dart';
import 'package:penhas/app/features/appstate/data/repositories/app_state_repository.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/appstate/domain/repositories/i_app_state_repository.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_module.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/mainboard_module.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_module.dart';
import 'package:penhas/app/features/splash/splash_module.dart';

import 'app_controller.dart';
import 'core/managers/audio_sync_manager.dart';
import 'core/managers/local_store.dart';
import 'core/managers/modules_sevices.dart';
import 'core/managers/user_profile_store.dart';
import 'core/network/api_client.dart';
import 'core/storage/local_storage_shared_preferences.dart';
import 'features/appstate/domain/entities/app_preferences_entity.dart';
import 'features/authentication/presentation/deleted_account/deleted_account_controller.dart';
import 'features/authentication/presentation/deleted_account/deleted_account_page.dart';
import 'features/help_center/data/repositories/audio_sync_repository.dart';
import 'features/main_menu/domain/repositories/user_profile_repository.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory<AppStateUseCase>(
          (i) => AppStateUseCase(
              appStateRepository: i(),
              userProfileStore: i(),
              appConfiguration: i(),
              appModulesServices: i(),
          ),
        ),
        Bind.factory<IAppStateRepository>(
          (i) => AppStateRepository(
            networkInfo: i.get<INetworkInfo>(),
            dataSource: i.get<IAppStateDataSource>(),
          ),
        ),
        Bind.factory<IAppStateDataSource>(
          (i) => AppStateDataSource(
            apiClient: i.get<http.Client>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
        ),
        Bind.factory((i) => AppController()),
        Bind.factory<IApiServerConfigure>(
          (i) => ApiServerConfigure(
            appConfiguration: i.get<IAppConfiguration>(),
          ),
        ),
        Bind.factory<http.Client>((i) => http.Client()),
        Bind.factory<INetworkInfo>(
          (i) => NetworkInfo(
            i.get<DataConnectionChecker>(),
          ),
        ),
        Bind.factory<IApiProvider>(
          (i) => ApiProvider(
            serverConfiguration: i.get<IApiServerConfigure>(),
            networkInfo: i.get<INetworkInfo>(),
          ),
        ),
        Bind.factory((i) => DataConnectionChecker()),
        Bind.factory<IUserProfileRepository>(
          (i) => UserProfileRepository(
            apiProvider: i.get<IApiProvider>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
        ),
        Bind.factory((i) => DeletedAccountController(
              profileRepository: i.get<IUserProfileRepository>(),
              appConfiguration: i.get<IAppConfiguration>(),
              sessionToken: i.args?.data,
            ),),
        Bind.factory<IAppConfiguration>(
          (i) => AppConfiguration(
            storage: i.get<ILocalStorage>(),
          ),
        ),
        Bind.factory<LocalStore<UserProfileEntity>>(
          (i) => UserProfileStore(
            storage: i.get<ILocalStorage>(),
          ),
        ),
        Bind.factory<LocalStore<AppPreferencesEntity>>(
          (i) => AppPreferencesStore(
            storage: i.get<ILocalStorage>(),
          ),
        ),
        Bind.factory<IAppModulesServices>(
          (i) => AppModulesServices(
            storage: i.get<ILocalStorage>(),
          ),
        ),
        Bind.factory<ILocalStorage>((i) => LocalStorageSharedPreferences()),
        Bind.singleton<IAudioSyncManager>(
          (i) => AudioSyncManager(
            audioRepository: i.get<IAudioSyncRepository>(),
          ),
        ),
        Bind.factory<IAudioSyncRepository>(
          (i) => AudioSyncRepository(
            apiProvider: i.get<IApiProvider>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: SplashModule()),
        ModuleRoute('/authentication', module: SignInModule()),
        ModuleRoute('/mainboard', module: MainboardModule()),
        ModuleRoute('/quiz', module: QuizModule()),
        ChildRoute(
          '/accountDeleted',
          child: (context, args) => DeletedAccountPage(),
          transition: TransitionType.rightToLeft,
        )
      ];
}
