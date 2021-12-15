import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/help_center/data/models/audio_model.dart';
import 'package:penhas/app/features/help_center/data/repositories/audios_repository.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';
import 'package:penhas/app/shared/logger/log.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

void main() {
  isCrashlitycsEnabled = false;
  late IAudiosRepository sut;
  late final MockIApiProvider apiProvider = MockIApiProvider();

  setUpAll(
    () {
      sut = AudiosRepository(apiProvider: apiProvider);
    },
  );

  group('Audios', () {
    test('should fetch available audio when available on server', () async {
      // arrange
      final jsonData = await JsonUtil.getJson(from: 'audios/audios_fetch.json');
      final expected = AudioModel.fromJson(jsonData);
      when(
        apiProvider.get(
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          parameters: anyNamed('parameters'),
        ),
      ).thenAnswer((_) => JsonUtil.getString(from: 'audios/audios_fetch.json'));

      // act
      // unwrap do Either pq ele não se dá bem com o Collection nativo,
      // eu teria que alterar para um List dele, mas me recurso a fazer isto
      // só para o teste, já que na códgio terá outras implicações.
      final result = await sut.fetch().then((v) => v.getOrElse(() => null)!);
      // assert
      expect(result, expected);
    });
    test('should delete audio', () async {
      // arrange
      final expected = right(ValidField());
      final audio = AudioEntity(
          id: '6db0260b-9733-4610-9586-de5141d79c32',
          audioDuration: '2m18s',
          createdAt: DateTime.parse('2020-08-15T16:58:54Z').toLocal(),
          canPlay: false,
          isRequested: true,
          isRequestGranted: false,);
      when(
        apiProvider.delete(
          path: anyNamed('path'),
          parameters: anyNamed('parameters'),
        ),
      ).thenAnswer((_) => Future.value(''));
      // act
      final result = await sut.delete(audio);
      // assert
      expect(result, expected);
    });

    test('should request audio', () async {
      // arrange
      final Either<Failure, ValidField> expected = right(ValidField(
          message:
              'Enviaremos uma mensagem quando o arquivo estiver disponível.',),);
      final audio = AudioEntity(
          id: '6db0260b-9733-4610-9586-de5141d79c32',
          audioDuration: '2m18s',
          createdAt: DateTime.parse('2020-08-15T16:58:54Z').toLocal(),
          canPlay: false,
          isRequested: true,
          isRequestGranted: false,);
      when(
        apiProvider.post(
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          parameters: anyNamed('parameters'),
        ),
      ).thenAnswer((_) => Future.value(
          '{"message":"Enviaremos uma mensagem quando o arquivo estiver disponível.","success":1}',),);
      // act
      final result = await sut.requestAccess(audio);
      // assert
      expect(result, expected);
    });
  });
}
