import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/features/help_center/data/models/alert_model.dart';
import 'package:penhas/app/features/help_center/data/repositories/guardian_repository.dart';
import 'package:penhas/app/features/zodiac/domain/usecases/stealth_security_action.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/core/managers/audio_record_services.dart';
import 'package:penhas/app/features/help_center/domain/usecases/security_mode_action_feature.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAudioServices extends Mock implements IAudioRecordServices {}

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
      GeolocatorPlatform.instance = MockGeolocatorPlatform();
      PermissionHandlerPlatform.instance = MockPermissionHandlerPlatform();
      locationServices = LocationServices();
      audioRecordServices = MockAudioServices();
      guardianRepository = MockGuardianRepository();
      featureToggle = MockFeatureToggle();

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

    test('should get user location', () async {
      // arrange
      final mockPermissionHandlerPlatform = PermissionHandlerPlatform.instance;
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      when((() => mockPermissionHandlerPlatform
              .checkPermissionStatus(Permission.locationWhenInUse)))
          .thenAnswer((_) async => PermissionStatus.granted);

      when((() => mockPermissionHandlerPlatform
              .checkPermissionStatus(Permission.location)))
          .thenAnswer((_) async => PermissionStatus.granted);

      when(() => guardianRepository.alert(any()))
          .thenAnswer((_) async => right(const AlertModel(
                title: 'Alerta enviado!',
                message:
                    'Não há guardiões cadastrado! Nenhum alerta foi enviado.',
              )));

      final result = await locationServices.currentLocation();
      debugPrint(result.toString());
      // act
      await sut.start();
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

class MockGeolocatorPlatform extends Mock
    with
        // ignore: prefer_mixin
        MockPlatformInterfaceMixin
    implements
        GeolocatorPlatform {
  @override
  Future<Position> getCurrentPosition(
      {LocationSettings? locationSettings}) async {
    return Position(
        longitude: -0.01,
        latitude: .01,
        timestamp: DateTime(2023, 2, 3, 9, 20),
        accuracy: 0.1,
        altitude: 100.01,
        heading: 1.1,
        speed: 12.0,
        speedAccuracy: 0.0);
  }
}

class MockPermissionHandlerPlatform extends Mock
    with
        // ignore: prefer_mixin
        MockPlatformInterfaceMixin
    implements
        PermissionHandlerPlatform {}
