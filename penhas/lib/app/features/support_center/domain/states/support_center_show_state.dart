import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_center_show_state.freezed.dart';

@freezed
abstract class SupportCenterShowState with _$SupportCenterShowState {
  const factory SupportCenterShowState.initial() = _Initial;
  const factory SupportCenterShowState.loaded() = _Loaded;
  const factory SupportCenterShowState.error(String message) = _ErrorDetails;
}
