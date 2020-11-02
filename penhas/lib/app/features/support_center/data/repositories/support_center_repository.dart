import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_exception_to_failure.dart';
import 'package:penhas/app/features/support_center/data/models/geolocation_model.dart';
import 'package:penhas/app/features/support_center/data/models/support_center_metadata_model.dart';
import 'package:penhas/app/features/support_center/domain/entities/geolocation_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_metadata_entity.dart';

abstract class ISupportCenterRepository {
  Future<Either<Failure, SupportCenterMetadataEntity>> metadata();
  Future<Either<Failure, ValidField>> fetch();
  Future<Either<Failure, GeolocationEntity>> mapGeoFromCep(String cep);
}

class SupportCenterRepository implements ISupportCenterRepository {
  final IApiProvider _apiProvider;

  SupportCenterRepository({
    @required IApiProvider apiProvider,
  }) : this._apiProvider = apiProvider;

  @override
  Future<Either<Failure, SupportCenterMetadataEntity>> metadata() async {
    final endPoint = "/pontos-de-apoio-dados-auxiliares";

    try {
      final bodyResponse = await _apiProvider.get(path: endPoint);
      return right(parseMetadata(bodyResponse));
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ValidField>> fetch() async {
    final endPoint = "me/pontos-de-apoio";

    try {
      final bodyResponse = await _apiProvider.get(path: endPoint);
      return right(parseSupportCenter(bodyResponse));
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, GeolocationEntity>> mapGeoFromCep(String cep) async {
    final endPoint = "me/geocode";
    Map<String, String> parameters = {
      'address': cep,
    };

    try {
      final bodyResponse =
          await _apiProvider.get(path: endPoint, parameters: parameters);
      return right(parseGeoFromCep(bodyResponse));
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }
}

extension SupportCenterRepositoryPrivate on SupportCenterRepository {
  SupportCenterMetadataEntity parseMetadata(String body) {
    final jsonData = jsonDecode(body) as Map<String, Object>;
    return SupportCenterMetadataModel.fromJson(jsonData);
  }

  ValidField parseSupportCenter(String body) {
    final jsonData = jsonDecode(body) as Map<String, Object>;
    return ValidField();
  }

  GeolocationEntity parseGeoFromCep(String body) {
    final jsonData = jsonDecode(body) as Map<String, Object>;
    return GeoLocationModel.fromJson(jsonData);
  }
}
