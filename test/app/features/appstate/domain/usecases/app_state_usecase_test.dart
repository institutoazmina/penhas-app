import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/managers/local_store.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/entities/update_user_profile_entity.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/appstate/domain/repositories/i_app_state_repository.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_state_usecase.dart';

import '../../../../../utils/json_util.dart';

void main() {
  late IAppConfiguration appConfiguration;
  late IAppModulesServices appModulesServices;
  late IAppStateRepository appStateRepository;
  late LocalStore<UserProfileEntity> profileStore;
  late AppStateUseCase sut;

  setUp(() {
    appStateRepository = MockAppStateRepository();
    appConfiguration = MockAppConfiguration();
    profileStore = MockUserProfileStore();
    appModulesServices = MockAppModulesServices();

    sut = AppStateUseCase(
      userProfileStore: profileStore,
      appConfiguration: appConfiguration,
      appStateRepository: appStateRepository,
      appModulesServices: appModulesServices,
    );
  });

  group(AppStateUseCase, () {
    group('check()', () {
      test('return valid AppStateEntity for a valid session', () async {
        // arrange
        final jsonData = await JsonUtil.getJson(
            from: 'profile/about_with_quiz_session.json');
        final expectedModel = AppStateModel.fromJson(jsonData);
        final AppStateEntity expectedEntity = expectedModel;

        when(() => profileStore.save(expectedEntity.userProfile!))
            .thenAnswer((_) => Future.value());
        when(() => appConfiguration.saveAppModes(expectedEntity.appMode))
            .thenAnswer((_) => Future.value());
        when(() => appModulesServices.save(expectedEntity.modules))
            .thenAnswer((_) => Future.value());
        when(() => appStateRepository.check()).thenAnswer(
          (_) async => right(expectedModel),
        );

        // act
        final received = await sut.check();
        // assert
        expect(received, right(expectedEntity));
        verify(() => profileStore.save(expectedModel.userProfile!)).called(1);
        verify(() => appModulesServices.save(expectedModel.modules)).called(1);
        verify(() => appConfiguration.saveAppModes(expectedModel.appMode))
            .called(1);
      });
      test('return ServerSideSessionFailed for a invalid session', () async {
        // arrange
        when(() => appStateRepository.check()).thenAnswer(
          (_) async => left(ServerSideSessionFailed()),
        );
        final expected = left(ServerSideSessionFailed());
        // act
        final received = await sut.check();
        // assert
        expect(received, expected);
      });
    });

    group('update', () {
      test('return valid AppStateEntity for a valid session', () async {
        // arrange
        final jsonData = await JsonUtil.getJson(
            from: 'profile/about_with_quiz_session.json');
        final expectedModel = AppStateModel.fromJson(jsonData);
        final AppStateEntity expectedEntity = expectedModel;
        final profile = UpdateUserProfileEntity();

        when(() => profileStore.save(expectedEntity.userProfile!))
            .thenAnswer((_) => Future.value());
        when(() => appConfiguration.saveAppModes(expectedEntity.appMode))
            .thenAnswer((_) => Future.value());
        when(() => appModulesServices.save(expectedEntity.modules))
            .thenAnswer((_) => Future.value());
        when(() => appStateRepository.update(profile)).thenAnswer(
          (_) async => right(expectedModel),
        );

        // act
        final received = await sut.update(profile);
        // assert
        expect(received, right(expectedEntity));
        verify(() => profileStore.save(expectedModel.userProfile!)).called(1);
        verify(() => appModulesServices.save(expectedModel.modules)).called(1);
        verify(() => appConfiguration.saveAppModes(expectedModel.appMode))
            .called(1);
      });
      test('return ServerSideSessionFailed for a invalid session', () async {
        // arrange
        final profile = UpdateUserProfileEntity();
        final expected = left(ServerSideSessionFailed());

        when(() => appStateRepository.update(profile)).thenAnswer(
          (_) async => left(ServerSideSessionFailed()),
        );
        // act
        final received = await sut.update(profile);
        // assert
        expect(received, expected);
      });
    });
  });
}

class MockAppStateRepository extends Mock implements IAppStateRepository {}

class MockAppConfiguration extends Mock implements IAppConfiguration {}

class MockUserProfileStore extends Mock
    implements LocalStore<UserProfileEntity> {}

class MockAppModulesServices extends Mock implements IAppModulesServices {}
