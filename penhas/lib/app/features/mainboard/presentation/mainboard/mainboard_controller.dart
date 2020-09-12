import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/managers/user_profile_store.dart';
import 'package:penhas/app/core/states/mainboard_store.dart';

part 'mainboard_controller.g.dart';

class MainboardController extends _MainboardControllerBase
    with _$MainboardController {
  MainboardController({
    @required MainboardStore mainboardStore,
    @required IUserProfileStore userProfileStore,
  }) : super(mainboardStore, userProfileStore);
}

abstract class _MainboardControllerBase with Store {
  final MainboardStore mainboardStore;
  final IUserProfileStore _userProfileStore;

  _MainboardControllerBase(
    this.mainboardStore,
    this._userProfileStore,
  );

  @observable
  int selectedIndex = 0;

  @action
  changeAppState(AppLifecycleState state) async {
    final profile = await _userProfileStore.retreive();

    switch (state) {
      case AppLifecycleState.paused:
        if (profile.anonymousModeEnabled) {
          Modular.to.pushReplacementNamed('/authentication/sign_in_anonymous');
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.resumed:
      case AppLifecycleState.detached:
        break;
    }
  }
}
