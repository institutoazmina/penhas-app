import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';

abstract class IAppStateDataSource {
  Future<AppStateModel> check();
}

class AppStateDataSource implements IAppStateDataSource {
  final http.Client _apiClient;
  final IApiServerConfigure _serverConfiguration;
  final Set<int> _successfulResponse = {200};
  final Set<int> _invalidSessionCode = {401, 403};

  AppStateDataSource({
    @required http.Client apliClient,
    @required serverConfiguration,
  })  : this._apiClient = apliClient,
        this._serverConfiguration = serverConfiguration;

  @override
  Future<AppStateModel> check() async {
    final httpHeader = await _setupHttpHeader();
    final httpRequest = Uri(
        scheme: _serverConfiguration.baseUri.scheme,
        host: _serverConfiguration.baseUri.host,
        path: '/me');

    final response = await _apiClient.get(httpRequest, headers: httpHeader);
    if (_successfulResponse.contains(response.statusCode)) {
      return AppStateModel.fromJson(json.decode(response.body));
    } else if (_invalidSessionCode.contains(response.statusCode)) {
      throw ApiProviderSessionExpection();
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }

  Future<Map<String, String>> _setupHttpHeader() async {
    final userAgent = await _serverConfiguration.userAgent;
    final apiToken = await _serverConfiguration.apiToken;
    return {
      'X-Api-Key': apiToken,
      'User-Agent': userAgent,
      'Content-Type': 'application/json; charset=utf-8',
    };
  }
}
