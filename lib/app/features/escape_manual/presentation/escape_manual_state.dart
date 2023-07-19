import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/entity/escape_manual.dart';

part 'escape_manual_state.freezed.dart';

@freezed
class EscapeManualState with _$EscapeManualState {
  const factory EscapeManualState.initial() = _InitialState;

  const factory EscapeManualState.loaded({
    required EscapeManualEntity screen,
  }) = _LoadedState;

  const factory EscapeManualState.error(String message) = _ErrorState;
}

@freezed
class EscapeManualReaction with _$EscapeManualReaction {
  const factory EscapeManualReaction.showSnackbar(String message) =
      _ShowSnackbarReaction;
}
