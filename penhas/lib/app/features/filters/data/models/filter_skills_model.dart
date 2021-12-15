import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/features/filters/data/models/filter_tag_model.dart';
import 'package:penhas/app/features/filters/domain/entities/filter_tag_entity.dart';

@immutable
class FilterSkillsModel extends Equatable {
  final List<FilterTagEntity>? skills;

  const FilterSkillsModel({
    required this.skills,
  });

  factory FilterSkillsModel.fromJson(Map<String, dynamic> jsonData) {
    final List<dynamic> jsonSkills = jsonData['skills'];
    final List<FilterTagEntity> skills = jsonSkills
        .map((e) => FilterTagModel.fromJson(e))
        .whereNotNull()
        .toList();

    return FilterSkillsModel(skills: skills);
  }

  final List<FilterTagEntity>? skills;

  @override
  List<dynamic> get props => [skills];

  @override
  bool get stringify => true;
}
