// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/local_store.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:penhas/app/features/main_menu/domain/repositories/user_profile_repository.dart';
import 'package:penhas/app/features/main_menu/domain/usecases/user_profile.dart';

void main() {
  late AppStateUseCase appStateUseCase;
  late IUserProfileRepository repository;
  late LocalStore<UserProfileEntity> profileStore;
  late UserProfile sut;

  setUp(
    () {
      appStateUseCase = MockAppStateUseCase();
      repository = MockUserProfileRepository();
      profileStore = MockUserProfileStore();

      sut = UserProfile(
        repository: repository,
        userProfileStore: profileStore,
        appStateUseCase: appStateUseCase,
      );

      when(() => appStateUseCase.check()).thenAnswer(
        (_) async => right(
          const AppStateEntity(
            quizSession: null,
            userProfile: null,
            appMode: AppStateModeEntity(),
            modules: [],
          ),
        ),
      );
    },
  );

  group(UserProfile, () {
    group('stealthMode', () {
      test(
        'enabled',
        () async {
          // arrange
          final expected = right(const ValidField());
          when(() => repository.stealthMode(toggle: any(named: 'toggle')))
              .thenAnswer((_) async => right(const ValidField()));

          // act
          final actual = await sut.stealthMode(toggle: true);
          // assert
          expect(actual, expected);
          verify(() => repository.stealthMode(toggle: true)).called(1);
          verify(() => appStateUseCase.check()).called(1);
        },
      );

      test(
        'disabled',
        () async {
          // arrange
          final expected = right(const ValidField());
          when(() => repository.stealthMode(toggle: any(named: 'toggle')))
              .thenAnswer((_) async => right(const ValidField()));
          // act
          final actual = await sut.stealthMode(toggle: false);
          // assert
          expect(actual, expected);
          verify(() => repository.stealthMode(toggle: false)).called(1);
        },
      );

      test('got ServerFailure', () async {
        // arrange
        final expected = left(ServerFailure());
        when(() => repository.stealthMode(toggle: any(named: 'toggle')))
            .thenAnswer((_) async => left(ServerFailure()));
        // act
        final actual = await sut.stealthMode(toggle: false);
        // assert
        expect(actual, expected);
        verify(() => repository.stealthMode(toggle: false)).called(1);
      });
    });

    group('anonymousMode', () {
      test(
        'enabled',
        () async {
          // arrange
          final expected = right(const ValidField());
          when(() => repository.anonymousMode(toggle: any(named: 'toggle')))
              .thenAnswer((_) async => right(const ValidField()));
          // act
          final actual = await sut.anonymousMode(toggle: true);
          // assert
          expect(actual, expected);
          verify(() => repository.anonymousMode(toggle: true)).called(1);
        },
      );
      test(
        'disabled',
        () async {
          // arrange
          final expected = right(const ValidField());
          when(() => repository.anonymousMode(toggle: any(named: 'toggle')))
              .thenAnswer((_) async => right(const ValidField()));
          // act
          final actual = await sut.anonymousMode(toggle: false);
          // assert
          expect(actual, expected);
          verify(() => repository.anonymousMode(toggle: false)).called(1);
          verify(() => appStateUseCase.check()).called(1);
        },
      );
      test('got ServerFailure', () async {
        // arrange
        final expected = left(ServerFailure());
        when(() => repository.anonymousMode(toggle: any(named: 'toggle')))
            .thenAnswer((_) async => left(ServerFailure()));
        // act
        final actual = await sut.anonymousMode(toggle: false);
        // assert
        expect(actual, expected);
        verify(() => repository.anonymousMode(toggle: false)).called(1);
      });
    });

    test('get currentProfile', () async {
      // arrange
      final expected = UserProfileEntity(
        anonymousModeEnabled: false,
        avatar: '',
        birthdate: DateTime(1980),
        email: '',
        fullName: '',
        genre: '',
        jaFoiVitimaDeViolencia: false,
        minibio: '',
        nickname: '',
        race: '',
        skill: [],
        stealthModeEnabled: false,
        badges: [],
      );
      when(() => profileStore.retrieve()).thenAnswer((_) async => expected);
      // act
      final actual = await sut.currentProfile();
      // assert
      expect(actual, expected);
      verify(() => profileStore.retrieve()).called(1);
    });

    test('logout', () async {
      // arrange
      when(() => profileStore.delete()).thenAnswer((_) => Future.value());
      // act
      await sut.logout();
      // assert
      verify(() => profileStore.delete()).called(1);
    });
  });
}

class MockAppStateUseCase extends Mock implements AppStateUseCase {}

class MockUserProfileRepository extends Mock
    implements IUserProfileRepository {}

class MockUserProfileStore extends Mock
    implements LocalStore<UserProfileEntity> {}
