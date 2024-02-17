import 'dart:async';

import 'package:flutter/material.dart' as material;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/entities/valid_fiel.dart';
import '../../../../shared/navigation/app_navigator.dart';
import '../../../appstate/domain/usecases/app_preferences_use_case.dart';
import '../../../notification/data/repositories/notification_repository.dart';
import '../../domain/states/mainboard_store.dart';

part 'mainboard_controller.g.dart';

class MainboardController = _MainboardControllerBase with _$MainboardController;

abstract class _MainboardControllerBase with Store {
  _MainboardControllerBase({
    required this.mainboardStore,
    required InactivityLogoutUseCase inactivityLogoutUseCase,
    required INotificationRepository notification,
  })  : _inactivityLogoutUseCase = inactivityLogoutUseCase,
        _notification = notification {
    setup();
  }

  final MainboardStore mainboardStore;

  Timer? _syncTimer;
  final int _notificationInterval = 60;

  final InactivityLogoutUseCase _inactivityLogoutUseCase;
  final INotificationRepository _notification;

  @observable
  int selectedIndex = 0;

  @observable
  int notificationCounter = 0;

  @action
  void resetNotificatinCounter() {
    notificationCounter = 0;
  }

  @action
  Future<void> changeAppState(material.AppLifecycleState state) async {
    Modular.debugPrintModular('state changed to $state');
    switch (state) {
      case material.AppLifecycleState.inactive:
        _inactivityLogoutUseCase.setInactive(DateTime.now());
        break;
      case material.AppLifecycleState.resumed:
        final route = await _inactivityLogoutUseCase.inactivityRoute(
          DateTime.now(),
        );
        await _inactivityLogoutUseCase.setActive();
        route.map(AppNavigator.push);
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
      Duration(seconds: _notificationInterval),
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
    final validField = result.getOrElse(() => const ValidField(message: '0'));
    notificationCounter = int.tryParse(validField.message!) ?? 0;
  }
}
