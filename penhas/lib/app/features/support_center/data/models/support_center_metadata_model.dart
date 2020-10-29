import 'package:meta/meta.dart';
import 'package:penhas/app/features/filters/data/models/filter_tag_model.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_metadata_entity.dart';

class SupportCenterMetadataModel extends SupportCenterMetadataEntity {
  final List<FilterTagModel> categories;
  final List<FilterTagModel> projects;

  SupportCenterMetadataModel({
    @required this.categories,
    @required this.projects,
  }) : super(
          categories: categories,
          projects: projects,
        );

  factory SupportCenterMetadataModel.fromJson(Map<String, Object> jsonData) {
    final List<Object> jsonCategories = jsonData["categorias"];
    final List<Object> jsonProjects = jsonData["projetos"];

    final List<FilterTagModel> categories = jsonCategories
        .map((e) => e as Map<String, Object>)
        .map((e) => FilterTagModel.fromJson(e))
        .where((e) => e != null)
        .toList();

    final List<FilterTagModel> projects = jsonProjects
        .map((e) => e as Map<String, Object>)
        .map((e) => FilterTagModel.fromJson(e))
        .where((e) => e != null)
        .toList();

    return SupportCenterMetadataModel(
      categories: categories,
      projects: projects,
    );
  }
}
