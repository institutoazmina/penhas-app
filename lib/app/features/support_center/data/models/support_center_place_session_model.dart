import '../../../../core/extension/safely_parser.dart';
import '../../domain/entities/support_center_place_entity.dart';
import '../../domain/entities/support_center_place_session_entity.dart';

class SupportCenterPlaceSessionModel extends SupportCenterPlaceSessionEntity {
  const SupportCenterPlaceSessionModel({
    super.maximumRate,
    super.latitude,
    super.longitude,
    super.hasMore,
    super.nextPage,
    super.places = const [],
  });

  factory SupportCenterPlaceSessionModel.fromJson(
    Map<String, dynamic> jsonData,
  ) {
    final maximumRate = "${jsonData["avaliacao_maxima"]}".safeParseInt();
    final latitude = "${jsonData["latitude"]}".safeParseDouble();
    final longitude = "${jsonData["longitude"]}".safeParseDouble();
    final hasMore = "${jsonData["has_more"]}".safeParseBool();
    final nextPage = jsonData['label'];

    final places = (jsonData['rows'] as List<dynamic>)
        .map((e) => e as Map<String, dynamic>)
        .map((e) => SupportCenterPlaceEntity.fromJson(e))
        .toList();

    return SupportCenterPlaceSessionModel(
      maximumRate: maximumRate,
      latitude: latitude,
      longitude: longitude,
      hasMore: hasMore,
      nextPage: nextPage,
      places: places,
    );
  }
}
