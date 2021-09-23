import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/feed/data/models/tweet_model.dart';
import 'package:penhas/app/features/feed/data/models/tweet_session_model.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_engage_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_request_option.dart';

abstract class ITweetDataSource {
  Future<TweetSessionModel> fetch({@required TweetRequestOption option});
  Future<TweetSessionModel> current({
    @required TweetEngageRequestOption option,
  });
  Future<TweetModel> like({@required TweetEngageRequestOption option});
  Future<TweetModel> create({@required TweetCreateRequestOption option});
  Future<TweetModel> reply({@required TweetEngageRequestOption option});
  Future<ValidField> report({@required TweetEngageRequestOption option});
  Future<ValidField> delete({@required TweetEngageRequestOption option});
}

class TweetDataSource implements ITweetDataSource {
  final http.Client _apiClient;
  final IApiServerConfigure _serverConfiguration;
  final Set<int> _successfulResponse = {200, 204};
  final Set<int> _invalidSessionCode = {401, 403};

  TweetDataSource({
    @required http.Client apiClient,
    @required serverConfiguration,
  })  : this._apiClient = apiClient,
        this._serverConfiguration = serverConfiguration;

  @override
  Future<TweetSessionModel> fetch({
    @required TweetRequestOption option,
  }) async {
    final httpHeader = await _setupHttpHeader();
    Map<String, String> queryParameters = {
      'after': option.after,
      'before': option.before,
      'parent_id': option.parent,
      'next_page': option.nextPageToken,
      'rows': "${option.rows}",
      'reply_to': option.replyTo,
      'category': option.category,
      'tags': (option.tags == null || option.tags.isEmpty) ? null : option.tags,
    };
    final httpRequest = await _setupHttpRequest(
      path: '/timeline',
      queryParameters: queryParameters,
    );

    final response = await _apiClient.get(httpRequest, headers: httpHeader);

    if (_successfulResponse.contains(response.statusCode)) {
      return TweetSessionModel.fromJson(json.decode(response.body));
    } else if (_invalidSessionCode.contains(response.statusCode)) {
      throw ApiProviderSessionExpection();
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }

  @override
  Future<ValidField> report({TweetEngageRequestOption option}) async {
    final httpHeader = await _setupHttpHeader();
    final httpRequest = await _setupHttpRequest(
      path: '/timeline/${option.tweetId}/report',
      queryParameters: {},
    );
    final bodyContent = Uri.encodeComponent(option.message);

    final response = await _apiClient.post(
      httpRequest,
      headers: httpHeader,
      body: 'reason=$bodyContent',
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
  Future<TweetModel> reply({TweetEngageRequestOption option}) async {
    final httpHeader = await _setupHttpHeader();
    final httpRequest = await _setupHttpRequest(
      path: '/timeline/${option.tweetId}/comment',
      queryParameters: {},
    );
    final bodyContent = Uri.encodeComponent(option.message);

    final response = await _apiClient.post(
      httpRequest,
      headers: httpHeader,
      body: 'content=$bodyContent',
    );

    if (_successfulResponse.contains(response.statusCode)) {
      return TweetModel.fromJson(json.decode(response.body));
    } else if (_invalidSessionCode.contains(response.statusCode)) {
      throw ApiProviderSessionExpection();
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }

  @override
  Future<TweetModel> like({TweetEngageRequestOption option}) async {
    final httpHeader = await _setupHttpHeader();
    final httpRequest = await _setupHttpRequest(
      path: '/timeline/${option.tweetId}/like',
      queryParameters: {'remove': option.dislike ? '1' : null},
    );

    final response = await _apiClient.post(httpRequest, headers: httpHeader);
    if (_successfulResponse.contains(response.statusCode)) {
      final jsonData = json.decode(response.body);
      return TweetModel.fromJson(jsonData['tweet']);
    } else if (_invalidSessionCode.contains(response.statusCode)) {
      throw ApiProviderSessionExpection();
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }

  @override
  Future<TweetModel> create({TweetCreateRequestOption option}) async {
    final httpHeader = await _setupHttpHeader();
    final httpRequest = await _setupHttpRequest(
      path: '/me/tweets',
      queryParameters: {},
    );
    final bodyContent = Uri.encodeComponent(option.message);
    final response = await _apiClient.post(
      httpRequest,
      headers: httpHeader,
      body: 'content=$bodyContent',
    );

    if (_successfulResponse.contains(response.statusCode)) {
      return TweetModel.fromJson(json.decode(response.body));
    } else if (_invalidSessionCode.contains(response.statusCode)) {
      throw ApiProviderSessionExpection();
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }

  @override
  Future<ValidField> delete({TweetEngageRequestOption option}) async {
    final httpHeader = await _setupHttpHeader();
    Map<String, String> queryParameters = {'id': option.tweetId};
    final httpRequest = await _setupHttpRequest(
      path: '/me/tweets',
      queryParameters: queryParameters,
    );

    final response = await _apiClient.delete(httpRequest, headers: httpHeader);
    if (_successfulResponse.contains(response.statusCode)) {
      return ValidField();
    } else if (_invalidSessionCode.contains(response.statusCode)) {
      throw ApiProviderSessionExpection();
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }

  @override
  Future<TweetSessionModel> current({TweetEngageRequestOption option}) async {
    final httpHeader = await _setupHttpHeader();
    Map<String, String> queryParameters = {
      'id': option.tweetId,
    };
    final httpRequest = await _setupHttpRequest(
      path: '/timeline',
      queryParameters: queryParameters,
    );

    final response = await _apiClient.get(httpRequest, headers: httpHeader);
    if (_successfulResponse.contains(response.statusCode)) {
      return TweetSessionModel.fromJson(json.decode(response.body));
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
    return _serverConfiguration.baseUri.replace(
      path: path,
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    );
  }
}
