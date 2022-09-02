import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';
import 'package:penhas/app/features/appstate/domain/entities/update_user_profile_entity.dart';

abstract class IAppStateDataSource {
  Future<AppStateModel> check();
  Future<AppStateModel> update(UpdateUserProfileEntity update);
}

class AppStateDataSource implements IAppStateDataSource {
  AppStateDataSource({
    required http.Client apiClient,
    required serverConfiguration,
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

    final List<String?> parameters = [
      if (update.nickName == null) null else 'apelido=${Uri.encodeComponent(update.nickName!)}',
      if (update.minibio == null) null else 'minibio=${Uri.encodeComponent(update.minibio!)}',
      if (update.race == null) null else 'raca=${Uri.encodeComponent(update.race!)}',
      if (update.skills == null) null else 'skills=${Uri.encodeComponent(update.skills!.join(","))}',
      if (update.oldPassword == null) null else 'senha_atual=${Uri.encodeComponent(update.oldPassword!)}',
      if (update.newPassword == null) null else 'senha=${Uri.encodeComponent(update.newPassword!)}',
      if (update.email == null) null else 'email=${Uri.encodeComponent(update.email!)}',
    ];

    parameters.removeWhere((e) => e == null);
    final bodyContent = parameters.join('&');

    final response = await _apiClient.put(httpRequest,
        headers: httpHeader, body: bodyContent,);
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
