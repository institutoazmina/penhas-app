import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/filters/data/models/filter_skills_model.dart';
import 'package:penhas/app/features/filters/domain/repositories/filter_skill_repository.dart';

import '../../../../../utils/json_util.dart';

class MockApiProvider extends Mock implements IApiProvider {}

void main() {
  late MockApiProvider apiProvider;
  late IFilterSkillRepository sut;
  const jsonFile = 'filters/filter_skills.json';

  setUp(() {
    apiProvider = MockApiProvider();
    sut = FilterSkillRepository(apiProvider: apiProvider);
  });

  group(FilterSkillRepository, () {
    test('retrieve skills from server', () async {
      // arrange
      final jsonData = await JsonUtil.getJson(from: jsonFile);
      final actual = FilterSkillsModel.fromJson(jsonData).skills;
      when(
        () => apiProvider.get(
          path: any(named: 'path'),
          headers: any(named: 'headers'),
          parameters: any(named: 'parameters'),
        ),
      ).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
      // act
      final result = await sut.skills();
      // assert
      expect(
        actual,
        result.fold((l) => l, (r) => r),
      );
    });
  });
}
