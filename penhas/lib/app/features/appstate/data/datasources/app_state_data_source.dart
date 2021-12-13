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
  final http.Client _apiClient;
  final IApiServerConfigure _serverConfiguration;
  final Set<int> _successfulResponse = {200};
  final Set<int> _invalidSessionCode = {401, 403};

  AppStateDataSource({
    required http.Client apiClient,
    required serverConfiguration,
  })  : this._apiClient = apiClient,
        this._serverConfiguration = serverConfiguration;

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

    List<String?> parameters = [
      update.nickName == null
          ? null
          : 'apelido=' + Uri.encodeComponent(update.nickName!),
      update.minibio == null
          ? null
          : 'minibio=' + Uri.encodeComponent(update.minibio!),
      update.race == null ? null : 'raca=' + Uri.encodeComponent(update.race!),
      update.skills == null
          ? null
          : 'skills=' + Uri.encodeComponent(update.skills!.join(",")),
      update.oldPassword == null
          ? null
          : 'senha_atual=' + Uri.encodeComponent(update.oldPassword!),
      update.newPassword == null
          ? null
          : 'senha=' + Uri.encodeComponent(update.newPassword!),
      update.email == null
          ? null
          : 'email=' + Uri.encodeComponent(update.email!),
    ];

    parameters.removeWhere((e) => e == null);
    final bodyContent = parameters.join('&');

    final response = await _apiClient.put(httpRequest,
        headers: httpHeader, body: bodyContent);
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
      'X-Api-Key': apiToken ?? "",
      'User-Agent': userAgent,
      'Content-Type': 'application/json; charset=utf-8',
    };
  }
}
