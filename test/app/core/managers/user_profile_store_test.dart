import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/user_profile_store.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/features/appstate/data/model/user_profile_model.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';

void main() {
  group('AppPreferencesStoreTest', () {
    late UserProfileStore userProfileStore;
    late ILocalStorage storage;

    const key = 'br.com.penhas.userProfile';
    final now = DateTime(2022, 11, 25, 23, 34, 27);

    setUp(() {
      storage = _LocalStorageMock();
      userProfileStore = UserProfileStore(
        storage: storage,
        timeProvider: () => now,
      );
    });

    test(
      '`save` should call `storage.put`',
      () async {
        // arrange
        const expectedData = {
          'email': 'email@testing.com',
          'apelido': 'nickname',
          'avatar_url': 'avatar',
          'dt_nasc': '1970-01-01T00:00:00.000',
          'nome_completo': 'fullName',
          'minibio': 'minibio',
          'raca': 'race',
          'genero': 'genre',
          'skills': ['skill1', 'skill2'],
          'modo_anonimo_ativo': 0,
          'ja_foi_vitima_de_violencia': 0,
          'modo_camuflado_ativo': 1,
          'badges': [],
        };
        when(() => storage.put(key, any())).thenAnswer((_) async {});

        final userProfileEntity = UserProfileModel(
          fullName: 'fullName',
          nickname: 'nickname',
          email: 'email@testing.com',
          birthdate: DateTime(1970),
          genre: 'genre',
          minibio: 'minibio',
          race: 'race',
          avatar: 'avatar',
          skill: const ['skill1', 'skill2'],
          stealthModeEnabled: true,
          badges: [],
        );

        // act
        userProfileStore.save(userProfileEntity);

        // assert
        final captured = verify(() => storage.put(key, captureAny())).captured;
        expect(captured.length, 1);

        final actualData = jsonDecode(captured.last);
        expect(actualData, equals(expectedData));
      },
    );

    test(
      '`retrieve` should return data from `storage`',
      () async {
        // arrange
        final expectedUserProfile = UserProfileModel(
          fullName: 'fullName',
          nickname: 'nickname',
          email: 'email@testing.com',
          birthdate: DateTime(2022, 11, 25),
          genre: 'genre',
          minibio: 'minibio',
          race: 'race',
          avatar: 'avatar',
          skill: const ['skill1', 'skill2'],
          anonymousModeEnabled: true,
        );
        const serializedData =
            '{"email":"email@testing.com","apelido":"nickname","avatar_url":"avatar","modo_camuflado_ativo":0,"modo_anonimo_ativo":1,"dt_nasc":"2022-11-25T00:00:00.000","nome_completo":"fullName","minibio":"minibio","raca":"race","genero":"genre","ja_foi_vitima_de_violencia":0,"skills":["skill1","skill2"]}';

        when(() => storage.get(key)).thenAnswer((_) async => serializedData);

        // act
        final actualUserProfile = await userProfileStore.retrieve();

        // assert
        expect(actualUserProfile, equals(expectedUserProfile));
      },
    );

    test(
      'when key not exists in storage `retrieve` should return default value',
      () async {
        // arrange
        final expectedUserProfile = UserProfileEntity(
          fullName: null,
          nickname: null,
          email: null,
          birthdate: now,
          genre: null,
          minibio: null,
          race: null,
          avatar: null,
          skill: const [],
          stealthModeEnabled: false,
          anonymousModeEnabled: false,
          jaFoiVitimaDeViolencia: false,
          badges: [],
        );

        when(() => storage.get(key)).thenAnswer((_) async => null);

        // act
        final actualUserProfile = await userProfileStore.retrieve();

        // assert
        expect(actualUserProfile, equals(expectedUserProfile));
      },
    );

    test(
      '`retrieve` should return same saved data',
      () async {
        // arrange
        final expectedUserProfile = UserProfileModel(
          fullName: 'maria da silva',
          nickname: 'maria',
          email: 'maria@email.com',
          birthdate: DateTime(1991),
          genre: 'feminino',
          minibio: 'minha bio',
          race: 'parda',
          avatar: 'http://avatar.com/maria.jpg',
          skill: const ['skill1', 'skill2', 'skill3'],
          jaFoiVitimaDeViolencia: true,
        );

        String? savedData;
        when(() => storage.put(key, any())).thenAnswer((invocation) async {
          savedData = invocation.positionalArguments[1];
        });
        when(() => storage.get(key)).thenAnswer((_) async => savedData);

        // act
        await userProfileStore.save(expectedUserProfile);
        final actualUserProfile = await userProfileStore.retrieve();

        // assert
        expect(actualUserProfile, equals(expectedUserProfile));
      },
    );

    test(
      '`delete` should call `storage.delete`',
      () async {
        // arrange
        when(() => storage.delete(key)).thenAnswer((_) async {});

        // act
        userProfileStore.delete();

        // assert
        verify(() => storage.delete(key)).called(1);
      },
    );
  });
}

class _LocalStorageMock extends Mock implements ILocalStorage {}
