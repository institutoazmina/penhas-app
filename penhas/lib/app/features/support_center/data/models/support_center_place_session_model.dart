import 'package:penhas/app/features/support_center/domain/entities/support_center_place_session_entity.dart';

class SupportCenterPlaceSessionModel extends SupportCenterPlaceSessionEntity {
  final int maximumRate;
  final double latitude;
  final double longitude;
  final String nextPage;
  final bool hasMore;
  final List<SupportCenterPlaceEntity> places;

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
      Map<String, Object> jsonData) {
    final maximumRate = jsonData["avaliacao_maxima"].safeParseInt();
    final latitude = jsonData["latitude"].safeParseDouble();
    final longitude = jsonData["longitude"].safeParseDouble();
    final hasMore = jsonData["has_more"].safeParseBool();
    final nextPage = jsonData["label"];

    final places = (jsonData["rows"] as List<Object>)
        .map((e) => e as Map<String, Object>)
        .map((e) => _SupportCenterPlaceEntityParse.fromJson(e))
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

extension _SupportCenterPlaceEntityParse on SupportCenterPlaceEntity {
  static SupportCenterPlaceEntity fromJson(Map<String, Object> jsonData) {
    final id = jsonData["id"].safeParseInt();
    final rate = jsonData["avaliacao"];
    final ratedByClient = jsonData["cliente_avaliacao"].safeParseInt() ?? 0;
    final distance = jsonData["distancia"];
    final latitude = jsonData["latitude"].safeParseDouble();
    final longitude = jsonData["longitude"].safeParseDouble();
    final name = jsonData["nome"];
    final uf = jsonData["uf"];
    final category = _SupportCenterPlaceCategoryEntityParse.fromJson(
        jsonData["categoria"] as Map<String, Object>);

    return SupportCenterPlaceEntity(
      id: id,
      rate: rate,
      ratedByClient: ratedByClient,
      distance: distance,
      latitude: latitude,
      longitude: longitude,
      name: name,
      uf: uf,
      category: category,
    );
  }
}

extension _SupportCenterPlaceCategoryEntityParse
    on SupportCenterPlaceCategoryEntity {
  static SupportCenterPlaceCategoryEntity fromJson(
      Map<String, Object> jsonData) {
    return SupportCenterPlaceCategoryEntity(
      id: jsonData['id'],
      color: jsonData['cor'],
      name: jsonData['nome'],
    );
  }
}

extension _SafetlyParser on Object {
  double safeParseDouble() {
    final value = this;

    if (value is String) {
      return double.tryParse(value);
    } else if (value is num) {
      return value.toDouble();
    }

    return null;
  }

  int safeParseInt() {
    final value = this;

    if (value is String) {
      return int.tryParse(value);
    } else if (value is num) {
      return value.toInt();
    }

    return null;
  }

  bool safeParseBool() {
    final value = this;
    try {
      return (value as num) == 1 ?? false;
    } catch (e) {
      return false;
    }
  }
}
