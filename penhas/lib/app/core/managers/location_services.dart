import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/core/extension/asuka.dart';
import 'package:penhas/app/core/states/location_permission_state.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';
import 'package:penhas/app/shared/logger/log.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationFailure {}

abstract class ILocationServices {
  Future<Either<LocationFailure, UserLocationEntity?>> currentLocation();
  Future<LocationPermissionState> requestPermission({
    required String title,
    required Widget description,
  });
  Future<LocationPermissionState> permissionStatus();
  Future<bool> isPermissionGranted();
}

class LocationServices implements ILocationServices {
  @override
  Future<Either<LocationFailure, UserLocationEntity?>> currentLocation() async {
    if (await Permission.location.isGranted) {
      final position = await Geolocator.getCurrentPosition(
<<<<<<< HEAD
        desiredAccuracy: LocationAccuracy.high,
      );
=======
          desiredAccuracy: LocationAccuracy.high);
>>>>>>> Fix code syntax

      return right(
        UserLocationEntity(
          latitude: position.latitude,
          longitude: position.longitude,
          accuracy: position.accuracy,
        ),
      );
    } else {
      return right(const UserLocationEntity());
    }
  }

  @override
  Future<LocationPermissionState> permissionStatus() async {
    final status = await Permission.locationWhenInUse.status;
    final mapper = status.mapFrom();
    return mapper;
  }

  @override
  Future<LocationPermissionState> requestPermission({
    required String title,
    required Widget description,
  }) async {
    return permissionStatus().then(
      (p) => p.when(
        granted: () => const LocationPermissionState.granted(),
        denied: () => _requestPermission(title, description),
        permanentlyDenied: () => _requestDeniedPermission(),
        restricted: () => const LocationPermissionState.restricted(),
        undefined: () => _requestPermission(title, description),
      ),
    );
  }

  @override
  Future<bool> isPermissionGranted() => Permission.locationWhenInUse.isGranted;

  Future<LocationPermissionState> _requestPermission(
    String title,
    Widget description,
  ) {
    return Modular.to
        .showDialog(
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Column(
                children: <Widget>[
                  const Icon(
                    Icons.location_on,
                    color: DesignSystemColors.easterPurple,
                    size: 48,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(title, style: kTextStyleAlertDialogTitle),
                  ),
                ],
              ),
              content: description,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              actions: <Widget>[
                FlatButton(
                  child: const Text('Agora não'),
                  onPressed: () async {
                    Navigator.of(context)
                        .pop(const LocationPermissionState.denied());
                  },
                ),
                SizedBox(
                  width: 120,
                  child: FlatButton(
                    color: DesignSystemColors.easterPurple,
                    child: const Text(
                      'Sim claro!',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      Permission.locationWhenInUse
                          .request()
                          .then((value) => value.mapFrom())
                          .then(
                            (value) => _requestDeniedPermissionIfNeeded(value),
                          )
                          .then((value) => Navigator.of(context).pop(value));
                    },
                  ),
                ),
              ],
            );
          },
        )
        .then((value) => value as LocationPermissionState)
        .catchError(
      (e, stack) {
        logError(e, stack);
        return const LocationPermissionState.undefined();
      },
    );
  }

  Future<LocationPermissionState> _requestDeniedPermissionIfNeeded(
    LocationPermissionState state,
  ) async {
    return state.maybeWhen(
      permanentlyDenied: () => _requestDeniedPermission(),
      orElse: () => state,
    );
  }

  Future<LocationPermissionState> _requestDeniedPermission() {
    return Modular.to
        .showDialog(
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Column(
                children: const <Widget>[
                  Icon(
                    Icons.location_off,
                    color: DesignSystemColors.easterPurple,
                    size: 48,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: Text(
                      'Localização bloqueada',
                      style: kTextStyleAlertDialogTitle,
                    ),
                  ),
                ],
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RichText(
                    text: const TextSpan(
                      text: 'O acesso a tua ',
                      style: kTextStyleAlertDialogDescription,
                      children: [
                        TextSpan(
                          text: 'localização está bloqueada',
                          style: kTextStyleAlertDialogDescriptionBold,
                        ),
                        TextSpan(
                          text:
                              '. Agora a autorização precisa ser realizada manualmente.',
                          style: kTextStyleAlertDialogDescription,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: RichText(
                      text: const TextSpan(
                        text: 'Você quer liberar o acesso agora?',
                        style: kTextStyleAlertDialogDescriptionBold,
                      ),
                    ),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              actions: <Widget>[
                FlatButton(
                  child: const Text('Não'),
                  onPressed: () async {
                    Navigator.of(context)
                        .pop(const LocationPermissionState.denied());
                  },
                ),
                SizedBox(
                  width: 120,
                  child: FlatButton(
                    color: DesignSystemColors.easterPurple,
                    child: const Text(
                      'Sim',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      openAppSettings().then(
                        (value) => Navigator.of(context)
                            .pop(const LocationPermissionState.undefined()),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        )
        .then((value) => value as LocationPermissionState)
        .catchError(
      (e, stack) {
        logError(e, stack);
        return const LocationPermissionState.undefined();
      },
    );
  }
}

extension PermissionStatusMap on PermissionStatus {
  LocationPermissionState mapFrom() {
    switch (this) {
      case PermissionStatus.denied:
        return const LocationPermissionState.denied();
      case PermissionStatus.granted:
        return const LocationPermissionState.granted();
      case PermissionStatus.restricted:
        return const LocationPermissionState.restricted();
      case PermissionStatus.permanentlyDenied:
<<<<<<< HEAD
        return const LocationPermissionState.permanentlyDenied();
      case PermissionStatus.limited:
        return const LocationPermissionState.undefined();
=======
        return LocationPermissionState.permanentlyDenied();
      case PermissionStatus.limited:
        return LocationPermissionState.undefined();
>>>>>>> Fix code syntax
    }
  }
}
