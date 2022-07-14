import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cep.dart';
import 'package:penhas/app/features/help_center/data/models/alert_model.dart';
import 'package:penhas/app/features/support_center/data/repositories/support_center_repository.dart';
import 'package:penhas/app/features/support_center/domain/entities/geolocation_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_fetch_request.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_metadata_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_detail_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_session_entity.dart';

class SupportCenterUseCase {
  SupportCenterUseCase({
    required ILocationServices locationService,
    required ISupportCenterRepository supportCenterRepository,
  })  : _locationService = locationService,
        _supportCenterRepository = supportCenterRepository;

  final ILocationServices _locationService;
  final ISupportCenterRepository _supportCenterRepository;
  GeolocationEntity? _cachedGeoLocation;
  SupportCenterMetadataEntity? _cacheMetadata;

  Future<Either<Failure, SupportCenterMetadataEntity?>> metadata() async {
    if (_cacheMetadata != null) {
      return right(_cacheMetadata);
    }

    final metadata = await _supportCenterRepository.metadata();
    _cacheMetadata = metadata.getOrElse(() => null);

    return metadata;
  }

  Future<Either<Failure, SupportCenterPlaceSessionEntity>> fetch(
    SupportCenterFetchRequest request,
  ) async {
    var currentRequest = request;
    final location = await currentLocation();
    if (location != null) {
      currentRequest = request.copyWith(
        userLocation: location.userLocation,
        locationToken: location.locationToken,
      );
    }

    return _supportCenterRepository.fetch(currentRequest);
  }

  Future<Either<Failure, GeolocationEntity>> mapGeoFromCep(Cep cep) async {
    return _supportCenterRepository.mapGeoFromCep(cep.rawValue);
  }

  Future<bool> askForLocationPermission(
    String title,
    Widget description,
  ) async {
    return _locationService
        .requestPermission(title: title, description: description)
        .then(
          (value) => value.maybeWhen(
            granted: () => true,
            orElse: () => false,
          ),
        );
  }

  bool updatedGeoLocation(GeolocationEntity? selectedGeoLocation) {
    _cachedGeoLocation = selectedGeoLocation;
    return true;
  }

  Future<Either<Failure, AlertModel>> saveSuggestion({
    required String? name,
    required String? address,
    required String? email,
    required String category,
    required String? cep,
    required String? coverage,
    required String? complement,
    required String? neighborhood,
    required String? city,
    required String? uf,
    required String? number,
    required String? observation,
    required String? hour,
    required String? ddd1,
    required String? phone1,
    required String? ddd2,
    required String? phone2,
  }) {
    return _supportCenterRepository.suggestion(
      name: name,
      address: address,
      email: email,
      category: category,
      cep: cep,
      coverage: coverage,
      complement: complement,
      neighborhood: neighborhood,
      city: city,
      number: number,
      uf: uf,
      observation: observation,
      hour: hour,
      ddd1: ddd1,
      phone1: phone1,
      ddd2: ddd2,
      phone2: phone2,
    );
  }

  Future<Either<Failure, SupportCenterPlaceDetailEntity>> detail(
    SupportCenterPlaceEntity? placeEntity,
  ) async {
    return _supportCenterRepository.detail(placeEntity);
  }

  Future<Either<Failure, ValidField>> rating({
    required SupportCenterPlaceEntity? place,
    required double rate,
  }) async {
    return _supportCenterRepository.rate(place, rate);
  }
}

extension _PrivateMethods on SupportCenterUseCase {
  Future<bool> hasLocationPermission() {
    return _locationService.isPermissionGranted();
  }

  Future<GeolocationEntity?> currentLocation() async {
    UserLocationEntity? geoLocation;
    final hasPermission = await hasLocationPermission();

    if (hasPermission) {
      geoLocation = await _locationService.currentLocation().then(
            (v) => v.getOrElse(
              () => null,
            ),
          );
    }

    if (_cachedGeoLocation != null &&
        _cachedGeoLocation!.locationToken != null) {
      return GeolocationEntity(
        locationToken: _cachedGeoLocation!.locationToken,
      );
    } else if (geoLocation != null) {
      return GeolocationEntity(userLocation: geoLocation);
    }

    return null;
  }
}
