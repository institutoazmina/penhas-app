import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cep.dart';
import 'package:penhas/app/features/support_center/data/repositories/support_center_repository.dart';
import 'package:penhas/app/features/support_center/domain/entities/geolocation_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_fetch_request.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_metadata_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_detail_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_session_entity.dart';

class SupportCenterUseCase {
  final ILocationServices _locationService;
  final ISupportCenterRepository _supportCenterRepository;
  GeolocationEntity _cachedGeoLocation;
  SupportCenterMetadataEntity _cacheMetadata;

  SupportCenterUseCase({
    @required ILocationServices locationService,
    @required ISupportCenterRepository supportCenterRepository,
  })  : this._locationService = locationService,
        this._supportCenterRepository = supportCenterRepository;

  Future<Either<Failure, SupportCenterMetadataEntity>> metadata() async {
    if (_cacheMetadata != null) {
      return right(_cacheMetadata);
    }

    final metadata = await _supportCenterRepository.metadata();
    _cacheMetadata = metadata.getOrElse(() => null);

    return metadata;
  }

  Future<Either<Failure, SupportCenterPlaceSessionEntity>> fetch(
      SupportCenterFetchRequest request) async {
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
      String title, Widget description) async {
    return _locationService
        .requestPermission(title: title, description: description)
        .then(
          (value) => value.maybeWhen(
            granted: () => true,
            orElse: () => false,
          ),
        );
  }

  bool updatedGeoLocation(GeolocationEntity selectedGeoLocation) {
    _cachedGeoLocation = selectedGeoLocation;
    return true;
  }

  Future<Either<Failure, ValidField>> saveSuggestion({
    @required String name,
    @required String address,
    @required String category,
    @required String description,
  }) {
    return _supportCenterRepository.suggestion(
      name: name,
      address: address,
      category: category,
      description: description,
    );
  }

  Future<Either<Failure, SupportCenterPlaceDetailEntity>> detail(
      SupportCenterPlaceEntity placeEntity) async {
    return _supportCenterRepository.detail(placeEntity);
  }
}

extension _PrivateMethods on SupportCenterUseCase {
  Future<bool> hasLocationPermission() async {
    final permissionStatus = await _locationService.permissionStatus();
    return permissionStatus.maybeWhen(
      granted: () => true,
      orElse: () => false,
    );
  }

  Future<GeolocationEntity> currentLocation() async {
    UserLocationEntity geoLocation;

    if (await hasLocationPermission()) {
      geoLocation = await _locationService.currentLocation().then(
            (v) => v.getOrElse(
              () => null,
            ),
          );
    }

    if (_cachedGeoLocation != null &&
        _cachedGeoLocation.locationToken != null) {
      return GeolocationEntity(locationToken: _cachedGeoLocation.locationToken);
    } else if (geoLocation != null) {
      return GeolocationEntity(userLocation: geoLocation);
    }

    return null;
  }
}
