import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/help_center/data/models/guardian_session_model.dart';
import 'package:penhas/app/features/help_center/domain/entities/guardian_session_entity.dart';

abstract class IGuardianDataSource {
  Future<GuardianSessionModel> fetch();
  Future<ValidField> create(GuardianContactEntity guardian);
  Future<ValidField> update(GuardianContactEntity guardian);
  Future<ValidField> delete(GuardianContactEntity guardian);
}

class GuardianDataSource implements IGuardianDataSource {
  final http.Client _apiClient;
  final IApiServerConfigure _serverConfiguration;
  final Set<int> _successfulResponse = {200, 204};
  final Set<int> _invalidSessionCode = {401, 403};

  GuardianDataSource({
    @required http.Client apiClient,
    @required serverConfiguration,
  })  : this._apiClient = apiClient,
        this._serverConfiguration = serverConfiguration;

  @override
  Future<GuardianSessionModel> fetch() async {
    final httpHeader = await _setupHttpHeader();
    final httpRequest = await _setupHttpRequest(
      path: '/me/guardioes',
      queryParameters: {},
    );
    final response = await _apiClient.get(httpRequest, headers: httpHeader);

    if (_successfulResponse.contains(response.statusCode)) {
      return GuardianSessionModel.fromJson(json.decode(response.body));
    } else if (_invalidSessionCode.contains(response.statusCode)) {
      throw ApiProviderSessionExpection();
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }

  @override
  Future<ValidField> create(GuardianContactEntity guardian) async {
    final httpHeader = await _setupHttpHeader();
    final httpRequest = await _setupHttpRequest(
      path: '/me/guardioes',
      queryParameters: {
        'nome': guardian.name,
        'celular': guardian.mobile,
      },
    );
    final response = await _apiClient.post(
      httpRequest,
      headers: httpHeader,
    );

    if (_successfulResponse.contains(response.statusCode)) {
      return ValidField.fromJson(json.decode(response.body));
    } else if (_invalidSessionCode.contains(response.statusCode)) {
      throw ApiProviderSessionExpection();
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }

  @override
  Future<ValidField> update(GuardianContactEntity guardian) async {
    final httpHeader = await _setupHttpHeader();
    final httpRequest = await _setupHttpRequest(
      path: '/me/guardioes/${guardian.id}',
      queryParameters: {
        'nome': guardian.name,
      },
    );
    final response = await _apiClient.put(
      httpRequest,
      headers: httpHeader,
    );

    if (_successfulResponse.contains(response.statusCode)) {
      return ValidField.fromJson(json.decode(response.body));
    } else if (_invalidSessionCode.contains(response.statusCode)) {
      throw ApiProviderSessionExpection();
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }

  @override
  Future<ValidField> delete(GuardianContactEntity guardian) {
    throw UnimplementedError();
  }

  Future<Map<String, String>> _setupHttpHeader() async {
    final userAgent = await _serverConfiguration.userAgent;
    final apiToken = await _serverConfiguration.apiToken;
    return {
      'X-Api-Key': apiToken,
      'User-Agent': userAgent,
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
    };
  }

  Future<Uri> _setupHttpRequest({
    @required String path,
    @required Map<String, String> queryParameters,
  }) async {
    queryParameters.removeWhere((k, v) => v == null);
    return Uri(
      scheme: _serverConfiguration.baseUri.scheme,
      host: _serverConfiguration.baseUri.host,
      path: path,
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    );
  }
}
