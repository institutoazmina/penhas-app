// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/core/managers/audio_record_services.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/features/help_center/data/models/alert_model.dart';
import 'package:penhas/app/features/help_center/data/repositories/guardian_repository.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_record_duration_entity.dart';
import 'package:penhas/app/features/help_center/domain/usecases/security_mode_action_feature.dart';
import 'package:penhas/app/features/zodiac/domain/usecases/stealth_security_action.dart';

class MockLocationServices extends Mock implements ILocationServices {}

class MockAudioRecordServices extends Mock implements IAudioRecordServices {}

class MockGuardianRepository extends Mock implements IGuardianRepository {}

class MockSecurityModeActionFeature extends Mock
    implements SecurityModeActionFeature {}

class FakeUserLocationEntity extends Fake implements UserLocationEntity {}

void main() {
  late MockLocationServices locationServices;
  late MockAudioRecordServices audioServices;
  late MockGuardianRepository guardianRepository;
  late MockSecurityModeActionFeature featureToggle;
  late StealthSecurityAction stealthSecurityAction;

  setUpAll(() {
    registerFallbackValue(FakeUserLocationEntity());
  });

  setUp(() {
    locationServices = MockLocationServices();
    audioServices = MockAudioRecordServices();
    guardianRepository = MockGuardianRepository();
    featureToggle = MockSecurityModeActionFeature();
    stealthSecurityAction = StealthSecurityAction(
      locationService: locationServices,
      audioServices: audioServices,
      guardianRepository: guardianRepository,
      featureToggle: featureToggle,
    );
  });

  group(StealthSecurityAction, () {
    group('start()', () {
      test('trigger guardian and start audio recording', () async {
        // arrange
        when(() => locationServices.currentLocation())
            .thenAnswer((_) async => right(UserLocationEntity()));
        when(() => guardianRepository.alert(any())).thenAnswer(
            (_) async => right(AlertModel(title: 'title', message: 'message')));
        when(() => audioServices.start()).thenAnswer((_) async => {});
        when(() => featureToggle.audioDuration)
            .thenAnswer((_) async => AudioRecordDurationEntity(30, 300));
        // act
        await stealthSecurityAction.start();
        // assert
        verify(() => locationServices.currentLocation()).called(1);
        verify(() => guardianRepository.alert(any())).called(1);
        verify(() => audioServices.start()).called(1);
      });
    });
  });
}
