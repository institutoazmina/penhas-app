import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/design_system/colors.dart';
import 'package:penhas/app/design_system/logo.dart';

import 'app_controller.dart';
import 'app_widget.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [];

  final controller = AppController();

  @override
  List<Router> get routers => [
        Router(
          '/',
          child: (_, args) => Scaffold(
            appBar: _buildAppBar(),
            body: Center(
              child: Container(
                child: Icon(Icons.open_in_browser, size: 200),
              ),
            ),
          ),
        ),
      ];

  @override
  Widget get bootstrap => AppWidget();

  Widget _buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Row(
        children: <Widget>[Icon(DesignSystemLogo.penhasLogo)],
      ),
      leading: GestureDetector(
        onTap: controller.onMenuAction,
        child: Icon(Icons.menu),
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: controller.onSearchAction,
            child: Icon(
              Icons.search,
              size: 26.0,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: controller.onNotificationAction,
            child: Icon(
              Icons.notifications,
              size: 26.0,
            ),
          ),
        )
      ],
      backgroundColor: DesignSystemColors.LigthPurple,
    );
  }
}
