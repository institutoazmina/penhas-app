import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/guardian_tile_entity.dart';

part 'guardian_state.freezed.dart';

@freezed
class GuardianState with _$GuardianState {
  const factory GuardianState.initial() = _Initial;
  const factory GuardianState.loaded(List<GuardianTileEntity> tiles) = _Loaded;
  const factory GuardianState.error(String message) = _ErrorDetails;
}
