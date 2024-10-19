import 'package:asuka/asuka.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/core/states/location_permission_state.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../../../utils/golden_tests.dart';
import '../../../utils/widget_test_steps.dart';

void main() {
  late LocationServices locationServices;
  late PermissionHandlerPlatform mockPermissionHandlerPlatform;

  setUp(() {
    GeolocatorPlatform.instance = MockGeolocatorPlatform();
    PermissionHandlerPlatform.instance =
        mockPermissionHandlerPlatform = MockPermissionHandlerPlatform();

    locationServices = LocationServices();
  });

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
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
          result.fold((l) => l, (r) => r),
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
          result.fold((l) => l, (r) => r),
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
          PermissionStatus.denied: const LocationPermissionState.denied(),
          PermissionStatus.granted: const LocationPermissionState.granted(),
          PermissionStatus.restricted:
              const LocationPermissionState.restricted(),
          PermissionStatus.permanentlyDenied:
              const LocationPermissionState.permanentlyDenied(),
          PermissionStatus.limited: const LocationPermissionState.undefined(),
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

    group(
      'requestPermission()',
      () {
        test(
          'return a LocationPermissionState.granted for PermissionStatus.granted',
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

            expect(result, const LocationPermissionState.granted());
          },
        );

        test(
          'return a LocationPermissionState.restricted for PermissionStatus.restricted',
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

            expect(result, const LocationPermissionState.restricted());
          },
        );

        testWidgets(
          'should request for location permission when limited',
          (tester) async {
            // arrange
            when(
              () => mockPermissionHandlerPlatform
                  .checkPermissionStatus(Permission.locationWhenInUse),
            ).thenAnswer((_) async => PermissionStatus.limited);

            await theAppIsRunning(tester, Container());

            // act
            locationServices.requestPermission(
              title: 'Acesso a localização',
              description: Container(),
            );
            await tester.pumpAndSettle();

            // assert
            await iSeeText('Acesso a localização');
          },
        );

        testWidgets(
          'should request for location permission when denied',
          (tester) async {
            // arrange
            when(
              () => mockPermissionHandlerPlatform
                  .checkPermissionStatus(Permission.locationWhenInUse),
            ).thenAnswer((_) async => PermissionStatus.denied);

            await theAppIsRunning(tester, Container());

            // act
            locationServices.requestPermission(
              title: 'Acesso a localização',
              description: Container(),
            );
            await tester.pumpAndSettle();

            // assert
            await iSeeText('Acesso a localização');
          },
        );

        testWidgets(
          'should return denied when "Agora não" is pressed',
          (tester) async {
            // arrange
            when(
              () => mockPermissionHandlerPlatform
                  .checkPermissionStatus(Permission.locationWhenInUse),
            ).thenAnswer((_) async => PermissionStatus.denied);

            await theAppIsRunning(tester, Container());

            // act
            final result = locationServices.requestPermission(
              title: 'Acesso a localização',
              description: Container(),
            );
            await tester.pumpAndSettle();
            await iTapButton(tester, 'Agora não');

            // assert
            expectLater(
              result,
              completion(LocationPermissionState.denied()),
            );
          },
        );

        testWidgets(
          'should return granted when "Sim claro!" is pressed',
          (tester) async {
            // arrange
            when(
              () => mockPermissionHandlerPlatform
                  .checkPermissionStatus(Permission.locationWhenInUse),
            ).thenAnswer((_) async => PermissionStatus.denied);
            when(
              () => mockPermissionHandlerPlatform
                  .requestPermissions([Permission.locationWhenInUse]),
            ).thenAnswer(
              (_) async =>
                  {Permission.locationWhenInUse: PermissionStatus.granted},
            );

            await theAppIsRunning(tester, Container());

            // act
            final result = locationServices.requestPermission(
              title: 'Acesso a localização',
              description: Container(),
            );
            await tester.pumpAndSettle();
            await iTapButton(tester, 'Sim claro!');

            // assert
            expectLater(
              result,
              completion(LocationPermissionState.granted()),
            );
          },
        );

        testWidgets(
          'should show new dialog when "Sim claro!" is pressed and is permanently denied',
          (tester) async {
            // arrange
            when(
              () => mockPermissionHandlerPlatform
                  .checkPermissionStatus(Permission.locationWhenInUse),
            ).thenAnswer((_) async => PermissionStatus.denied);
            when(
              () => mockPermissionHandlerPlatform
                  .requestPermissions([Permission.locationWhenInUse]),
            ).thenAnswer(
              (_) async => {
                Permission.locationWhenInUse:
                    PermissionStatus.permanentlyDenied,
              },
            );

            await theAppIsRunning(tester, Container());

            // act
            locationServices.requestPermission(
              title: 'Acesso a localização',
              description: Container(),
            );
            await tester.pumpAndSettle();
            await iTapButton(tester, 'Sim claro!');
            await tester.pumpAndSettle();

            // assert
            await iSeeText('Localização bloqueada');
          },
        );

        testWidgets(
          'should request for microphone permission when permanentlyDenied',
          (tester) async {
            // arrange
            when(
              () => mockPermissionHandlerPlatform
                  .checkPermissionStatus(Permission.locationWhenInUse),
            ).thenAnswer((_) async => PermissionStatus.permanentlyDenied);

            await theAppIsRunning(tester, Container());

            // act
            locationServices.requestPermission(
              title: 'Acesso a localização',
              description: Container(),
            );
            await tester.pumpAndSettle();

            // assert
            await iSeeText('Localização bloqueada');
          },
        );

        testWidgets(
          'should return denied when "Não" is pressed',
          (tester) async {
            // arrange
            when(
              () => mockPermissionHandlerPlatform
                  .checkPermissionStatus(Permission.locationWhenInUse),
            ).thenAnswer((_) async => PermissionStatus.permanentlyDenied);

            await theAppIsRunning(tester, Container());

            // act
            final result = locationServices.requestPermission(
              title: 'Acesso a localização',
              description: Container(),
            );
            await tester.pumpAndSettle();
            await iTapButton(tester, 'Não');

            // assert
            expectLater(
              result,
              completion(LocationPermissionState.denied()),
            );
          },
        );

        testWidgets(
          'should return undefined when "Sim" is pressed',
          (tester) async {
            // arrange
            when(
              () => mockPermissionHandlerPlatform
                  .checkPermissionStatus(Permission.locationWhenInUse),
            ).thenAnswer((_) async => PermissionStatus.permanentlyDenied);
            when(() => mockPermissionHandlerPlatform.openAppSettings())
                .thenAnswer((_) async => true);

            await theAppIsRunning(tester, Container());

            // act
            final result = locationServices.requestPermission(
              title: 'Acesso a localização',
              description: Container(),
            );
            await tester.pumpAndSettle();
            await iTapButton(tester, 'Sim');

            // assert
            expectLater(
              result,
              completion(LocationPermissionState.undefined()),
            );
          },
        );
      },
    );

    group('golden', () {
      [
        PermissionStatus.denied,
        PermissionStatus.permanentlyDenied,
        PermissionStatus.limited,
      ].forEach((status) {
        screenshotTest(
          'requestPermission() should request for location permission when ${status.name}',
          fileName:
              'location_services_test_requestPermission_dialog_${status.name}',
          devices: [testDevices.first],
          transitionBuilder: Asuka.builder,
          setUp: () async {
            when(
              () => mockPermissionHandlerPlatform
                  .checkPermissionStatus(Permission.locationWhenInUse),
            ).thenAnswer((_) async => status);
          },
          pageBuilder: () => FutureBuilder(
            future: locationServices.requestPermission(
              title: 'Localização',
              description: Text(
                'Permitindo que a PenhaS tenha acesso a sua localização, será possível apresentar os pontos de apoio mais próximo da onde você está.',
                style: TextStyle(
                  color: DesignSystemColors.darkIndigoThree,
                  fontFamily: 'Lato',
                  fontSize: 14.0,
                  letterSpacing: 0.45,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            builder: (_, __) => Container(),
          ),
        );
      });
    });
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
