import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/feed/data/models/tweet_filter_session_model.dart';

abstract class ITweetFilterPreferenceDataSource {
  Future<TweetFilterSessionModel> fetch();
}

class TweetFilterPreferenceDataSource
    implements ITweetFilterPreferenceDataSource {
  final http.Client? _apiClient;
  final IApiServerConfigure? _serverConfiguration;
  final Set<int> _successfulResponse = {200, 204};
  final Set<int> _invalidSessionCode = {401, 403};

  TweetFilterPreferenceDataSource({
    required http.Client? apiClient,
    required IApiServerConfigure? serverConfiguration,
  })  : this._apiClient = apiClient,
        this._serverConfiguration = serverConfiguration;

  @override
  Future<TweetFilterSessionModel> fetch() async {
    final httpHeader = await _setupHttpHeader();
    final httpRequest = await _setupHttpRequest(
      path: '/filter-tags',
      queryParameters: {},
    );

    final response = await _apiClient!.get(httpRequest, headers: httpHeader);
    if (_successfulResponse.contains(response.statusCode)) {
      return TweetFilterSessionModel.fromJson(json.decode(response.body));
    } else if (_invalidSessionCode.contains(response.statusCode)) {
      throw ApiProviderSessionError();
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }

  Future<Map<String, String>> _setupHttpHeader() async {
    final userAgent = await _serverConfiguration!.userAgent;
    final apiToken = await _serverConfiguration!.apiToken;
    return {
      'X-Api-Key': apiToken ?? '',
      'User-Agent': userAgent,
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
    };
  }

  Future<Uri> _setupHttpRequest({
    required String path,
    required Map<String, String> queryParameters,
  }) async {
    queryParameters.removeWhere((k, v) => v == null);
    return _serverConfiguration!.baseUri.replace(
      path: path,
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    );
  }
}
