import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_module.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/mainboard_module.dart';
import 'package:penhas/app/features/splash/splash_controller.dart';
import 'package:penhas/app/features/splash/splash_module.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'core/storage/local_storage_shared_preferences.dart';

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
          (i) => NetworkInfo(i.get<DataConnectionChecker>()),
        ),
        Bind((i) => DataConnectionChecker()),
        Bind<IAppConfiguration>(
          (i) => AppConfiguration(storage: i.get<ILocalStorage>()),
        ),
        Bind<ILocalStorage>((i) => LocalStorageSharedPreferences()),
      ];

  @override
  List<Router> get routers => [
        Router('/', module: SplashModule()),
        Router('/authentication', module: SignInModule()),
        Router('/mainboard', module: MainboardModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
