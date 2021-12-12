import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/features/filters/data/models/filter_skills_model.dart';
import 'package:penhas/app/features/filters/domain/repositories/filter_skill_repository.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

void main() {
  String? jsonFile;
  IApiProvider? apiProvider;
  late IFilterSkillRepository sut;

  setUp(() {
    sut = FilterSkillRepository(apiProvider: apiProvider);
  });

  group('FilterUseCase', () {
    test('should retrieve skills from server', () async {
      // arrange
      final jsonData = await JsonUtil.getJson(from: jsonFile);
      final actual = FilterSkillsModel.fromJson(jsonData).skills;
      when(
        apiProvider!.get(
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          parameters: anyNamed('parameters'),
        ),
      ).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
      // act
      // unwrap do Either pq ele não se dá bem com o Collection nativo,
      // eu teria que alterar para um List dele, mas me recurso a fazer isto
      // só para o teste, já que na códgio terá outras implicações.
      final matcher = await sut.skills().then((v) => v.getOrElse(() => null)!);
      // assert
      expect(actual, matcher);
    });
  });
}
