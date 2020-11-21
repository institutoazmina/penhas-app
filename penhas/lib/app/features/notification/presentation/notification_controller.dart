import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/notification/data/repositories/notification_repository.dart';
import 'package:penhas/app/features/notification/domain/states/notification_state.dart';

part 'notification_controller.g.dart';

class NotificationController extends _NotificationControllerBase
    with _$NotificationController {
  NotificationController(
      {@required INotificationRepository notificationRepository})
      : super(notificationRepository);
}

abstract class _NotificationControllerBase with Store, MapFailureMessage {
  Timer _syncTimer;
  final int notificationInterval = 300;
  final INotificationRepository _repository;

  _NotificationControllerBase(this._repository) {
    setup();
  }

  // @observable
  // ObservableFuture<Either<Failure, SupportCenterMetadataEntity>>
  //     _loadNotifications;

  @observable
  int notificationCounter = 0;

  @observable
  String errorMessage = "";

  @observable
  NotificationState state = NotificationState.initial();

  @action
  Future<void> retry() async {}
}

extension _PrivateMethod on _NotificationControllerBase {
  void setupUploadTimer() {
    if (_syncTimer != null) {
      return;
    }

    _syncTimer = Timer.periodic(
      Duration(seconds: notificationInterval),
      (timer) async {
        final time = DateTime.now().toString();
        print("[$time] Executando o monitoramento do notification");
        checkUnRead();
      },
    );
  }

  Future<void> setup() async {
    setupUploadTimer();
  }

  Future<void> checkUnRead() async {
    final result = await _repository.unread();
    final validField = result.getOrElse(() => ValidField(message: "0"));
    notificationCounter = int.tryParse(validField.message) ?? 0;
  }

  void setMessageErro(String message) {
    errorMessage = message;
  }

  // Future<void> handleLocationFeedback(Object value) async {
  //   if (value is bool && value == true) {
  //     await loadSupportCenter(_fetchRequest);
  //   }
  // }

  // Future<void> handleCategoriesSuccess(List<FilterTagEntity> categories) async {
  //   final tags = categories
  //       .map(
  //         (e) => FilterTagEntity(
  //           id: e.id,
  //           isSelected: isSeleted(e.id),
  //           label: e.label,
  //         ),
  //       )
  //       .toList();

  //   Modular.to
  //       .pushNamed("/mainboard/filters", arguments: tags)
  //       .then((v) => v as FilterActionObserver)
  //       .then((v) async => handleCategoriesUpdate(v));
  // }

  void handleCategoriesError(Failure failure) {
    final message = mapFailureMessage(failure);
    setMessageErro(message);
  }

  PageProgressState monitorProgress(ObservableFuture<Object> observable) {
    if (observable == null || observable.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return observable.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  void handleStateError(Failure f) {
    state = NotificationState.error(mapFailureMessage(f));
  }

  void setErrorMessage(String msg) {
    errorMessage = msg;
  }
}