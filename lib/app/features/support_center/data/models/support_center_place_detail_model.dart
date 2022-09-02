import 'package:penhas/app/core/extension/safetly_parser.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_detail_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_entity.dart';

class SupportCenterPlaceDetailModel extends SupportCenterPlaceDetailEntity {
  const SupportCenterPlaceDetailModel({
    required int? maximumRate,
    required int? ratedByClient,
    required SupportCenterPlaceEntity? place,
  }) : super(
          maximumRate: maximumRate,
          ratedByClient: ratedByClient,
          place: place,
        );

  factory SupportCenterPlaceDetailModel.fromJson(
    Map<String, dynamic> jsonData,
  ) {
    final maximumRate = "${jsonData["avaliacao_maxima"]}".safeParseInt();
    final ratedByClient = "${jsonData["cliente_avaliacao"]}".safeParseInt();
    final placeJson = jsonData['ponto_apoio'] as Map<String, dynamic>;
    final place = SupportCenterPlaceEntity.fromJson(placeJson);

    return SupportCenterPlaceDetailModel(
      place: place,
      maximumRate: maximumRate,
      ratedByClient: ratedByClient,
    );
  }
}
