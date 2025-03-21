import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';

import '../../../core/error/failures.dart';
import '../../authentication/presentation/shared/map_failure_message.dart';
import '../data/repositories/notification_repository.dart';
import '../domain/entities/notification_session_entity.dart';
import '../domain/states/notification_state.dart';

part 'notification_controller.g.dart';

class NotificationController extends _NotificationControllerBase
    with _$NotificationController {
  NotificationController({
    required INotificationRepository notificationRepository,
  }) : super(notificationRepository);
}

abstract class _NotificationControllerBase with Store, MapFailureMessage {
  _NotificationControllerBase(this._repository);

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
    await _loadNotification();
  }

  Future<void> initialize() async {
    await _loadNotification();
  }

  Future<void> _loadNotification() async {
    errorMessage = '';
    _loadNotifications = ObservableFuture(_repository.notifications());

    final Either<Failure, NotificationSessionEntity> response =
        await _loadNotifications!;

    response.fold(
      (failure) => _handleStateError(failure),
      (session) => _handleSession(session),
    );
  }

  void _handleSession(NotificationSessionEntity session) {
    if (session.notifications!.isEmpty) {
      state = const NotificationState.empty();
    } else {
      state = NotificationState.loaded(session.notifications!);
    }
  }

  void _handleStateError(Failure f) {
    state = NotificationState.error(mapFailureMessage(f));
  }
}
