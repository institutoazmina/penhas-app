import 'package:penhas/app/core/extension/safetly_parser.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_session_entity.dart';

class SupportCenterPlaceSessionModel extends SupportCenterPlaceSessionEntity {
  @override
  final int? maximumRate;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final String? nextPage;
  @override
  final bool? hasMore;
  @override
  final List<SupportCenterPlaceEntity>? places;

  SupportCenterPlaceSessionModel(
    this.maximumRate,
    this.latitude,
    this.longitude,
    this.hasMore,
    this.nextPage,
    this.places,
  ) : super(
          maximumRate: maximumRate,
          latitude: latitude,
          longitude: longitude,
          nextPage: nextPage,
          hasMore: hasMore,
          places: places,
        );

  factory SupportCenterPlaceSessionModel.fromJson(
      Map<String, dynamic> jsonData) {
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
      maximumRate,
      latitude,
      longitude,
      hasMore,
      nextPage,
      places,
    );
  }
}
