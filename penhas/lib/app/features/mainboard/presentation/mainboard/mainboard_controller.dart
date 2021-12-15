import 'dart:async';

import 'package:flutter/material.dart' as material;
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_preferences_use_case.dart';
import 'package:penhas/app/features/help_center/domain/usecases/security_mode_action_feature.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_security_state.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_store.dart';
import 'package:penhas/app/features/notification/data/repositories/notification_repository.dart';
import 'package:penhas/app/shared/navigation/navigator.dart';

part 'mainboard_controller.g.dart';

class MainboardController extends _MainboardControllerBase
    with _$MainboardController {
  MainboardController({
    required MainboardStore mainboardStore,
    required InactivityLogoutUseCase inactivityLogoutUseCase,
    required INotificationRepository notification,
    required IAppModulesServices modulesServices,
  }) : super(
          mainboardStore,
          inactivityLogoutUseCase,
          notification,
          modulesServices,
        );
}

abstract class _MainboardControllerBase with Store {
  Timer? _syncTimer;
  final int notificationInterval = 60;
  final MainboardStore mainboardStore;
  final InactivityLogoutUseCase _inactivityLogoutUseCase;
  final INotificationRepository _notification;
  final IAppModulesServices _modulesServices;

  _MainboardControllerBase(
    this.mainboardStore,
    this._inactivityLogoutUseCase,
    this._notification,
    this._modulesServices,
  ) {
    setup();
  }

  Timer? _syncTimer;
  final int notificationInterval = 60;
  final MainboardStore mainboardStore;
  final InactivityLogoutUseCase _inactivityLogoutUseCase;
  final INotificationRepository _notification;
  final IAppModulesServices _modulesServices;

  @observable
  int selectedIndex = 0;

  @observable
  int notificationCounter = 0;

  @observable
  MainboardSecurityState securityState = const MainboardSecurityState.disable();

  @action
  void resetNotificatinCounter() {
    notificationCounter = 0;
  }

  @action
  Future<void> changeAppState(material.AppLifecycleState state) async {
    switch (state) {
      case material.AppLifecycleState.inactive:
        _inactivityLogoutUseCase.setInactive(DateTime.now());
        break;
      case material.AppLifecycleState.resumed:
        final route = await _inactivityLogoutUseCase.inactivityRoute(
          DateTime.now(),
        );
        _inactivityLogoutUseCase.setActive();
        route.fold(
          (l) => {},
          (r) => AppNavigator.pushAndRemoveUntil(
            r!,
            removeUntil: '/',
          ),
        );
        break;
      case material.AppLifecycleState.detached:
      case material.AppLifecycleState.paused:
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
            ? const MainboardSecurityState.enable()
            : const MainboardSecurityState.disable();

    setupUploadTimer();
    checkUnRead();
  }

  Future<void> checkUnRead() async {
    final result = await _notification.unread();
    final validField = result.getOrElse(() => ValidField(message: '0'));
    notificationCounter = int.tryParse(validField.message!) ?? 0;
  }
}
