import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:penhas/app/features/notification/domain/entities/notification_session_entity.dart';

part 'notification_state.freezed.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState.initial() = _Initial;
  const factory NotificationState.loaded(
    List<NotificationEntity> notifications,
  ) = _Loaded;
  const factory NotificationState.empty() = _Empty;
  const factory NotificationState.error(String message) = _ErrorDetails;
}
