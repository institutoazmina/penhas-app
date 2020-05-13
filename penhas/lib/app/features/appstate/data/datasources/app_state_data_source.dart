import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';

abstract class IAppStateDataSource {
  Future<AppStateModel> check();
}

class AppStateDataSource implements IAppStateDataSource {
  final http.Client _apiClient;
  final IApiServerConfigure _serverConfiguration;

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
    _apiClient.get(httpRequest, headers: httpHeader);
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
