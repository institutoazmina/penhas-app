import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/features/help_center/data/repositories/guardian_repository.dart';
import 'package:penhas/app/features/zodiac/domain/usecases/stealth_security_action.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/core/managers/audio_record_services.dart';
import 'package:penhas/app/features/help_center/domain/usecases/security_mode_action_feature.dart';

class MockAudioServices extends Mock implements IAudioRecordServices {}

class MockLocationServices extends Mock implements ILocationServices {}

class MockGuardianRepository extends Mock implements IGuardianRepository {}

class MockFeatureToggle extends Mock implements SecurityModeActionFeature {}

class MockGeolocator extends Mock implements Geolocator {}

void main() {
  late ILocationServices locationServices;
  late IAudioRecordServices audioRecordServices;
  late IGuardianRepository guardianRepository;
  late SecurityModeActionFeature featureToggle;
  group(StealthSecurityAction, () {
    late StealthSecurityAction sut;
    late UserLocationEntity userLocation;

    locationServices = MockLocationServices();
    audioRecordServices = MockAudioServices();
    guardianRepository = MockGuardianRepository();
    featureToggle = MockFeatureToggle();

    setUp(() {
      userLocation = const UserLocationEntity(latitude: 1.0, longitude: -1.0);
      sut = StealthSecurityAction(
          locationService: locationServices,
          audioServices: audioRecordServices,
          guardianRepository: guardianRepository,
          featureToogle: featureToggle);
    });

/*
  test('should record user message', () async {
      // arrange
      when(() => audioRecordServices.isPermissionGranted())
            .thenAnswer((_) async => true);
      // act
      final matcher = await sut.start();
      // assert
      // expect(actual, matcher);
    });

    */

    test('should get user location', () {
      // arrange
      final position = Position(
          latitude: 1.0,
          longitude: -1.0,
          accuracy: 1.0,
          altitude: 1.0,
          timestamp: DateTime.now(),
          speed: 1.0,
          speedAccuracy: 1.0,
          heading: 1.0);
      when(() => locationServices.isPermissionGranted())
          .thenAnswer((_) async => true);
      when(() => Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high))
          .thenAnswer((_) async => position);
      // act
      // final matcher = await sut.start();
      // assert
      // expect(actual, matcher);
    });


  /*
    test('should send sms to guardian', () {
      // arrange

      // act

      // assert
    });

    */
  });
}
