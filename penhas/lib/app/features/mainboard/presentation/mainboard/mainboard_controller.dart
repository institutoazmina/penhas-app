import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/states/mainboard_store.dart';

part 'mainboard_controller.g.dart';

class MainboardController extends _MainboardControllerBase
    with _$MainboardController {
  MainboardController({@required MainboardStore mainboardStore})
      : super(mainboardStore);
}

abstract class _MainboardControllerBase with Store {
  final MainboardStore mainboardStore;

  _MainboardControllerBase(
    this.mainboardStore,
  );

  @observable
  int selectedIndex = 0;

  @action
  void changeAppState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        Modular.to.pushReplacementNamed('/authentication/sign_in_anonymous');
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.resumed:
      case AppLifecycleState.detached:
        break;
    }
  }
}
