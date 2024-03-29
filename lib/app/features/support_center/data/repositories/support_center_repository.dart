import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/entities/valid_fiel.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../../../shared/logger/log.dart';
import '../../../authentication/presentation/shared/map_exception_to_failure.dart';
import '../../../help_center/data/models/alert_model.dart';
import '../../domain/entities/geolocation_entity.dart';
import '../../domain/entities/support_center_fetch_request.dart';
import '../../domain/entities/support_center_metadata_entity.dart';
import '../../domain/entities/support_center_place_detail_entity.dart';
import '../../domain/entities/support_center_place_entity.dart';
import '../../domain/entities/support_center_place_session_entity.dart';
import '../models/geolocation_model.dart';
import '../models/support_center_metadata_model.dart';
import '../models/support_center_place_detail_model.dart';
import '../models/support_center_place_session_model.dart';

abstract class ISupportCenterRepository {
  Future<Either<Failure, SupportCenterMetadataEntity?>> metadata();
  Future<Either<Failure, SupportCenterPlaceSessionEntity>> fetch(
    SupportCenterFetchRequest? options,
  );
  Future<Either<Failure, GeolocationEntity>> mapGeoFromCep(String? cep);
  Future<Either<Failure, SupportCenterPlaceDetailEntity>> detail(
    SupportCenterPlaceEntity? placeEntity,
  );
  Future<Either<Failure, ValidField>> rate(
    SupportCenterPlaceEntity? place,
    double rate,
  );
  Future<Either<Failure, AlertModel>> suggestion({
    required String? name,
    required String? email,
    required String? address,
    required String category,
    required String? observation,
    required String? cep,
    required String? coverage,
    required String? complement,
    required String? neighborhood,
    required String? city,
    required String? uf,
    required String? number,
    required String? hour,
    required String? ddd1,
    required String? phone1,
    required String? ddd2,
    required String? phone2,
    required String? hasWhatsapp,
    required String? is24h,
  });
}

class SupportCenterRepository implements ISupportCenterRepository {
  SupportCenterRepository({
    required IApiProvider apiProvider,
  }) : _apiProvider = apiProvider;

  final IApiProvider _apiProvider;

