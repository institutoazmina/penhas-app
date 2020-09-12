import 'package:flutter/material.dart';
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
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        print("AppLifecycleState.paused");
        break;
      case AppLifecycleState.resumed:
        print("AppLifecycleState.resumed");
        break;
      case AppLifecycleState.detached:
        print("AppLifecycleState.detached");
        break;
    }
  }
}
