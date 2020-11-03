import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cep.dart';
import 'package:penhas/app/features/support_center/data/repositories/support_center_repository.dart';
import 'package:penhas/app/features/support_center/domain/entities/geolocation_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_metadata_entity.dart';

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

  Future<Either<Failure, ValidField>> fetch() async {
    return _supportCenterRepository.fetch();
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

  Future<void> dataSource() {
    print('Ola mundo!');
  }
}
