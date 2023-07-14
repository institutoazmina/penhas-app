import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_server_configure.dart';
import '../models/tweet_filter_session_model.dart';

abstract class ITweetFilterPreferenceDataSource {
  Future<TweetFilterSessionModel> fetch();
}

class TweetFilterPreferenceDataSource
    implements ITweetFilterPreferenceDataSource {
  TweetFilterPreferenceDataSource({
    required http.Client? apiClient,
    required IApiServerConfigure? serverConfiguration,
  })  : _apiClient = apiClient,
        _serverConfiguration = serverConfiguration;

  final http.Client? _apiClient;
  final IApiServerConfigure? _serverConfiguration;
  final Set<int> _successfulResponse = {200, 204};
  final Set<int> _invalidSessionCode = {401, 403};

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
    return _serverConfiguration!.baseUri.replace(
      path: path,
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    );
  }
}
