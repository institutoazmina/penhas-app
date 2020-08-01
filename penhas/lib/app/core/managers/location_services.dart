import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:location/location.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/core/states/location_permission_state.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class LocationFailure {}

abstract class ILocationServices {
  Future<Either<LocationFailure, UserLocation>> currentLocation();
  Future<LocationPermissionState> requestPermission();
  Future<LocationPermissionState> hasPermission();
}

class LocationServices implements ILocationServices {
  final Location _location = Location();

// bool _serviceEnabled;
//  _permissionGranted;
// LocationData _locationData;

// _serviceEnabled = await location.serviceEnabled();
// if (!_serviceEnabled) {
//   _serviceEnabled = await location.requestService();
//   if (!_serviceEnabled) {
//     return;
//   }
// }

// _permissionGranted = await location.hasPermission();
// if (_permissionGranted == PermissionStatus.denied) {
//   _permissionGranted = await location.requestPermission();
//   if (_permissionGranted != PermissionStatus.granted) {
//     return;
//   }
// }

// _locationData = await location.getLocation();

  @override
  Future<Either<LocationFailure, UserLocation>> currentLocation() {
    throw UnimplementedError();
  }

  @override
  Future<LocationPermissionState> hasPermission() async {
    return _location.hasPermission().then((value) => value.mapFrom());
  }

  @override
  Future<LocationPermissionState> requestPermission() async {
    return hasPermission().then(
      (p) => p.when(
        granted: () => LocationPermissionState.granted(),
        denied: () => _requestPermission(),
        deniedForever: () => _requestDeniedPermission(),
        undefined: () => LocationPermissionState.undefined(),
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
                FlatButton(
                  color: DesignSystemColors.easterPurple,
                  child:
                      Text('Sim claro!', style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    _location
                        .requestPermission()
                        .then((value) => value.mapFrom())
                        .then((value) => _requestDeniedPermissionIfNeed(value))
                        .then((value) => Modular.to.pop(value));
                  },
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

  Future<LocationPermissionState> _requestDeniedPermissionIfNeed(
      LocationPermissionState value) async {
    return value.maybeWhen(
      deniedForever: () async => _requestDeniedPermission(),
      orElse: () => value,
    );
  }

  Future<LocationPermissionState> _requestDeniedPermission() {
    Modular.to.showDialog();
  }
}

extension PermissionStatusMap on PermissionStatus {
  LocationPermissionState mapFrom() {
    switch (this) {
      case PermissionStatus.denied:
        return LocationPermissionState.denied();
      case PermissionStatus.deniedForever:
        return LocationPermissionState.deniedForever();
      case PermissionStatus.granted:
        return LocationPermissionState.granted();
      default:
        return LocationPermissionState.undefined();
    }
  }
}