  @override
  Future<Either<Failure, SupportCenterMetadataEntity?>> metadata() async {
    const endPoint = '/pontos-de-apoio-dados-auxiliares';
    final Map<String, String> parameters = {'projeto': 'Penhas'};

    try {
      final bodyResponse = await _apiProvider.get(
        path: endPoint,
        parameters: parameters,
      );
      return right(_parseMetadata(bodyResponse));
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, SupportCenterPlaceSessionEntity>> fetch(
    SupportCenterFetchRequest? options,
  ) async {
    const endPoint = 'me/pontos-de-apoio';

    try {
      final parameters = _parseRequestOptions(options);
      final bodyResponse = await _apiProvider.get(
        path: endPoint,
        parameters: parameters,
      );
      return right(_parseSupportCenter(bodyResponse));
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, GeolocationEntity>> mapGeoFromCep(String? cep) async {
    const endPoint = 'me/geocode';
    final Map<String, String?> parameters = {
      'address': cep,
    };

    try {
      final bodyResponse =
          await _apiProvider.get(path: endPoint, parameters: parameters);
      return right(_parseGeoFromCep(bodyResponse));
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, AlertModel>> suggestion({
    required String? name,
    required String? address,
    required String? email,
    required String category,
    required String? observation,
    required String? cep,
    required String? coverage,
    required String? complement,
    required String? neighborhood,
    required String? city,
    required String? uf,
    required String? number,
    required String? hour,
    required String? ddd1,
    required String? phone1,
    required String? ddd2,
    required String? phone2,
    required String? is24h,
    required String? hasWhatsapp,
  }) async {
    const endPoint = '/me/sugerir-pontos-de-apoio-completo';
    final bodyContent = [
      'nome=${Uri.encodeComponent(name!)}',
      'categoria=${Uri.encodeComponent(category)}',
      'nome_logradouro=${Uri.encodeComponent(address!)}',
      'observacao=${Uri.encodeComponent(observation!)}',
      'cep=${Uri.encodeComponent(cep!)}',
      'abrangencia=${Uri.encodeComponent(coverage!)}',
      'complemento=${Uri.encodeComponent(complement!)}',
      'bairro=${Uri.encodeComponent(neighborhood!)}',
      'municipio=${Uri.encodeComponent(city!)}',
      'uf=${Uri.encodeComponent(uf!)}',
      'email=${Uri.encodeComponent(email!)}',
      'numero=${Uri.encodeComponent(number!)}',
      'horario=${Uri.encodeComponent(hour!)}',
      'ddd1=${Uri.encodeComponent(ddd1!)}',
      'telefone1=${Uri.encodeComponent(phone1!)}',
      'ddd2=${Uri.encodeComponent(ddd2!)}',
      'telefone2=${Uri.encodeComponent(phone2!)}',
      'is24h=${Uri.encodeComponent(is24h!)}',
      'hasWhatsapp=${Uri.encodeComponent(hasWhatsapp!)}',
    ].join('&');

    try {
      final response = await _apiProvider.post(
        path: endPoint,
        body: bodyContent,
      );
      return right(_parseAddSuggestion(response));
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, SupportCenterPlaceDetailEntity>> detail(
    SupportCenterPlaceEntity? placeEntity,
  ) async {
    final endPoint = ['me', 'pontos-de-apoio', placeEntity!.id].join('/');

    try {
      final response = await _apiProvider.get(path: endPoint);
      return right(_parseDetail(response));
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ValidField>> rate(
    SupportCenterPlaceEntity? place,
    double rate,
  ) async {
    final endPoint = ['me', 'avaliar-pontos-de-apoio'].join('/');
    final parameters = <String, String>{};
    parameters['ponto_apoio_id'] = place!.id;
    parameters['rating'] = rate.toInt().toString();

    try {
      await _apiProvider.post(
        path: endPoint,
        parameters: parameters,
      );
      return right(const ValidField());
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  // Métodos privados

  Map<String, String?> _parseRequestOptions(
      SupportCenterFetchRequest? options) {
    final parameters = <String, String?>{
      'projeto': 'Penhas',
      'full_list': '1',
    };

    if (options == null) {
      return parameters;
    }

    if (options.locationToken != null) {
      parameters['location_token'] = options.locationToken;
    } else if (options.userLocation != null) {
      parameters['latitude'] = options.userLocation!.latitude.toString();
      parameters['longitude'] = options.userLocation!.longitude.toString();
    }

    if (options.categories != null && options.categories!.isNotEmpty) {
      parameters['categorias'] = options.categories!.join(',');
    }

    parameters['keywords'] =
        (options.keywords == null || options.keywords!.isEmpty)
            ? null
            : options.keywords;
    parameters['next_page'] = options.nextPage;

    return parameters;
  }

  SupportCenterMetadataEntity _parseMetadata(String body) {
    final jsonData = jsonDecode(body) as Map<String, dynamic>;
    return SupportCenterMetadataModel.fromJson(jsonData);
  }

  SupportCenterPlaceSessionEntity _parseSupportCenter(String body) {
    final jsonData = jsonDecode(body) as Map<String, dynamic>;
    return SupportCenterPlaceSessionModel.fromJson(jsonData);
  }

  GeolocationEntity _parseGeoFromCep(String body) {
    final jsonData = jsonDecode(body) as Map<String, dynamic>;
    return GeoLocationModel.fromJson(jsonData);
  }

  AlertModel _parseAddSuggestion(String body) {
    final jsonData = jsonDecode(body) as Map<String, dynamic>;
    return AlertModel.fromJson(jsonData);
  }

  SupportCenterPlaceDetailEntity _parseDetail(String body) {
    final jsonData = jsonDecode(body) as Map<String, dynamic>;
    return SupportCenterPlaceDetailModel.fromJson(jsonData);
  }
}
