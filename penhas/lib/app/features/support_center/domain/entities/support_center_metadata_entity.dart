import 'package:equatable/equatable.dart';
import 'package:penhas/app/features/filters/domain/entities/filter_tag_entity.dart';

class SupportCenterMetadataEntity extends Equatable {
  const SupportCenterMetadataEntity({
    required this.categories,
    required this.projects,
  });

  final List<FilterTagEntity>? categories;
  final List<FilterTagEntity>? projects;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [categories, projects];
}
