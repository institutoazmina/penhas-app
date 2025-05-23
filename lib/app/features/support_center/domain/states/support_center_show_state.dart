import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/support_center_place_detail_entity.dart';

part 'support_center_show_state.freezed.dart';

@freezed
class SupportCenterShowState with _$SupportCenterShowState {
  const factory SupportCenterShowState.initial() = _Initial;
  const factory SupportCenterShowState.loaded(
    SupportCenterPlaceDetailEntity detail,
  ) = _Loaded;
  const factory SupportCenterShowState.error(String message) = _ErrorDetails;
}
