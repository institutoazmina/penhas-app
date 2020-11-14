import 'package:meta/meta.dart';
import 'package:penhas/app/core/extension/safetly_parser.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_detail_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_entity.dart';

class SupportCenterPlaceDetailModel extends SupportCenterPlaceDetailEntity {
  final int maximumRate;
  final int ratedByClient;
  final SupportCenterPlaceEntity place;

  SupportCenterPlaceDetailModel({
    @required this.maximumRate,
    @required this.ratedByClient,
    @required this.place,
  }) : super(
          maximumRate: maximumRate,
          ratedByClient: ratedByClient,
          place: place,
        );

  factory SupportCenterPlaceDetailModel.fromJson(Map<String, Object> jsonData) {
    final maximumRate = jsonData["avaliacao_maxima"].safeParseInt();
    final ratedByClient = jsonData["cliente_avaliacao"].safeParseInt() ?? 0;
    final placeJson = jsonData["ponto_apoio"] as Map<String, Object>;
    final place = SupportCenterPlaceEntity.fromJson(placeJson);

    return SupportCenterPlaceDetailModel(
      place: place,
      maximumRate: maximumRate,
      ratedByClient: ratedByClient,
    );
  }
}
