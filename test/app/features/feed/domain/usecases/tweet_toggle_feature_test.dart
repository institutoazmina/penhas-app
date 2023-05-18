import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/feed/domain/usecases/tweet_toggle_feature.dart';

void main() {
  late MockAppModulesServices modulesServices;
  late TweetToggleFeature feature;

  setUp(() {
    modulesServices = MockAppModulesServices();
    feature = TweetToggleFeature(modulesServices: modulesServices);
  });

  group(TweetToggleFeature, () {
    group('isEnabled', () {
      test('returns true when feature with featureCode is present', () async {
        when(() => modulesServices.feature(name: any(named: 'name')))
            .thenAnswer((_) async => FakeAppStateModuleEntity());

        final result = await feature.isEnabled;

        expect(result, isTrue);
      });

      test('returns false when feature with featureCode is not present',
          () async {
        when(() => modulesServices.feature(name: any(named: 'name')))
            .thenAnswer((_) async => null);

        final result = await feature.isEnabled;

        expect(result, isFalse);
      });

      test('returns false when feature crash', () async {
        when(() => modulesServices.feature(name: any(named: 'name')))
            .thenThrow(Exception());

        final result = await feature.isEnabled;

        expect(result, false);
      });
    });
  });
}

class MockAppModulesServices extends Mock implements IAppModulesServices {}

class FakeAppStateModuleEntity extends Fake implements AppStateModuleEntity {}
