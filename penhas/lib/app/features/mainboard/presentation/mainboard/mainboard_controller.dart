import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/states/mainboard_store.dart';

part 'mainboard_controller.g.dart';

class MainboardController extends _MainboardControllerBase
    with _$MainboardController {
  MainboardController({
    @required IAppConfiguration appConfigure,
    @required MainboardStore mainboardStore,
  }) : super(appConfigure, mainboardStore);
}

abstract class _MainboardControllerBase with Store {
  final IAppConfiguration _appConfigure;
  final MainboardStore mainboardStore;

  _MainboardControllerBase(this._appConfigure, this.mainboardStore);

  @observable
  int selectedIndex = 0;

  @action
  void logoutPressed() {
    _appConfigure.logout();
    Modular.to.pushReplacementNamed('/');
  }
}
