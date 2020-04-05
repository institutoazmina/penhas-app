import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/modules/authentication/authentication_module.dart';
import 'package:penhas/app/modules/splash/splash_controller.dart';
import 'package:penhas/app/modules/splash/splash_module.dart';

import 'app_controller.dart';
import 'app_widget.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => SplashController()),
        Bind((i) => AuthenticationModule()),
      ];

  // final controller = AppController();

  @override
  List<Router> get routers => [
        // Router(Modular.initialRoute, child: (_, args) => SolliPage()),
        Router('/', module: SplashModule()),
        Router('/authentication', module: AuthenticationModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();

  // Widget _buildAppBar() {
  //   return AppBar(
  //     elevation: 0,
  //     title: Row(
  //       children: <Widget>[Icon(DesignSystemLogo.penhasLogo)],
  //     ),
  //     leading: GestureDetector(
  //       onTap: controller.onMenuAction,
  //       child: Icon(Icons.menu),
  //     ),
  //     actions: <Widget>[
  //       Padding(
  //         padding: EdgeInsets.only(right: 20.0),
  //         child: GestureDetector(
  //           onTap: controller.onSearchAction,
  //           child: Icon(
  //             Icons.search,
  //             size: 26.0,
  //           ),
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(right: 20.0),
  //         child: GestureDetector(
  //           onTap: controller.onNotificationAction,
  //           child: Icon(
  //             Icons.notifications,
  //             size: 26.0,
  //           ),
  //         ),
  //       )
  //     ],
  //     backgroundColor: DesignSystemColors.LigthPurple,
  //   );
  // }
}
