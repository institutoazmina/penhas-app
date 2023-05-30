import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/audio_play_services.dart';
import 'package:penhas/app/features/help_center/presentation/audios/audios_controller.dart';
import 'package:penhas/app/features/help_center/data/repositories/audios_repository.dart';

class MockAudioPlayServices extends Mock implements IAudioPlayServices {}

class MockAudiosRepository extends Mock implements IAudiosRepository {}

void main() {
  late MockAudiosRepository audiosRepository;
  late MockAudioPlayServices audioPlayServices;
  late AudiosController controller;

  group(AudiosController, () {
    setUp(() {
      audioPlayServices = MockAudioPlayServices();
      audiosRepository = MockAudiosRepository();
      controller = AudiosController(
          audioPlayServices: audioPlayServices,
          audiosRepository: audiosRepository);
    });


    test('buildTile', (){
      
    });
  });
}
