import 'package:equatable/equatable.dart';

import 'support_center_place_entity.dart';

class SupportCenterPlaceSessionEntity extends Equatable {
  const SupportCenterPlaceSessionEntity({
    required this.maximumRate,
    required this.latitude,
    required this.longitude,
    required this.nextPage,
    required this.hasMore,
    required this.places,
  });

  final bool? hasMore;
  final int? maximumRate;
  final double? latitude;
  final double? longitude;
  final String? nextPage;
  final List<SupportCenterPlaceEntity> places;

  @override
  List<Object?> get props => [
        maximumRate,
        latitude,
        longitude,
        nextPage,
        hasMore,
        places,
      ];
}
