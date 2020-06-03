import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/feed/data/models/tweet_session_model.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_engage_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_request_option.dart';

abstract class ITweetDataSource {
  Future<TweetSessionMondel> retrieve({@required TweetRequestOption option});
  Future<ValidField> report({@required TweetEngageRequestOption option});
}

class TweetDataSource implements ITweetDataSource {
  final http.Client _apiClient;
  final IApiServerConfigure _serverConfiguration;
  final Set<int> _successfulResponse = {200};
  final Set<int> _invalidSessionCode = {401, 403};

  TweetDataSource({
    @required http.Client apiClient,
    @required serverConfiguration,
  })  : this._apiClient = apiClient,
        this._serverConfiguration = serverConfiguration;

  @override
  Future<TweetSessionMondel> retrieve({
    @required TweetRequestOption option,
  }) async {
    final httpHeader = await _setupHttpHeader();

    Map<String, String> queryParameters = {
      'after': option.after,
      'before': option.before,
      'only_myself': option.onlyMyself ? '1' : '0',
      'skip_myself': option.skipMyself ? '1' : '0',
      'rows': "${option.rows}",
      'reply_to': option.replyTo,
    };

    final httpRequest = await _setupHttpRequest(
      path: '/timeline',
      queryParameters: queryParameters,
    );

    final response = await _apiClient.get(httpRequest, headers: httpHeader);
    if (_successfulResponse.contains(response.statusCode)) {
      return TweetSessionMondel.fromJson(json.decode(response.body));
    } else if (_invalidSessionCode.contains(response.statusCode)) {
      throw ApiProviderSessionExpection();
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }

  @override
  Future<ValidField> report({TweetEngageRequestOption option}) async {
    final httpHeader = await _setupHttpHeader();

    Map<String, String> queryParameters = {'reason': option.message};

    final httpRequest = await _setupHttpRequest(
      path: '/timeline/${option.tweetId}/report',
      queryParameters: queryParameters,
    );

    final response = await _apiClient.post(httpRequest, headers: httpHeader);
    if (_successfulResponse.contains(response.statusCode)) {
      return ValidField();
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
      queryParameters: queryParameters,
    );
  }
}
