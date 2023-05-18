import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class FilterTagEntity extends Equatable {
  const FilterTagEntity({
    required this.id,
    required this.label,
    required this.isSelected,
  });

  final String id;
  final String? label;
  final bool isSelected;

  @override
  List<Object?> get props => [id, label, isSelected];

  FilterTagEntity copyWith({String? id, String? label, bool? isSelected}) {
    return FilterTagEntity(
      id: id ?? this.id,
      label: label ?? this.label,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
