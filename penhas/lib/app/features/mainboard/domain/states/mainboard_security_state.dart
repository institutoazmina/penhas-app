import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'mainboard_security_state.freezed.dart';

@freezed
abstract class MainboardSecurityState with _$MainboardSecurityState {
  const factory MainboardSecurityState.enable() = _Enable;
  const factory MainboardSecurityState.disable() = _Disable;
}
