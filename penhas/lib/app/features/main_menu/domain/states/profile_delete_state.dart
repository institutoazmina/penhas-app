import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_delete_state.freezed.dart';

@freezed
class ProfileDeleteState with _$ProfileDeleteState {
  const factory ProfileDeleteState.initial() = _Initial;
  const factory ProfileDeleteState.loaded(String message) = _Loaded;
  const factory ProfileDeleteState.error(String message) = _ErrorDetails;
}
