import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/core/states/location_permission_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

void main() {
  late LocationServices locationServices;

  setUp(() {
    GeolocatorPlatform.instance = MockGeolocatorPlatform();
    PermissionHandlerPlatform.instance = MockPermissionHandlerPlatform();

    locationServices = LocationServices();
  });

  group(LocationServices, () {
    test(
      'currentLocation return a UserLocationEntity for PermissionStatus.granted',
      () async {
        // arrange
        final mockPermissionHandlerPlatform =
            PermissionHandlerPlatform.instance;
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

        final position = Position(
            longitude: -0.01,
            latitude: .01,
            timestamp: DateTime(2023, 2, 3, 9, 20),
            accuracy: 0.1,
            altitude: 100.01,
            heading: 1.1,
            speed: 12.0,
            speedAccuracy: 0.0);

        when((() => mockPermissionHandlerPlatform
                .checkPermissionStatus(Permission.location)))
            .thenAnswer((_) async => PermissionStatus.granted);

        // act
        final result = await locationServices.currentLocation();

        // assert
        expect(
          result.fold((l) => null, (r) => r),
          UserLocationEntity(
              latitude: position.latitude,
              longitude: position.longitude,
              accuracy: position.accuracy),
        );
      },
    );

    test(
      'currentLocation return a empty UserLocationEntity for not granted permission',
      () async {
        // arrange
        final mockPermissionHandlerPlatform =
            PermissionHandlerPlatform.instance;
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

        when((() => mockPermissionHandlerPlatform
                .checkPermissionStatus(Permission.location)))
            .thenAnswer((_) async => PermissionStatus.denied);

        // act
        final result = await locationServices.currentLocation();

        // assert
        expect(
          result.fold((l) => null, (r) => r),
          const UserLocationEntity(
            latitude: 0.0,
            longitude: 0.0,
            accuracy: 0.0,
          ),
        );
      },
    );

    test(
      'permissionStatus correct translate PermissionStatus to LocationPermissionState',
      () async {
        // arrange
        final permissionMap = {
          PermissionStatus.denied: LocationPermissionState.denied(),
          PermissionStatus.granted: LocationPermissionState.granted(),
          PermissionStatus.restricted: LocationPermissionState.restricted(),
          PermissionStatus.permanentlyDenied:
              LocationPermissionState.permanentlyDenied(),
          PermissionStatus.limited: LocationPermissionState.undefined(),
        };

        permissionMap.forEach((key, value) async {
          final mockPermissionHandlerPlatform =
              PermissionHandlerPlatform.instance;
          debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
          when((() => mockPermissionHandlerPlatform.checkPermissionStatus(
              Permission.locationWhenInUse))).thenAnswer((_) async => key);

          // act
          final result = await locationServices.permissionStatus();
          expect(result, value,
              reason: 'Expect value $value for permission status $key');
        });
      },
    );

    test(
      'isPermissionGranted return true for permission granted',
      () async {
        final mockPermissionHandlerPlatform =
            PermissionHandlerPlatform.instance;
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

        when((() => mockPermissionHandlerPlatform
                .checkPermissionStatus(Permission.locationWhenInUse)))
            .thenAnswer((_) async => PermissionStatus.granted);

        final result = await locationServices.isPermissionGranted();
        expect(result, isTrue);
      },
    );

    test(
      'isPermissionGranted return false for not granted permission',
      () async {
        final mockPermissionHandlerPlatform =
            PermissionHandlerPlatform.instance;
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

        when((() => mockPermissionHandlerPlatform
                .checkPermissionStatus(Permission.locationWhenInUse)))
            .thenAnswer((_) async => PermissionStatus.restricted);

        final result = await locationServices.isPermissionGranted();
        expect(result, isFalse);
      },
    );

    test(
      'requestPermission return a LocationPermissionState.granted for PermissionStatus.granted',
      () async {
        final mockPermissionHandlerPlatform =
            PermissionHandlerPlatform.instance;
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

        when((() => mockPermissionHandlerPlatform
                .checkPermissionStatus(Permission.locationWhenInUse)))
            .thenAnswer((_) async => PermissionStatus.granted);

        final locationServices = LocationServices();
        final result = await locationServices.requestPermission(
          title: '',
          description: Container(),
        );

        expect(result, LocationPermissionState.granted());
      },
    );

    test(
      'requestPermission return a LocationPermissionState.restricted for PermissionStatus.restricted',
      () async {
        final mockPermissionHandlerPlatform =
            PermissionHandlerPlatform.instance;
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

        when((() => mockPermissionHandlerPlatform
                .checkPermissionStatus(Permission.locationWhenInUse)))
            .thenAnswer((_) async => PermissionStatus.restricted);

        final locationServices = LocationServices();
        final result = await locationServices.requestPermission(
          title: '',
          description: Container(),
        );

        expect(result, LocationPermissionState.restricted());
      },
    );
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
