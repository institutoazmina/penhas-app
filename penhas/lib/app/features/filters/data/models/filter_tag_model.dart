import 'package:meta/meta.dart';
import 'package:penhas/app/features/filters/domain/entities/filter_tag_entity.dart';

@immutable
class FilterTagModel extends FilterTagEntity {
  final String id;
  final String? label;
  final bool isSelected;

  FilterTagModel({
    required this.id,
    required this.label,
    required this.isSelected,
  }) : super(id: id, label: label, isSelected: isSelected);

  static FilterTagModel? fromJson(Map<String, dynamic>? jsonData) {
    if (jsonData == null) return null;

    return FilterTagModel(
      id: jsonData['value'] as String? ?? "${jsonData['id']}",
      label: jsonData['label'] as String? ?? jsonData['title'] as String? ?? jsonData['skill'] as String?,
      isSelected: (jsonData['default'] as num?) == 1 ?? false,
    );
  }
}
