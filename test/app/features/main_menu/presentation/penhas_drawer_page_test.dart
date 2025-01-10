import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/help_center/domain/usecases/security_mode_action_feature.dart';
import 'package:penhas/app/features/main_menu/domain/usecases/user_profile.dart';
import 'package:penhas/app/features/main_menu/presentation/penhas_drawer_controller.dart';
import 'package:penhas/app/features/main_menu/presentation/penhas_drawer_page.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/mainboard_module.dart';

import '../../../../utils/golden_tests.dart';
import '../../../../utils/widget_test_steps.dart';

class MockAppConfiguration extends Mock implements IAppConfiguration {}

class MockUserProfile extends Mock implements UserProfile {}

class MockAppModulesServices extends Mock implements IAppModulesServices {}

class FakeAppStateModuleEntity extends Fake implements AppStateModuleEntity {}

void main() {
  late MockAppConfiguration appConfiguration;
  late MockUserProfile userProfile;
  late MockAppModulesServices modulesServices;

  final userProfileEntity = UserProfileEntity(
    fullName: 'Penhas',
    race: 'test',
    minibio: 'test',
    birthdate: DateTime(2000, 1, 1),
    stealthModeEnabled: false,
    avatar: 'test',
    nickname: 'test',
    anonymousModeEnabled: false,
    email: 'test',
    jaFoiVitimaDeViolencia: false,
    skill: ['test'],
    genre: 'test',
  );

  setUp(() {
    appConfiguration = MockAppConfiguration();
    userProfile = MockUserProfile();
    modulesServices = MockAppModulesServices();

    initModule(
      MainboardModule(),
      replaceBinds: [
        Bind.factory(
          (i) => PenhasDrawerController(
            appConfigure: appConfiguration,
            userProfile: userProfile,
            modulesServices: modulesServices,
          ),
        ),
      ],
    );
  });

  group(PenhasDrawerPage, () {
    testWidgets('should load penhas drawer page', (tester) async {
      // arrange
      when(() => modulesServices.feature(
              name: SecurityModeActionFeature.featureCode))
          .thenAnswer((_) => Future.value(null));
      when(() => userProfile.currentProfile()).thenAnswer(
        (_) => Future.value(userProfileEntity),
      );
      // act
      tester.theAppIsRunning(PenhasDrawerPage());
      // assert
    });
  });

  screenshotTest(
    'should load penhas drawer page',
    fileName: 'penhas_drawer_page',
    pageBuilder: () => Scaffold(body: PenhasDrawerPage()),
    setUp: () {
      when(() => modulesServices.feature(
              name: SecurityModeActionFeature.featureCode))
          .thenAnswer((_) => Future.value(null));
      when(() => userProfile.currentProfile()).thenAnswer(
        (_) => Future.value(userProfileEntity),
      );
    },
  );

  screenshotTest(
    'should show security mode toggle',
    fileName: 'penhas_drawer_page_security_mode_toggle',
    pageBuilder: () => Scaffold(body: PenhasDrawerPage()),
    setUp: () {
      when(() => modulesServices.feature(
              name: SecurityModeActionFeature.featureCode))
          .thenAnswer((_) async => FakeAppStateModuleEntity());

      final userProfileEntity = UserProfileEntity(
        fullName: 'Penhas',
        race: 'test',
        minibio: 'test',
        birthdate: DateTime(2000, 1, 1),
        stealthModeEnabled: true,
        avatar: 'test',
        nickname: 'test',
        anonymousModeEnabled: false,
        email: 'test',
        jaFoiVitimaDeViolencia: false,
        skill: ['test'],
        genre: 'test',
      );

      when(() => userProfile.currentProfile()).thenAnswer(
        (_) => Future.value(userProfileEntity),
      );
    },
  );
}
