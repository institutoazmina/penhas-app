import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/managers/audio_play_services.dart';
import 'package:penhas/app/features/help_center/data/models/audio_model.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';
import 'package:penhas/app/features/help_center/presentation/audios/audios_controller.dart';
import 'package:penhas/app/features/help_center/data/repositories/audios_repository.dart';

import '../../../../../utils/json_util.dart';

class MockAudioPlayServices extends Mock implements IAudioPlayServices {}

class MockAudiosRepository extends Mock implements IAudiosRepository {}

void main() {
  late MockAudiosRepository audiosRepository;
  late MockAudioPlayServices audioPlayServices;
  late AudioEntity audioReference;

  late AudiosController sut;
  late Map<String, dynamic> jsonData;

  group(AudiosController, () {
    setUp(() {
      audioPlayServices = MockAudioPlayServices();
      audiosRepository = MockAudiosRepository();
      sut = AudiosController(
          audioPlayServices: audioPlayServices,
          audiosRepository: audiosRepository);
    });

    test('delete', () async {
      // arrange
      jsonData = await JsonUtil.getJson(from: 'audios/audios_fetch.json');

      audioReference = AudioEntity(
        audioDuration: '123456',
        canPlay: true,
        createdAt: DateTime(2023, 2, 3, 14, 44),
        id: '123',
        isRequestGranted: true,
        isRequested: true,
      );

      when(() => audiosRepository.delete(any())).thenAnswer(
          (_) async => right(const ValidField(message: '')));

      when(() => audiosRepository.fetch())
          .thenAnswer((_) async => right(AudioModel.fromJson(jsonData)));

      // act
      await sut.delete(audioReference);

      // assert
      verify(sut.loadPage).called(1);
    });
  });
}
