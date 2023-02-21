import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_server_configure.dart';
import '../../domain/entities/update_user_profile_entity.dart';
import '../model/app_state_model.dart';

abstract class IAppStateDataSource {
  Future<AppStateModel> check();
  Future<AppStateModel> update(UpdateUserProfileEntity update);
}

class AppStateDataSource implements IAppStateDataSource {
  AppStateDataSource({
    required http.Client apiClient,
    required IApiServerConfigure serverConfiguration,
  })  : _apiClient = apiClient,
        _serverConfiguration = serverConfiguration;

  final http.Client _apiClient;
  final IApiServerConfigure _serverConfiguration;
  final Set<int> _successfulResponse = {200};
  final Set<int> _invalidSessionCode = {401, 403};

  @override
  Future<AppStateModel> check() async {
    final httpHeader = await _setupHttpHeader();
    final httpRequest = _serverConfiguration.baseUri.replace(path: '/me');

    final response = await _apiClient.get(httpRequest, headers: httpHeader);
    if (_successfulResponse.contains(response.statusCode)) {
      return AppStateModel.fromJson(json.decode(response.body));
    } else if (_invalidSessionCode.contains(response.statusCode)) {
      throw ApiProviderSessionError();
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }

  @override
  Future<AppStateModel> update(UpdateUserProfileEntity update) async {
    final Map<String, String> httpHeader = await _setupHttpHeader();
    httpHeader['Content-Type'] =
        'application/x-www-form-urlencoded; charset=utf-8';

    final httpRequest = _serverConfiguration.baseUri.replace(path: '/me');
    final parameters = {
      'apelido': update.nickName,
      'minibio': update.minibio,
      'raca': update.race,
      'skills': update.skills?.join(','),
      'senha_atual': update.oldPassword,
      'senha': update.newPassword,
      'email': update.email,
    }..removeWhere((key, value) => value == null);

    final bodyContent = Uri(queryParameters: parameters).query;
    final response = await _apiClient.put(
      httpRequest,
      headers: httpHeader,
      body: bodyContent,
    );

    if (_successfulResponse.contains(response.statusCode)) {
      return AppStateModel.fromJson(json.decode(response.body));
    } else if (_invalidSessionCode.contains(response.statusCode)) {
      throw ApiProviderSessionError();
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }

  Future<Map<String, String>> _setupHttpHeader() async {
    final userAgent = await _serverConfiguration.userAgent;
    final apiToken = await _serverConfiguration.apiToken;
    return {
      'X-Api-Key': apiToken ?? '',
      'User-Agent': userAgent,
      'Content-Type': 'application/json; charset=utf-8',
    };
  }
}
