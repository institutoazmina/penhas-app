import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/filters/data/models/filter_skills_model.dart';
import 'package:penhas/app/features/filters/data/models/filter_tag_model.dart';

import '../../../../../utils/json_util.dart';

void main() {
  String? jsonFile;
  List<FilterTagModel>? filterTags;

  setUp(() {
    jsonFile = 'filters/filter_skills.json';
    filterTags = [
      const FilterTagModel(
          id: '1', label: 'Escuta acolhedora', isSelected: false),
    ];
  });

  group(FilterSkillsModel, () {
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
