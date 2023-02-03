import 'package:penhas/app/core/extension/safely_parser.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_session_entity.dart';

class SupportCenterPlaceSessionModel extends SupportCenterPlaceSessionEntity {
  const SupportCenterPlaceSessionModel({
    int? maximumRate,
    double? latitude,
    double? longitude,
    bool? hasMore,
    String? nextPage,
    List<SupportCenterPlaceEntity> places = const [],
  }) : super(
          maximumRate: maximumRate,
          latitude: latitude,
          longitude: longitude,
          nextPage: nextPage,
          hasMore: hasMore,
          places: places,
        );

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
