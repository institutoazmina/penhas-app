import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_module.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/mainboard_module.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_module.dart';
import 'package:penhas/app/features/splash/splash_module.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'core/managers/audio_sync_manager.dart';
import 'core/managers/local_store.dart';
import 'core/managers/modules_sevices.dart';
import 'core/managers/user_profile_store.dart';
import 'core/network/api_client.dart';
import 'core/storage/local_storage_shared_preferences.dart';
import 'features/authentication/presentation/deleted_account/deleted_account_controller.dart';
import 'features/authentication/presentation/deleted_account/deleted_account_page.dart';
import 'features/help_center/data/repositories/audio_sync_repository.dart';
import 'features/main_menu/domain/repositories/user_profile_repository.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => SignInModule()),
        Bind<IApiServerConfigure>(
          (i) => ApiServerConfigure(
            appConfiguration: i.get<IAppConfiguration>(),
          ),
        ),
        Bind<http.Client>((i) => http.Client()),
        Bind<INetworkInfo>(
          (i) => NetworkInfo(
            i.get<DataConnectionChecker>(),
          ),
        ),
        Bind<IApiProvider>(
          (i) => ApiProvider(
            serverConfiguration: i.get<IApiServerConfigure>(),
            networkInfo: i.get<INetworkInfo>(),
          ),
          singleton: false,
        ),
        Bind((i) => DataConnectionChecker()),
        Bind<IUserProfileRepository>(
          (i) => UserProfileRepository(
            apiProvider: i.get<IApiProvider>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
        ),
        Bind((i) => DeletedAccountController(
              profileRepository: i.get<IUserProfileRepository>(),
              appConfiguration: i.get<IAppConfiguration>(),
              sessionToken: i.args.data,
            )),
        Bind<IAppConfiguration>(
          (i) => AppConfiguration(
            storage: i.get<ILocalStorage>(),
          ),
        ),
        Bind<LocalStore<UserProfileEntity>>(
          (i) => UserProfileStore(
            storage: i.get<ILocalStorage>(),
          ),
        ),
        Bind<IAppModulesServices>(
          (i) => AppModulesServices(
            storage: i.get<ILocalStorage>(),
          ),
        ),
        Bind<ILocalStorage>((i) => LocalStorageSharedPreferences()),
        Bind<IAudioSyncManager>(
          (i) => AudioSyncManager(
            audioRepository: i.get<IAudioSyncRepository>(),
          ),
          singleton: true,
          lazy: false,
        ),
        Bind<IAudioSyncRepository>(
          (i) => AudioSyncRepository(
            apiProvider: i.get<IApiProvider>(),
          ),
          singleton: false,
        ),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', module: SplashModule()),
        ModularRouter('/authentication', module: SignInModule()),
        ModularRouter('/mainboard', module: MainboardModule()),
        ModularRouter('/quiz', module: QuizModule()),
        ModularRouter(
          '/accountDeleted',
          child: (context, args) => DeletedAccountPage(),
          transition: TransitionType.rightToLeft,
        )
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
