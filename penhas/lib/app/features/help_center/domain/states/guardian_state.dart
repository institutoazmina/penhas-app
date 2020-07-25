import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'guardian_state.freezed.dart';

@freezed
abstract class GuardianState with _$GuardianState {
  const factory GuardianState.initial() = _Initial;
  const factory GuardianState.loaded() = _Loaded;
  const factory GuardianState.error([String message]) = _ErrorDetails;
  const factory GuardianState.rateLimit(int maxLimit) = _RateLimit;
}
