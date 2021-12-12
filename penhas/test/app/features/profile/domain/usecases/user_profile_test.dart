import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/main_menu/domain/usecases/user_profile.dart';

import '../../../../../utils/helper.mocks.dart';

void main() {
  late UserProfile sut;
  AppStateUseCase? appStateUseCase;
  IUserProfileRepository? repository;
  LocalStore<UserProfileEntity> profileStore;

  setUp(() {
    when(appStateUseCase.check()).thenAnswer(
      (_) => Future.value(
        right(
          const AppStateEntity(
            quizSession: null,
            userProfile: null,
            appMode: AppStateModeEntity(),
            modules: [],
          ),
        ),
      ),
    );
  });

  group('UserProfile', () {
    test('should enable stealth mode', () async {
      // arrange
      final actual = right(ValidField());
      when(repository!.stealthMode(toggle: anyNamed('toggle')))
          .thenAnswer((_) async => right(ValidField()));
      when(appStateUseCase!.check()).thenAnswer(((_) => null) as Future<Either<Failure, AppStateEntity>> Function(Invocation));
      // act
      final expected = await sut.stealthMode(toggle: true);
      // assert
      expect(actual, expected);
      verify(repository!.stealthMode(toggle: true));
      verify(appStateUseCase!.check());
    });

    test('should disable stealth mode', () async {
      // arrange
      final actual = right(ValidField());
      when(repository!.stealthMode(toggle: anyNamed('toggle')))
          .thenAnswer((_) async => right(ValidField()));
      // act
      final expected = await sut.stealthMode(toggle: false);
      // assert
      expect(actual, expected);
      verify(repository!.stealthMode(toggle: false));
    });

    test('should enable anonymous mode', () async {
      // arrange
      final actual = right(ValidField());
      when(repository!.anonymousMode(toggle: anyNamed('toggle')))
          .thenAnswer((_) async => right(ValidField()));
      // act
      final expected = await sut.anonymousMode(toggle: true);
      // assert
      expect(actual, expected);
      verify(repository!.anonymousMode(toggle: true));
    });

    test('should disable anonymous mode', () async {
      // arrange
      final actual = right(ValidField());
      when(repository!.anonymousMode(toggle: anyNamed('toggle')))
          .thenAnswer((_) async => right(ValidField()));
      when(appStateUseCase!.check()).thenAnswer(((_) => null) as Future<Either<Failure, AppStateEntity>> Function(Invocation));
      // act
      final expected = await sut.anonymousMode(toggle: false);
      // assert
      expect(actual, expected);
      verify(repository!.anonymousMode(toggle: false));
      verify(appStateUseCase!.check());
    });
  });
}
