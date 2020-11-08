import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_center_add_state.freezed.dart';

@freezed
abstract class SupportCenterAddState with _$SupportCenterAddState {
  const factory SupportCenterAddState.initial() = _Initial;
  const factory SupportCenterAddState.loaded() = _Loaded;
  const factory SupportCenterAddState.error(String message) = _ErrorDetails;
}
