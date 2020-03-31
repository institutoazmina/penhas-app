import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_widget.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router(
          '/',
          child: (_, args) => Scaffold(
            appBar: AppBar(
              title: Text("Penhas"),
              elevation: 1,
            ),
          ),
        ),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
