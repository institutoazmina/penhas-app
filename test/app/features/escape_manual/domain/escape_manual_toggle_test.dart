import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
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
    group('isEnabled', () {
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

    group('maxTrustedContacts', () {
      test(
        'should call modulesServices.feature with mf',
        () async {
          // arrange
          when(() => mockModulesServices.feature(name: any(named: 'name')))
              .thenAnswer((_) async => null);

          // act
          await sut.maxTrustedContacts;

          // assert
          verify(() => mockModulesServices.feature(name: 'mf')).called(1);
        },
      );

      test(
        'should return max_checkbox_contato value',
        () async {
          // arrange
          final maxTrustedContacts = Random().nextInt(10);
          when(() => mockModulesServices.feature(name: any(named: 'name')))
              .thenAnswer(
            (_) async => AppStateModuleEntity(
              code: 'mf',
              meta: '{"max_checkbox_contato": $maxTrustedContacts}',
            ),
          );

          // act
          final actual = await sut.maxTrustedContacts;

          // assert
          expect(actual, equals(maxTrustedContacts));
        },
      );

      test(
        'should return default maxTrustedContacts value when modulesServices throws error',
        () async {
          // arrange
          final expectedMaxTrustedContacts = 3;
          when(() => mockModulesServices.feature(name: any(named: 'name')))
              .thenAnswer((_) async => throw Exception());

          // act
          final actual = await sut.maxTrustedContacts;

          // assert
          expect(actual, equals(expectedMaxTrustedContacts));
        },
      );
    });
  });
}
