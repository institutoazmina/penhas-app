import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/entities/user_location.dart';
import '../../../../core/entities/valid_fiel.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_server_configure.dart';
import '../../domain/entities/guardian_session_entity.dart';
import '../models/alert_model.dart';
import '../models/guardian_session_model.dart';

abstract class IGuardianDataSource {
  Future<GuardianSessionModel> fetch();
  Future<AlertModel> create(GuardianContactEntity? guardian);
  Future<ValidField> update(GuardianContactEntity? guardian);
  Future<ValidField> delete(GuardianContactEntity? guardian);
  Future<AlertModel> alert(UserLocationEntity? location);
  Future<ValidField> callPolice();
}

class GuardianDataSource implements IGuardianDataSource {
  GuardianDataSource({
    required http.Client apiClient,
    required IApiServerConfigure serverConfiguration,
  })  : _apiClient = apiClient,
        _serverConfiguration = serverConfiguration;

  final http.Client _apiClient;
  final IApiServerConfigure _serverConfiguration;
  final Set<int> _successfulResponse = {200, 204};
  final Set<int> _invalidSessionCode = {401, 403};

  @override
  Future<GuardianSessionModel> fetch() async {
    final httpHeader = await _setupHttpHeader();
    final httpRequest = await _setupHttpRequest(
      path: '/me/guardioes',
      queryParameters: {},
    );
    final response = await _apiClient.get(httpRequest, headers: httpHeader);

    if (_successfulResponse.contains(response.statusCode)) {
      return GuardianSessionModel.fromJson(jsonDecode(response.body));
    } else if (_invalidSessionCode.contains(response.statusCode)) {
      throw ApiProviderSessionError();
    } else {
      throw ApiProviderException(bodyContent: jsonDecode(response.body));
    }
  }

  @override
  Future<AlertModel> create(GuardianContactEntity? guardian) async {
    final httpHeader = await _setupHttpHeader();
    final httpRequest = await _setupHttpRequest(
      path: '/me/guardioes',
      queryParameters: {
        'nome': guardian!.name,
        'celular': guardian.mobile,
      },
    );
    final response = await _apiClient.post(
      httpRequest,
      headers: httpHeader,
    );

    if (_successfulResponse.contains(response.statusCode)) {
      return AlertModel.fromJson(jsonDecode(response.body));
    } else if (_invalidSessionCode.contains(response.statusCode)) {
      throw ApiProviderSessionError();
    } else {
      throw ApiProviderException(bodyContent: jsonDecode(response.body));
    }
  }

  @override
  Future<ValidField> update(GuardianContactEntity? guardian) async {
    final httpHeader = await _setupHttpHeader();
    final httpRequest = await _setupHttpRequest(
      path: '/me/guardioes/${guardian!.id}',
      queryParameters: {
        'nome': guardian.name,
      },
    );
    final response = await _apiClient.put(
      httpRequest,
      headers: httpHeader,
    );

    if (_successfulResponse.contains(response.statusCode)) {
      return ValidField.fromJson(jsonDecode(response.body));
    } else if (_invalidSessionCode.contains(response.statusCode)) {
      throw ApiProviderSessionError();
    } else {
      throw ApiProviderException(bodyContent: jsonDecode(response.body));
    }
  }

  @override
  Future<ValidField> delete(GuardianContactEntity? guardian) async {
    final httpHeader = await _setupHttpHeader();
    final httpRequest = await _setupHttpRequest(
      path: '/me/guardioes/${guardian!.id}',
      queryParameters: {},
    );
    final response = await _apiClient.delete(
      httpRequest,
      headers: httpHeader,
    );

    if (_successfulResponse.contains(response.statusCode)) {
      return const ValidField();
    } else if (_invalidSessionCode.contains(response.statusCode)) {
      throw ApiProviderSessionError();
    } else {
      throw ApiProviderException(bodyContent: jsonDecode(response.body));
    }
  }

  @override
  Future<AlertModel> alert(UserLocationEntity? location) async {
    final httpHeader = await _setupHttpHeader();
    final httpRequest = await _setupHttpRequest(
      path: '/me/guardioes/alert',
      queryParameters: {
        'gps_lat': location?.latitude.toString(),
        'gps_long': location?.longitude.toString()
      },
    );

    final response = await _apiClient.post(
      httpRequest,
      headers: httpHeader,
    );

    if (_successfulResponse.contains(response.statusCode)) {
      return AlertModel.fromJson(jsonDecode(response.body));
    } else if (_invalidSessionCode.contains(response.statusCode)) {
      throw ApiProviderSessionError();
    } else {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      if (jsonData['error'] == 'gps_position_invalid') {
        throw GuardianAlertGpsFailure();
      } else {
        throw ApiProviderException(bodyContent: jsonData);
      }
    }
  }

  @override
  Future<ValidField> callPolice() async {
    final httpHeader = await _setupHttpHeader();
    final httpRequest = await _setupHttpRequest(
      path: '/me/call-police-pressed',
      queryParameters: {},
    );
    final response = await _apiClient.post(
      httpRequest,
      headers: httpHeader,
    );

    if (_successfulResponse.contains(response.statusCode)) {
      return const ValidField();
    } else if (_invalidSessionCode.contains(response.statusCode)) {
      throw ApiProviderSessionError();
    } else {
      throw ApiProviderException(bodyContent: jsonDecode(response.body));
    }
  }

  Future<Map<String, String>> _setupHttpHeader() async {
    final userAgent = await _serverConfiguration.userAgent;
    final apiToken = await _serverConfiguration.apiToken;
    return {
      'X-Api-Key': apiToken ?? '',
      'User-Agent': userAgent,
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
    };
  }

  Future<Uri> _setupHttpRequest({
    required String path,
    required Map<String, String?> queryParameters,
  }) async {
    queryParameters.removeWhere((k, v) => v == null);
    return _serverConfiguration.baseUri.replace(
      path: path,
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    );
  }
}
