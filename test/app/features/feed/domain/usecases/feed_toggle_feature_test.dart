import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_toggle_feature.dart';

class MockAppModulesServices extends Mock implements IAppModulesServices {}

void main() {
  late MockAppModulesServices modulesServices;
  late FeedToggleFeature feature;

  setUp(() {
    modulesServices = MockAppModulesServices();
    feature = FeedToggleFeature(modulesServices: modulesServices);
  });

  group(FeedToggleFeature, () {
    group('isEnabled', () {
      test('returns true when feature with featureCode is present', () async {
        // arrange
        when(() => modulesServices.feature(name: any(named: 'name')))
            .thenAnswer((_) async => FakeAppStateModuleEntity());
        // act
        final result = await feature.isEnabled;
        // assert
        verify(() => modulesServices.feature(name: 'noticias'));
        expect(result, isTrue);
      });

      test('returns false when feature with featureCode is not present',
          () async {
        // arrange
        when(() => modulesServices.feature(name: any(named: 'name')))
            .thenAnswer((_) async => null);
        // act
        final result = await feature.isEnabled;
        // assert
        verify(() => modulesServices.feature(name: 'noticias'));
        expect(result, isFalse);
      });

      test('returns false when feature crash', () async {
        // arrange
        when(() => modulesServices.feature(name: any(named: 'name')))
            .thenThrow(Exception());
        // act
        final result = await feature.isEnabled;
        // assert
        verify(() => modulesServices.feature(name: 'noticias'));
        expect(result, isFalse);
      });
    });
  });
}

class FakeAppStateModuleEntity extends Fake implements AppStateModuleEntity {}
