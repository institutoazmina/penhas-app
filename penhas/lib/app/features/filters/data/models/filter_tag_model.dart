import 'package:meta/meta.dart';
import 'package:penhas/app/features/filters/domain/entities/filter_tag_entity.dart';

@immutable
class FilterTagModel extends FilterTagEntity {
  final String id;
  final String label;
  final bool isSelected;

  FilterTagModel({
    @required this.id,
    @required this.label,
    @required this.isSelected,
  }) : super(id: id, label: label, isSelected: isSelected);

  factory FilterTagModel.fromJson(Map<String, Object> jsonData) {
    if (jsonData == null) return null;

    return FilterTagModel(
      id: jsonData['value'] ?? "${jsonData['id']}",
      label: jsonData['label'] ?? jsonData['title'] ?? jsonData['skill'],
      isSelected: (jsonData['default'] as num) == 1 ?? false,
    );
  }
}
