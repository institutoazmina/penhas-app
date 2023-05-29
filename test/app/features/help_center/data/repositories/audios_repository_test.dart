import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/help_center/data/models/audio_model.dart';
import 'package:penhas/app/features/help_center/data/repositories/audios_repository.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';

import '../../../../../utils/json_util.dart';

class MockApiProvider extends Mock implements IApiProvider {}

void main() {
  late IAudiosRepository sut;
  late IApiProvider apiProvider;

  setUpAll(
    () {
      apiProvider = MockApiProvider();
      sut = AudiosRepository(apiProvider: apiProvider);
    },
  );

  group(AudiosRepository, () {
    test('fetch available audio when available on server', () async {
      // arrange
      final jsonData = await JsonUtil.getJson(from: 'audios/audios_fetch.json');
      final expected = AudioModel.fromJson(jsonData);
      when(
        () => apiProvider.get(
          path: any(named: 'path'),
          headers: any(named: 'headers'),
          parameters: any(named: 'parameters'),
        ),
      ).thenAnswer((_) => JsonUtil.getString(from: 'audios/audios_fetch.json'));

      // act
      final result = await sut.fetch();

      // assert
      expect(result.fold((l) => l, (r) => r.audioList), expected.audioList);
    });
    test('delete audio', () async {
      // arrange
      final expected = right(const ValidField());
      final audio = AudioEntity(
        id: '6db0260b-9733-4610-9586-de5141d79c32',
        audioDuration: '2m18s',
        createdAt: DateTime.parse('2020-08-15T16:58:54Z').toLocal(),
        canPlay: false,
        isRequested: true,
        isRequestGranted: false,
      );
      when(
        () => apiProvider.delete(
          path: any(named: 'path'),
          parameters: any(named: 'parameters'),
        ),
      ).thenAnswer((_) => Future.value(''));
      // act
      final result = await sut.delete(audio);
      // assert
      expect(result, expected);
    });

    test('request audio', () async {
      // arrange
      final Either<Failure, ValidField> expected = right(
        const ValidField(
          message:
              'Enviaremos uma mensagem quando o arquivo estiver disponível.',
        ),
      );
      final audio = AudioEntity(
        id: '6db0260b-9733-4610-9586-de5141d79c32',
        audioDuration: '2m18s',
        createdAt: DateTime.parse('2020-08-15T16:58:54Z').toLocal(),
        canPlay: false,
        isRequested: true,
        isRequestGranted: false,
      );
      when(
        () => apiProvider.post(
          path: any(named: 'path'),
          headers: any(named: 'headers'),
          parameters: any(named: 'parameters'),
        ),
      ).thenAnswer(
        (_) => Future.value(
          '{"message":"Enviaremos uma mensagem quando o arquivo estiver disponível.","success":1}',
        ),
      );
      // act
      final result = await sut.requestAccess(audio);
      // assert
      expect(result, expected);
    });
  });
}
