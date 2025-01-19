import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_start_state.freezed.dart';

@freezed
class QuizStartState with _$QuizStartState {
  const factory QuizStartState.initial() = _InitialState;

  const factory QuizStartState.error(String message) = _ErrorState;
}
