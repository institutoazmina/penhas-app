import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/features/support_center/domain/usecases/support_center_toggle_feature.dart';

class MockAppModulesServices extends Mock implements IAppModulesServices {}

void main() {
  late SupportCenterToggleFeature sut;
  late IAppModulesServices modulesServices;

  setUp(() {
    modulesServices = MockAppModulesServices();
    sut = SupportCenterToggleFeature(modulesServices: modulesServices);
  });

  group(SupportCenterToggleFeature, () {
    test('isEnabled returns true when feature is enabled', () async {
      // arrange
      when(() => modulesServices.isEnabled(any()))
          .thenAnswer((_) async => true);
      // act
      final result = await sut.isEnabled;
      // assert
      verify(() =>
              modulesServices.isEnabled(SupportCenterToggleFeature.featureCode))
          .called(1);
      expect(result, isTrue);
    });

    test('isEnabled returns false when feature is disabled', () async {
      // arrange
      when(() => modulesServices.isEnabled(any()))
          .thenAnswer((_) async => false);
      // act
      final result = await sut.isEnabled;
      // assert
      verify(() =>
              modulesServices.isEnabled(SupportCenterToggleFeature.featureCode))
          .called(1);
      expect(result, isFalse);
    });
  });
}
