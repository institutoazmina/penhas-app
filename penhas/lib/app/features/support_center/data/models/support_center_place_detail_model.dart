import 'package:meta/meta.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_detail.dart';

class SupportCenterPlaceDetailModel extends SupportCenterPlaceDetail {
  final int maximumRate;
  final int ratedByClient;

  SupportCenterPlaceDetailModel({
    @required this.maximumRate,
    @required this.ratedByClient,
  }) : super();

  // factory SupportCenterPlaceDetailModel.fromJson(Map<String, Object> jsonData) {
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
  // }
}
