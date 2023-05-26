import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/feed/domain/usecases/escape_manual_toggle.dart';

class MockAppModulesServices extends Mock implements IAppModulesServices {}

void main() {
  late EscapeManualToggleFeature sut;

  late IAppModulesServices mockModulesServices;

  setUp(() {
    mockModulesServices = MockAppModulesServices();
    sut = EscapeManualToggleFeature(modulesServices: mockModulesServices);
  });

  group('EscapeManualToggleFeature', () {
    test(
      'should call modules services feature with name mf',
      () async {
        // arrange
        when(() => mockModulesServices.feature(name: any(named: 'name')))
            .thenAnswer(
          (_) async => const AppStateModuleEntity(code: 'mf', meta: '{}'),
        );

        // act
        await sut.isEnabled;

        // assert
        verify(() => mockModulesServices.feature(name: 'mf')).called(1);
      },
    );

    test('should return true when feature is enabled', () async {
      // arrange
      when(() => mockModulesServices.feature(name: 'mf')).thenAnswer(
        (_) async => const AppStateModuleEntity(code: 'mf', meta: '{}'),
      );

      // act
      final result = await sut.isEnabled;

      // assert
      expect(result, true);
    });

    test('should return false when feature is disabled', () async {
      // arrange
      when(() => mockModulesServices.feature(name: 'mf'))
          .thenAnswer((_) async => null);

      // act
      final result = await sut.isEnabled;

      // assert
      expect(result, false);
    });

    test('should return false when feature throws error', () async {
      // arrange
      when(() => mockModulesServices.feature(name: 'mf'))
          .thenThrow(Exception());

      // act
      final result = await sut.isEnabled;

      // assert
      expect(result, false);
    });
  });
}
