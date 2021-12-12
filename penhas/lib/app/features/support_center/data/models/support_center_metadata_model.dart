import 'package:collection/collection.dart';
import 'package:penhas/app/features/filters/data/models/filter_tag_model.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_metadata_entity.dart';

class SupportCenterMetadataModel extends SupportCenterMetadataEntity {
  final List<FilterTagModel>? categories;
  final List<FilterTagModel>? projects;

  SupportCenterMetadataModel({
    required this.categories,
    required this.projects,
  }) : super(
          categories: categories,
          projects: projects,
        );

  factory SupportCenterMetadataModel.fromJson(Map<String, Object> jsonData) {
    final List<Object> jsonCategories = jsonData["categorias"] as List<Object>;
    final List<Object> jsonProjects = jsonData["projetos"] as List<Object>;

    final List<FilterTagModel> categories = jsonCategories
        .map((e) => FilterTagModel.fromJson(e))
        .whereNotNull()
        .toList();

    final List<FilterTagModel> projects = jsonProjects
        .map((e) => FilterTagModel.fromJson(e))
        .whereNotNull()
        .toList();

    return SupportCenterMetadataModel(
      categories: categories,
      projects: projects,
    );
  }
}
