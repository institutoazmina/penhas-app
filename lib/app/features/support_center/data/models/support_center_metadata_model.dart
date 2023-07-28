import 'package:collection/collection.dart';

import '../../../filters/data/models/filter_tag_model.dart';
import '../../domain/entities/support_center_metadata_entity.dart';

class SupportCenterMetadataModel extends SupportCenterMetadataEntity {
  const SupportCenterMetadataModel({
    required List<FilterTagModel>? categories,
    required List<FilterTagModel>? projects,
  }) : super(
          categories: categories,
          projects: projects,
        );

  factory SupportCenterMetadataModel.fromJson(Map<String, dynamic> jsonData) {
    final List jsonCategories = jsonData['categorias'];
    final List jsonProjects = jsonData['projetos'];

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
