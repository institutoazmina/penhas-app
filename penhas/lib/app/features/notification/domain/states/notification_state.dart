import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_state.freezed.dart';

@freezed
abstract class NotificationState with _$NotificationState {
  const factory NotificationState.initial() = _Initial;
  const factory NotificationState.loaded() = _Loaded;
  const factory NotificationState.error(String message) = _ErrorDetails;
}
