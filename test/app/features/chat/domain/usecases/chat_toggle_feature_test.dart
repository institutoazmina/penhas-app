import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/chat/domain/usecases/chat_toggle_feature.dart';

class MockAppModulesServices extends Mock implements IAppModulesServices {}

void main() {
  late MockAppModulesServices modulesServices;
  late ChatPrivateToggleFeature privateFeature;
  late ChatSupportToggleFeature supportFeature;

  setUp(() {
    modulesServices = MockAppModulesServices();
    privateFeature = ChatPrivateToggleFeature(modulesServices: modulesServices);
    supportFeature = ChatSupportToggleFeature(modulesServices: modulesServices);
  });

  group(ChatPrivateToggleFeature, () {
    test('isEnabled returns true when feature is not null', () async {
      when(() => modulesServices.feature(
          name: ChatPrivateToggleFeature.featureCode)).thenAnswer(
        (_) async => const AppStateModuleEntity(
          code: '',
          meta: '',
        ),
      );

      final result = await privateFeature.isEnabled;

      expect(result, true);
    });

    test('isEnabled returns false when feature is null', () async {
      when(() => modulesServices.feature(
              name: ChatPrivateToggleFeature.featureCode))
          .thenAnswer((_) async => null);

      final result = await privateFeature.isEnabled;

      expect(result, false);
    });

    test('isEnabled returns false when feature crash', () async {
      when(() => modulesServices.feature(
          name: ChatPrivateToggleFeature.featureCode)).thenThrow(Exception());

      final result = await privateFeature.isEnabled;

      expect(result, false);
    });
  });

  group(ChatSupportToggleFeature, () {
    test('isEnabled returns true when feature is not null', () async {
      when(() => modulesServices.feature(
          name: ChatSupportToggleFeature.featureCode)).thenAnswer(
        (_) async => const AppStateModuleEntity(
          code: '',
          meta: '',
        ),
      );

      final result = await supportFeature.isEnabled;

      expect(result, true);
    });

    test('isEnabled returns false when feature is null', () async {
      when(() => modulesServices.feature(
              name: ChatSupportToggleFeature.featureCode))
          .thenAnswer((_) async => null);

      final result = await supportFeature.isEnabled;

      expect(result, false);
    });

    test('isEnabled returns false when feature crash', () async {
      when(() => modulesServices.feature(
          name: ChatSupportToggleFeature.featureCode)).thenThrow(Exception());

      final result = await supportFeature.isEnabled;

      expect(result, false);
    });
  });
}
