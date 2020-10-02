import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/features/filters/domain/entities/filter_tag_entity.dart';

import 'filter_tag_model.dart';

@immutable
class FilterSkillsModel extends Equatable {
  final List<FilterTagEntity> skills;

  FilterSkillsModel({
    @required this.skills,
  });

  factory FilterSkillsModel.fromJson(Map<String, Object> jsonData) {
    final List<Object> jsonSkills = jsonData["skills"];
    final List<FilterTagEntity> skills = jsonSkills
        .map((e) => e as Map<String, Object>)
        .map((e) => FilterTagModel.fromJson(e))
        .where((e) => e != null)
        .toList();

    return FilterSkillsModel(skills: skills);
  }

  @override
  List<Object> get props => [skills];

  @override
  bool get stringify => true;
}
