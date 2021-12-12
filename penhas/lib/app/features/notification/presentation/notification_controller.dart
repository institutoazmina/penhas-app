import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/notification/data/repositories/notification_repository.dart';
import 'package:penhas/app/features/notification/domain/entities/notification_session_entity.dart';
import 'package:penhas/app/features/notification/domain/states/notification_state.dart';

part 'notification_controller.g.dart';

class NotificationController extends _NotificationControllerBase
    with _$NotificationController {
  NotificationController(
      {required INotificationRepository notificationRepository})
      : super(notificationRepository);
}

abstract class _NotificationControllerBase with Store, MapFailureMessage {
  _NotificationControllerBase(this._repository) {
    setup();
  }

  final INotificationRepository _repository;

  @observable
  ObservableFuture<Either<Failure, NotificationSessionEntity>>?
      _loadNotifications;

  @observable
  String errorMessage = '';

  @observable
  NotificationState state = const NotificationState.initial();

  @action
  Future<void> retry() async {
    loadNotification();
  }
}

extension _PrivateMethod on _NotificationControllerBase {
  Future<void> setup() async {
    loadNotification();
  }

  Future<void> loadNotification() async {
    errorMessage = '';
    _loadNotifications = ObservableFuture(_repository.notifications());

    final Either<Failure, NotificationSessionEntity> response = await _loadNotifications!;

    response.fold(
      (failure) => handleStateError(failure),
      (session) => handleSession(session),
    );
  }

  void handleSession(NotificationSessionEntity session) {
    if (session.notifications!.isEmpty) {
      state = NotificationState.empty();
    } else {
      state = NotificationState.loaded(session.notifications!);
    }
  }

  void handleStateError(Failure f) {
    state = NotificationState.error(mapFailureMessage(f)!);
  }

  void setErrorMessage(String msg) {
    errorMessage = msg;
  }
}
