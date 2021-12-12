import 'package:equatable/equatable.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_entity.dart';

class SupportCenterPlaceDetailEntity extends Equatable {
  final int? maximumRate;
  final int? ratedByClient;
  final SupportCenterPlaceEntity? place;

  SupportCenterPlaceDetailEntity({
    required this.maximumRate,
    required this.ratedByClient,
    required this.place,
  });

  final int? maximumRate;
  final int? ratedByClient;
  final SupportCenterPlaceEntity? place;

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        maximumRate!,
        ratedByClient!,
        place!,
      ];
}
