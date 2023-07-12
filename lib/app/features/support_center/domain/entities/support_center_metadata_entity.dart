import 'package:equatable/equatable.dart';

import '../../../filters/domain/entities/filter_tag_entity.dart';

class SupportCenterMetadataEntity extends Equatable {
  const SupportCenterMetadataEntity({
    required this.categories,
    required this.projects,
  });

  final List<FilterTagEntity>? categories;
  final List<FilterTagEntity>? projects;

  @override
  List<Object?> get props => [categories, projects];
}
