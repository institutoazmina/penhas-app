import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/managers/user_profile_store.dart';
import 'package:penhas/app/features/main_menu/domain/repositories/user_profile_repository.dart';
import 'package:penhas/app/features/main_menu/domain/usecases/user_profile.dart';

class MockUserProfileStore extends Mock implements IUserProfileStore {}

class MockUserProfileRepository extends Mock implements IUserProfileRepository {
}

void main() {
  UserProfile sut;
  IUserProfileRepository repository;
  IUserProfileStore profileStore;

  setUp(() {
    repository = MockUserProfileRepository();
    profileStore = MockUserProfileStore();
    sut = UserProfile(repository: repository, userProfileStore: profileStore);
  });

  group('UserProfile', () {
    test('should enable stealth mode', () async {
      // arrange
      final actual = right(ValidField());
      when(repository.stealthMode(toggle: anyNamed('toggle')))
          .thenAnswer((_) async => right(ValidField()));
      // act
      final expected = await sut.enableStealthMode();
      // assert
      expect(actual, expected);
      verify(repository.stealthMode(toggle: true));
    });

    test('should disable stealth mode', () async {
      // arrange
      final actual = right(ValidField());
      when(repository.stealthMode(toggle: anyNamed('toggle')))
          .thenAnswer((_) async => right(ValidField()));
      // act
      final expected = await sut.disableStealthMode();
      // assert
      expect(actual, expected);
      verify(repository.stealthMode(toggle: false));
    });

    test('should enable anonymous mode', () async {
      // arrange
      final actual = right(ValidField());
      when(repository.anonymousMode(toggle: anyNamed('toggle')))
          .thenAnswer((_) async => right(ValidField()));
      // act
      final expected = await sut.enableAnonymousMode();
      // assert
      expect(actual, expected);
      verify(repository.anonymousMode(toggle: true));
    });

    test('should disable anonymous mode', () async {
      // arrange
      final actual = right(ValidField());
      when(repository.anonymousMode(toggle: anyNamed('toggle')))
          .thenAnswer((_) async => right(ValidField()));
      // act
      final expected = await sut.disableAnonymousMode();
      // assert
      expect(actual, expected);
      verify(repository.anonymousMode(toggle: false));
    });
  });
}
