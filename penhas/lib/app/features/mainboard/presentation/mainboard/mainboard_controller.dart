import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/core/managers/user_profile_store.dart';
import 'package:penhas/app/features/help_center/domain/usecases/security_mode_action_feature.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_security_state.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_store.dart';
import 'package:penhas/app/features/notification/data/repositories/notification_repository.dart';

part 'mainboard_controller.g.dart';

class MainboardController extends _MainboardControllerBase
    with _$MainboardController {
  MainboardController({
    @required MainboardStore mainboardStore,
    @required IUserProfileStore userProfileStore,
    @required INotificationRepository notification,
    @required IAppModulesServices modulesServices,
  }) : super(
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

  @observable
  MainboardSecurityState securityState = MainboardSecurityState.disable();

  @action
  void resetNotificatinCounter() {
    notificationCounter = 0;
  }

  @action
  changeAppState(AppLifecycleState state) async {
    final profile = await _userProfileStore.retrieve();

    switch (state) {
      case AppLifecycleState.inactive:
        if (profile.stealthModeEnabled) {
          Modular.to.pushNamedAndRemoveUntil(
            '/authentication/stealth',
            ModalRoute.withName('/'),
          );

          return;
        }
        if (profile.anonymousModeEnabled) {
          Modular.to.pushNamedAndRemoveUntil(
            '/authentication/sign_in_stealth',
            ModalRoute.withName('/'),
          );

          return;
        }
        break;

      case AppLifecycleState.resumed:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
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
    securityState =
        await SecurityModeActionFeature(modulesServices: _modulesServices)
                .isEnabled
            ? MainboardSecurityState.enable()
            : MainboardSecurityState.disable();

    setupUploadTimer();
    checkUnRead();
  }

  Future<void> checkUnRead() async {
    final result = await _notification.unread();
    final validField = result.getOrElse(() => ValidField(message: "0"));
    notificationCounter = int.tryParse(validField.message) ?? 0;
  }
}
