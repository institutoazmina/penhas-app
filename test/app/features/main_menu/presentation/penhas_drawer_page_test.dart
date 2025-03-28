import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/help_center/domain/usecases/security_mode_action_feature.dart';
import 'package:penhas/app/features/main_menu/domain/usecases/user_profile.dart';
import 'package:penhas/app/features/main_menu/presentation/penhas_drawer_controller.dart';
import 'package:penhas/app/features/main_menu/presentation/penhas_drawer_page.dart';
import 'package:penhas/app/features/quiz/presentation/tutorial/stealth_mode_tutorial_page_controller.dart';

import '../../../../utils/golden_tests.dart';
import '../../../../utils/widget_test_steps.dart';

class MockAppConfiguration extends Mock implements IAppConfiguration {}

class MockUserProfile extends Mock implements UserProfile {}

class MockAppModulesServices extends Mock implements IAppModulesServices {}

class FakeAppStateModuleEntity extends Fake implements AppStateModuleEntity {}

class MockLocationServices extends Mock implements ILocationServices {
  @override
  Future<bool> isPermissionGranted() async {
    return Future.value(true);
  }
}

void main() {
  late MockAppConfiguration appConfiguration;
  late MockUserProfile userProfile;
  late MockAppModulesServices modulesServices;
  late PenhasDrawerController penhasDrawerController;
  late ILocationServices locationServices;
  late StealthModeTutorialPageController stealthController;

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
    badges: [],
  );

  setUp(() {
    appConfiguration = MockAppConfiguration();
    userProfile = MockUserProfile();
    modulesServices = MockAppModulesServices();
    locationServices = MockLocationServices();
    penhasDrawerController = PenhasDrawerController(
        appConfigure: appConfiguration,
        modulesServices: modulesServices,
        userProfile: userProfile);
    stealthController = StealthModeTutorialPageController(
      locationService: locationServices,
    );
  });

  group(PenhasDrawerPage, () {
    testWidgets('should load penhas drawer page', (tester) async {
      // arrange
      when(() => modulesServices.feature(
              name: SecurityModeActionFeature.featureCode))
          .thenAnswer((_) async => null);

      when(() => userProfile.currentProfile()).thenAnswer(
        (_) => Future.value(userProfileEntity),
      );
      // act
      tester.theAppIsRunning(PenhasDrawerPage(
        controller: penhasDrawerController,
        stealthController: stealthController,
      ));
      // assert
    });
  });

  screenshotTest(
    'should load penhas drawer page',
    fileName: 'penhas_drawer_page',
    pageBuilder: () => Scaffold(
        body: PenhasDrawerPage(
      controller: penhasDrawerController,
      stealthController: stealthController,
    )),
    setUp: () {
      when(() => modulesServices.feature(
              name: SecurityModeActionFeature.featureCode))
          .thenAnswer((_) => Future.value(null));
      when(() => userProfile.currentProfile()).thenAnswer(
        (_) => Future.value(userProfileEntity),
      );
    },
    skip: true,
    reason:
        'SvgPicture.network consumido pelo PenhasDrawerPage gera exception que não consigo tratar neste momento',
  );

  screenshotTest(
    'should show security mode toggle',
    fileName: 'penhas_drawer_page_security_mode_toggle',
    pageBuilder: () => Scaffold(
        body: PenhasDrawerPage(
      controller: penhasDrawerController,
      stealthController: stealthController,
    )),
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
        badges: [],
      );

      when(() => userProfile.currentProfile()).thenAnswer(
        (_) => Future.value(userProfileEntity),
      );
    },
    skip: true,
    reason:
        'SvgPicture.network consumido pelo PenhasDrawerPage gera exception que não consigo tratar neste momento',
  );
}
