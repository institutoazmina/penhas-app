import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_exception_to_failure.dart';
import 'package:penhas/app/features/support_center/data/models/geolocation_model.dart';
import 'package:penhas/app/features/support_center/data/models/support_center_metadata_model.dart';
import 'package:penhas/app/features/support_center/data/models/support_center_place_detail_model.dart';
import 'package:penhas/app/features/support_center/data/models/support_center_place_session_model.dart';
import 'package:penhas/app/features/support_center/domain/entities/geolocation_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_fetch_request.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_metadata_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_detail_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_session_entity.dart';

abstract class ISupportCenterRepository {
  Future<Either<Failure, SupportCenterMetadataEntity>> metadata();
  Future<Either<Failure, SupportCenterPlaceSessionEntity>> fetch(
      SupportCenterFetchRequest options);
  Future<Either<Failure, GeolocationEntity>> mapGeoFromCep(String cep);
  Future<Either<Failure, SupportCenterPlaceDetailEntity>> detail(
      SupportCenterPlaceEntity placeEntity);
  Future<Either<Failure, ValidField>> rate(
      SupportCenterPlaceEntity place, double rate);
  Future<Either<Failure, ValidField>> suggestion({
    @required String name,
    @required String address,
    @required String category,
    @required String description,
  });
}

class SupportCenterRepository implements ISupportCenterRepository {
  final IApiProvider _apiProvider;

  SupportCenterRepository({
    @required IApiProvider apiProvider,
  }) : this._apiProvider = apiProvider;

  @override
  Future<Either<Failure, SupportCenterMetadataEntity>> metadata() async {
    final endPoint = "/pontos-de-apoio-dados-auxiliares";
    Map<String, String> parameters = {'projeto': 'Penhas'};

    try {
      final bodyResponse = await _apiProvider.get(
        path: endPoint,
        parameters: parameters,
      );
      return right(parseMetadata(bodyResponse));
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, SupportCenterPlaceSessionEntity>> fetch(
      SupportCenterFetchRequest options) async {
    final endPoint = "me/pontos-de-apoio";

    Map<String, String> parameters = Map<String, String>();
    if (options.locationToken != null) {
      parameters["location_token"] = options.locationToken;
    } else if (options.userLocation != null &&
        options.userLocation.latitude != null &&
        options.userLocation.longitude != null) {
      parameters["latitude"] = options.userLocation.latitude.toString();
      parameters["longitude"] = options.userLocation.longitude.toString();
    }

    if (options.categories != null && options.categories.isNotEmpty) {
      parameters["categorias"] = options.categories.join(",");
    }

    parameters["keywords"] = options.keywords;
    parameters["next_page"] = options.nextPage;
    parameters["projeto"] = 'Penhas';

    try {
      final bodyResponse =
          await _apiProvider.get(path: endPoint, parameters: parameters);
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

  @override
  Future<Either<Failure, ValidField>> suggestion({
    @required String name,
    @required String address,
    @required String category,
    @required String description,
  }) async {
    final endPoint = "/me/sugerir-pontos-de-apoio";
    final bodyContent = {
      'nome': Uri.encodeComponent(name),
      'categoria': Uri.encodeComponent(category),
      'endereco_ou_cep': Uri.encodeComponent(address),
      'descricao_servico': Uri.encodeComponent(description),
    };

    try {
      final response = await _apiProvider.post(
        path: endPoint,
        body: bodyContent,
      );
      return right(parseAddSugestion(response));
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, SupportCenterPlaceDetailEntity>> detail(
      SupportCenterPlaceEntity placeEntity) async {
    final endPoint = ['me', 'pontos-de-apoio', placeEntity.id].join("/");

    try {
      final response = await _apiProvider.get(path: endPoint);
      return right(parseDetail(response));
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ValidField>> rate(
    SupportCenterPlaceEntity place,
    double rate,
  ) async {
    final endPoint = ['me', 'avaliar-pontos-de-apoio'].join("/");
    final parameters = Map<String, String>();
    parameters["ponto_apoio_id"] = place.id.toString();
    parameters["rating"] = rate.toInt().toString();

    try {
      await _apiProvider.post(
        path: endPoint,
        parameters: parameters,
      );
      return right(ValidField());
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

  SupportCenterPlaceSessionEntity parseSupportCenter(String body) {
    final jsonData = jsonDecode(body) as Map<String, Object>;
    return SupportCenterPlaceSessionModel.fromJson(jsonData);
  }

  GeolocationEntity parseGeoFromCep(String body) {
    final jsonData = jsonDecode(body) as Map<String, Object>;
    return GeoLocationModel.fromJson(jsonData);
  }

  ValidField parseAddSugestion(String body) {
    final jsonData = jsonDecode(body) as Map<String, Object>;
    return ValidField.fromJson(jsonData);
  }

  SupportCenterPlaceDetailEntity parseDetail(String body) {
    final jsonData = jsonDecode(body) as Map<String, Object>;
    return SupportCenterPlaceDetailModel.fromJson(jsonData);
  }
}