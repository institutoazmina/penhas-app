import 'package:meta/meta.dart';

import '../../domain/entities/filter_tag_entity.dart';

@immutable
class FilterTagModel extends FilterTagEntity {
  const FilterTagModel({
    required super.id,
    required super.label,
    required super.isSelected,
  });

  static FilterTagModel? fromJson(Map<String, dynamic>? jsonData) {
    if (jsonData == null) return null;

    return FilterTagModel(
      id: jsonData['value'] as String? ?? "${jsonData['id']}",
      label: jsonData['label'] as String? ??
          jsonData['title'] as String? ??
          jsonData['skill'] as String?,
      isSelected: jsonData['default'] == 1,
    );
  }
}
