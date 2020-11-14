import 'package:meta/meta.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_detail_entity.dart';

class SupportCenterPlaceDetailModel extends SupportCenterPlaceDetailEntity {
  final int maximumRate;
  final int ratedByClient;

  SupportCenterPlaceDetailModel({
    @required this.maximumRate,
    @required this.ratedByClient,
  }) : super();

  factory SupportCenterPlaceDetailModel.fromJson(Map<String, Object> jsonData) {
    final maximumRate = jsonData["avaliacao_maxima"].safeParseInt();
    final ratedByClient = jsonData["cliente_avaliacao"].safeParseInt() ?? 0;

    return SupportCenterPlaceDetailModel(
      maximumRate: maximumRate,
      ratedByClient: ratedByClient,
    );

    //   final List<Object> jsonCategories = jsonData["categorias"];
    //   final List<Object> jsonProjects = jsonData["projetos"];

    //   final List<FilterTagModel> categories = jsonCategories
    //       .map((e) => e as Map<String, Object>)
    //       .map((e) => FilterTagModel.fromJson(e))
    //       .where((e) => e != null)
    //       .toList();

    //   final List<FilterTagModel> projects = jsonProjects
    //       .map((e) => e as Map<String, Object>)
    //       .map((e) => FilterTagModel.fromJson(e))
    //       .where((e) => e != null)
    //       .toList();

    //   return SupportCenterPlaceDetailModel(
    //     categories: categories,
    //     projects: projects,
    //   );
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
