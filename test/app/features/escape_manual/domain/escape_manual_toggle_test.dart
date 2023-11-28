import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/features/escape_manual/domain/escape_manual_toggle.dart';

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
      'should call modules services isEnabled with name mf',
      () async {
        // arrange
        when(() => mockModulesServices.isEnabled(any()))
            .thenAnswer((_) async => true);

        // act
        await sut.isEnabled;

        // assert
        verify(() => mockModulesServices.isEnabled('mf')).called(1);
      },
    );

    test('should return true when feature is enabled', () async {
      // arrange
      when(() => mockModulesServices.isEnabled(any()))
          .thenAnswer((_) async => true);

      // act
      final result = await sut.isEnabled;

      // assert
      expect(result, true);
    });

    test('should return false when feature is disabled', () async {
      // arrange
      when(() => mockModulesServices.isEnabled(any()))
          .thenAnswer((_) async => false);

      // act
      final result = await sut.isEnabled;

      // assert
      expect(result, false);
    });

    test('should return false when isEnabled throws error', () async {
      // arrange
      when(() => mockModulesServices.isEnabled(any())).thenThrow(Exception());

      // act
      final result = await sut.isEnabled;

      // assert
      expect(result, false);
    });
  });
}
