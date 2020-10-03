import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/filters/data/models/filter_skills_model.dart';
import 'package:penhas/app/features/filters/data/models/filter_tag_model.dart';

import '../../../../../utils/json_util.dart';

void main() {
  String jsonFile;
  List<FilterTagModel> filterTags;

  setUp(() {
    jsonFile = "filters/filter_skills.json";
    filterTags = [
      FilterTagModel(id: "1", label: "Escuta acolhedora", isSelected: false),
      FilterTagModel(id: "2", label: "Psicologia", isSelected: false),
      FilterTagModel(id: "3", label: "Abrigo", isSelected: false),
      FilterTagModel(id: "4", label: "Apoio jurídico", isSelected: false),
      FilterTagModel(id: "5", label: "Finanças pessoais", isSelected: false),
      FilterTagModel(id: "6", label: "Saúde e bem estar", isSelected: false),
      FilterTagModel(id: "8", label: "Segurança digital", isSelected: false),
      FilterTagModel(id: "9", label: "Segurança pessoal", isSelected: false),
    ];
  });

  group('FilterSkillsModel', () {
    test('should return a valid model with a valid JSON', () async {
      // arrange
      final jsonData = await JsonUtil.getJson(from: jsonFile);
      final actual = FilterSkillsModel(skills: filterTags);
      // act
      final matcher = FilterSkillsModel.fromJson(jsonData);
      // assert
      expect(actual, matcher);
    });
  });
}
