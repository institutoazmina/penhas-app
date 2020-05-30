import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:meta/meta.dart';

part 'mainboard_controller.g.dart';

class MainboardController extends _MainboardControllerBase
    with _$MainboardController {
  MainboardController({@required IAppConfiguration appConfigure})
      : super(appConfigure);
}

abstract class _MainboardControllerBase with Store {
  final IAppConfiguration _appConfigure;

  _MainboardControllerBase(this._appConfigure);

  var pageController = PageController();

  @observable
  int selectedIndex = 0;

  @action
  void logoutPressed() {
    _appConfigure.logout();
    Modular.to.pushReplacementNamed('/');
  }

  @action
  void changePage(int index) {
    pageController.jumpToPage(index);
    selectedIndex = index;
  }
}
