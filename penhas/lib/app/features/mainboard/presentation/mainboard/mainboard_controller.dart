import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/core/managers/user_profile_store.dart';
import 'package:penhas/app/core/states/mainboard_store.dart';
import 'package:penhas/app/features/notification/data/repositories/notification_repository.dart';

part 'mainboard_controller.g.dart';

class MainboardController extends _MainboardControllerBase
    with _$MainboardController {
  MainboardController(
      {@required MainboardStore mainboardStore,
      @required IUserProfileStore userProfileStore,
      @required INotificationRepository notification,
      @required IAppModulesServices modulesServices})
      : super(
          mainboardStore,
          userProfileStore,
          notification,
          modulesServices,
        );
}

abstract class _MainboardControllerBase with Store {
  Timer _syncTimer;
  final int notificationInterval = 60;
  final MainboardStore mainboardStore;
  final IUserProfileStore _userProfileStore;
  final INotificationRepository _notification;
  final IAppModulesServices _modulesServices;

  _MainboardControllerBase(
    this.mainboardStore,
    this._userProfileStore,
    this._notification,
    this._modulesServices,
  ) {
    setup();
  }

  @observable
  int selectedIndex = 0;

  @observable
  int notificationCounter = 0;

  @action
  changeAppState(AppLifecycleState state) async {
    final profile = await _userProfileStore.retreive();

    switch (state) {
      case AppLifecycleState.paused:
        if (profile.stealthModeEnabled) {
          Modular.to.pushReplacementNamed('/authentication/stealth');
          return;
        }
        if (profile.anonymousModeEnabled) {
          Modular.to.pushReplacementNamed('/authentication/sign_in_stealth');
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.resumed:
      case AppLifecycleState.detached:
        break;
    }
  }
}

extension _PrivateMethod on _MainboardControllerBase {
  void setupUploadTimer() {
    if (_syncTimer != null) {
      return;
    }

    _syncTimer = Timer.periodic(
      Duration(seconds: notificationInterval),
      (timer) async {
        checkUnRead();
      },
    );
  }

  Future<void> setup() async {
    setupUploadTimer();
    checkUnRead();
  }

  Future<void> checkUnRead() async {
    final result = await _notification.unread();
    final validField = result.getOrElse(() => ValidField(message: "0"));
    notificationCounter = int.tryParse(validField.message) ?? 0;
  }
}
