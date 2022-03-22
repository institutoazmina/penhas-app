import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mainboard_security_state.freezed.dart';

@freezed
class MainboardSecurityState with _$MainboardSecurityState {
  const factory MainboardSecurityState.enable() = _Enable;
  const factory MainboardSecurityState.disable() = _Disable;
}
