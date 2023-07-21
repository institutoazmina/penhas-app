import 'package:equatable/equatable.dart';

import 'support_center_place_entity.dart';

class SupportCenterPlaceDetailEntity extends Equatable {
  const SupportCenterPlaceDetailEntity({
    required this.maximumRate,
    required this.ratedByClient,
    required this.place,
  });

  final int? maximumRate;
  final int? ratedByClient;
  final SupportCenterPlaceEntity? place;

  @override
  List<Object?> get props => [maximumRate, ratedByClient, place];
}
