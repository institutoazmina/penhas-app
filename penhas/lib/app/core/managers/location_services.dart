import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/core/states/location_permission_state.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationFailure {}

abstract class ILocationServices {
  Future<Either<LocationFailure, UserLocationEntity>> currentLocation();
  Future<LocationPermissionState> requestPermission();
  Future<LocationPermissionState> permissionStatus();
}

class LocationServices implements ILocationServices {
  @override
  Future<Either<LocationFailure, UserLocationEntity>> currentLocation() async {
    if (await Permission.location.isGranted) {
      final position = await geo.getCurrentPosition(
          desiredAccuracy: geo.LocationAccuracy.high);

      return right(
        UserLocationEntity(
          latitude: position.latitude,
          longitude: position.longitude,
          accuracy: position.accuracy,
        ),
      );
    } else {
      return right(UserLocationEntity());
    }
  }

  @override
  Future<LocationPermissionState> permissionStatus() async {
    return Permission.location.status.then((value) => value.mapFrom());
  }

  @override
  Future<LocationPermissionState> requestPermission() async {
    return permissionStatus().then(
      (p) => p.when(
        granted: () => LocationPermissionState.granted(),
        denied: () => _requestDeniedPermission(),
        permanentlyDenied: () => _requestDeniedPermission(),
        restricted: () => LocationPermissionState.restricted(),
        undefined: () => _requestPermission(),
      ),
    );
  }

  Future<LocationPermissionState> _requestPermission() {
    return Modular.to
        .showDialog(
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Column(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: DesignSystemColors.easterPurple,
                    size: 48,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text('O guardião precisa da tua localização',
                        style: kTextStyleAlertDialogTitle),
                  ),
                ],
              ),
              content: RichText(
                text: TextSpan(
                  text: 'Quando uma guadiã é cadastrada, recomendamos que a ',
                  style: kTextStyleAlertDialogDescription,
                  children: [
                    TextSpan(
                      text: 'PenhaS ',
                      style: kTextStyleAlertDialogDescriptionBold,
                    ),
                    TextSpan(
                      text:
                          'seja autorizada a obter a tua localização. Esta informação será enviado para a guardiã quando o botão de ',
                      style: kTextStyleAlertDialogDescription,
                    ),
                    TextSpan(
                      text: 'Alerta Guardiões ',
                      style: kTextStyleAlertDialogDescriptionBold,
                    ),
                    TextSpan(
                      text: 'for acionado.',
                      style: kTextStyleAlertDialogDescription,
                    ),
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Agora não'),
                  onPressed: () async {
                    Modular.to.pop(LocationPermissionState.denied());
                  },
                ),
                SizedBox(
                  width: 120,
                  child: FlatButton(
                    color: DesignSystemColors.easterPurple,
                    child: Text('Sim claro!',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      Permission.locationWhenInUse
                          .request()
                          .then((value) => value.mapFrom())
                          .then((value) =>
                              _requestDeniedPermissionIfNeeded(value))
                          .then((value) => Modular.to.pop(value));
                    },
                  ),
                ),
              ],
            );
          },
        )
        .then((value) => value as LocationPermissionState)
        .catchError(
          (_) => LocationPermissionState.undefined(),
        );
  }

  Future<LocationPermissionState> _requestDeniedPermissionIfNeeded(
      LocationPermissionState state) async {
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
                children: <Widget>[
                  Icon(
                    Icons.location_off,
                    color: DesignSystemColors.easterPurple,
                    size: 48,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text('Localização bloqueada',
                        style: kTextStyleAlertDialogTitle),
                  ),
                ],
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
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
                      text: TextSpan(
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
                  child: Text('Não'),
                  onPressed: () async {
                    Modular.to.pop(LocationPermissionState.denied());
                  },
                ),
                SizedBox(
                  width: 120,
                  child: FlatButton(
                    color: DesignSystemColors.easterPurple,
                    child: Text('Sim', style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      openAppSettings().then(
                        (value) =>
                            Modular.to.pop(LocationPermissionState.undefined()),
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
          (_) => LocationPermissionState.undefined(),
        );
  }
}

extension PermissionStatusMap on PermissionStatus {
  LocationPermissionState mapFrom() {
    switch (this) {
      case PermissionStatus.denied:
        return LocationPermissionState.denied();
      case PermissionStatus.granted:
        return LocationPermissionState.granted();
      case PermissionStatus.restricted:
        return LocationPermissionState.restricted();
      case PermissionStatus.permanentlyDenied:
        return LocationPermissionState.permanentlyDenied();
      case PermissionStatus.undetermined:
        return LocationPermissionState.undefined();
    }

    return LocationPermissionState.undefined();
  }
}
