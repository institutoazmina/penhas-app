import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/core/states/location_permission_state.dart';
import 'package:penhas/app/features/help_center/data/models/alert_model.dart';
import 'package:penhas/app/features/help_center/data/repositories/guardian_repository.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_record_duration_entity.dart';
import 'package:penhas/app/features/zodiac/domain/usecases/stealth_security_action.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/core/managers/audio_record_services.dart';
import 'package:penhas/app/features/help_center/domain/usecases/security_mode_action_feature.dart';
import 'package:penhas/app/shared/widgets/request_location_permission_content_widget.dart';

class MockAudioServices extends Mock implements IAudioRecordServices {}

class MockLocationServices extends Mock implements ILocationServices {}

class MockGuardianRepository extends Mock implements IGuardianRepository {}

class MockFeatureToggle extends Mock implements SecurityModeActionFeature {}

class UserLocationEntityFake extends Fake implements UserLocationEntity {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late StealthSecurityAction sut;
  late ILocationServices locationServices;
  late IAudioRecordServices audioRecordServices;
  late IGuardianRepository guardianRepository;
  late SecurityModeActionFeature featureToggle;
  group(StealthSecurityAction, () {
    setUp(() {
      registerFallbackValue(UserLocationEntityFake());
      registerFallbackValue(const RequestLocationPermissionContentWidget());
      locationServices = MockLocationServices();
      audioRecordServices = MockAudioServices();
      guardianRepository = MockGuardianRepository();
      featureToggle = MockFeatureToggle();

      sut = StealthSecurityAction(
          locationService: locationServices,
          audioServices: audioRecordServices,
          guardianRepository: guardianRepository,
          featureToogle: featureToggle);
    });

    test('should get user location', () async {
      // arrange
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      when((() => locationServices.requestPermission(
              title: any(named: 'title'),
              description: any(named: 'description'))))
          .thenAnswer((_) async => const LocationPermissionState.granted());
      when((() => locationServices.isPermissionGranted()))
          .thenAnswer((_) async => true);
      when((() => locationServices.currentLocation()))
          .thenAnswer((_) async => right(const UserLocationEntity()));
      when(() => guardianRepository.alert(any()))
          .thenAnswer((_) async => right(const AlertModel(
                title: 'Alerta enviado!',
                message:
                    'Não há guardiões cadastrados! Nenhum alerta foi enviado.',
              )));
      when(() => featureToggle.audioDuration)
          .thenAnswer((_) async => const AudioRecordDurationEntity(3, 4));
      when(() => audioRecordServices.start()).thenAnswer((_) async {});
      when(() => audioRecordServices.rotate()).thenAnswer((_) async {});

      expectLater(sut.isRunning, emits(true));

      // act
      await sut.start();

      // assert
      verify(locationServices.currentLocation).called(1);
    });
  });
}
