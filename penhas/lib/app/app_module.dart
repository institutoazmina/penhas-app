import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_module.dart';
import 'package:penhas/app/modules/splash/splash_controller.dart';
import 'package:penhas/app/modules/splash/splash_module.dart';

import 'app_controller.dart';
import 'app_widget.dart';

class AppModule extends MainModule {
  final Uri apiServer = Uri.https('elasv2-api.appcivico.com', '/');
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => SplashController()),
        Bind((i) => SignInModule()),
        Bind<IApiServerConfigure>(
          (i) => ApiServerConfigure(baseUri: apiServer),
        ),
        Bind<http.Client>((i) => http.Client()),
        Bind<INetworkInfo>((i) => NetworkInfo(i.get<DataConnectionChecker>())),
        Bind((i) => DataConnectionChecker()),
      ];

  @override
  List<Router> get routers => [
        Router('/', module: SplashModule()),
        Router('/authentication', module: SignInModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
