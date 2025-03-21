import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/filter_tag_entity.dart';
import 'filter_tag_model.dart';

@immutable
class FilterSkillsModel extends Equatable {
  const FilterSkillsModel({
    required this.skills,
  });

  factory FilterSkillsModel.fromJson(Map<String, dynamic> jsonData) {
    final List<dynamic> jsonSkills = jsonData['skills'];
    final List<FilterTagEntity> skills =
        jsonSkills.map((e) => FilterTagModel.fromJson(e)).nonNulls.toList();

    return FilterSkillsModel(skills: skills);
  }

  final List<FilterTagEntity>? skills;

  @override
  List<dynamic> get props => [skills];
}
