import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/managers/user_profile_store.dart';
import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/repositories/i_app_state_repository.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_state_usecase.dart';

import '../../../../../utils/json_util.dart';

class MockAppStateRepository extends Mock implements IAppStateRepository {}

class MockUserProfileStore extends Mock implements IUserProfileStore {}

class MockAppConfiguration extends Mock implements IAppConfiguration {}

void main() {
  AppStateUseCase sut;
  IAppStateRepository appStateRepository;
  IAppConfiguration appConfiguration;
  IUserProfileStore profileStore;

  setUp(() {
    profileStore = MockUserProfileStore();
    appConfiguration = MockAppConfiguration();
    appStateRepository = MockAppStateRepository();

    sut = AppStateUseCase(
      appStateRepository: appStateRepository,
      userProfileStore: profileStore,
      appConfiguration: appConfiguration,
    );
  });

  group('AppStateUseCase', () {
    test('should hit store user profile when get a valid session', () async {
      final jsonData =
          await JsonUtil.getJson(from: 'profile/about_with_quiz_session.json');
      final expectedModel = AppStateModel.fromJson(jsonData);
      when(profileStore.save(any)).thenAnswer((_) => Future.value());
      when(appConfiguration.saveAppModes(any))
          .thenAnswer((_) => Future.value());
      when(appStateRepository.check()).thenAnswer(
        (_) async => right(expectedModel),
      );
      // act
      await sut.check();
      // assert
      verify(profileStore.save(expectedModel.userProfile));
      verify(appConfiguration.saveAppModes(expectedModel.appMode));
    });
    test('should not hit store user profile when get failure', () async {
      final jsonData =
          await JsonUtil.getJson(from: 'profile/about_with_quiz_session.json');
      final expectedModel = AppStateModel.fromJson(jsonData);
      when(profileStore.save(any)).thenAnswer((_) => Future.value());
      when(appConfiguration.saveAppModes(any))
          .thenAnswer((_) => Future.value());
      when(appStateRepository.check()).thenAnswer(
        (_) async => left(ServerSideSessionFailed()),
      );
      // act
      await sut.check();
      // assert
      verifyNever(profileStore.save(expectedModel.userProfile));
      verifyNever(appConfiguration.saveAppModes(expectedModel.appMode));
    });
    test('should return valid AppStateEntity for a valid session', () async {
      // arrange
      final jsonData =
          await JsonUtil.getJson(from: 'profile/about_with_quiz_session.json');
      final expectedModel = AppStateModel.fromJson(jsonData);
      final AppStateEntity expectedEntity = expectedModel;
      when(appStateRepository.check()).thenAnswer(
        (_) async => right(expectedModel),
      );
      // act
      final received = await sut.check();
      // assert
      expect(received, right(expectedEntity));
    });
    test('should return ServerSideSessionFailed for a invalid session',
        () async {
      // arrange
      when(appStateRepository.check()).thenAnswer(
        (_) async => left(ServerSideSessionFailed()),
      );
      final expected = left(ServerSideSessionFailed());
      // act
      final received = await sut.check();
      // assert
      expect(received, expected);
    });
  });
}
