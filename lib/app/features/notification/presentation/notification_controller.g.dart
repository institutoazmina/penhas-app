// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NotificationController on _NotificationControllerBase, Store {
  late final _$_loadNotificationsAtom = Atom(
      name: '_NotificationControllerBase._loadNotifications', context: context);

  @override
  ObservableFuture<Either<Failure, NotificationSessionEntity>>?
      get _loadNotifications {
    _$_loadNotificationsAtom.reportRead();
    return super._loadNotifications;
  }

  @override
  set _loadNotifications(
      ObservableFuture<Either<Failure, NotificationSessionEntity>>? value) {
    _$_loadNotificationsAtom.reportWrite(value, super._loadNotifications, () {
      super._loadNotifications = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_NotificationControllerBase.errorMessage', context: context);

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$stateAtom =
      Atom(name: '_NotificationControllerBase.state', context: context);

  @override
  NotificationState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(NotificationState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$retryAsyncAction =
      AsyncAction('_NotificationControllerBase.retry', context: context);

  @override
  Future<void> retry() {
    return _$retryAsyncAction.run(() => super.retry());
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
state: ${state}
    ''';
  }
}
