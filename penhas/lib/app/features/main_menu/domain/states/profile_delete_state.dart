import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_delete_state.freezed.dart';

@freezed
abstract class ProfileDeleteState with _$ProfileDeleteState {
  const factory ProfileDeleteState.initial() = _Initial;
  const factory ProfileDeleteState.error(String message) = _ErrorDetails;
}
