import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cep.dart';
import 'package:penhas/app/features/support_center/data/repositories/support_center_repository.dart';
import 'package:penhas/app/features/support_center/domain/entities/geolocation_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_fetch_request.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_metadata_entity.dart';
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
    return _supportCenterRepository.fetch(request);
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

  Future<void> dataSource() {
    print('Ola mundo!');
  }
}

extension _PrivateMethods on SupportCenterUseCase {
  Future<GeolocationEntity> geolocation() async {
    final geoLocation = await _locationService.currentLocation().then(
          (v) => v.getOrElse(() => null),
        );

    if (geoLocation != null) {
      return GeolocationEntity(userLocation: geoLocation);
    } else if (_cachedGeoLocation != null) {
      return GeolocationEntity(locationToken: _cachedGeoLocation.locationToken);
    }

    return GeolocationEntity();
  }
}
