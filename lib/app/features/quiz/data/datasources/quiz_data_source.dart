import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_server_configure.dart';
import '../../../appstate/data/model/app_state_model.dart';
import '../../domain/entities/quiz_request_entity.dart';

abstract class IQuizDataSource {
  Future<AppStateModel> update({required QuizRequestEntity? quiz});
}

class QuizDataSource implements IQuizDataSource {
  QuizDataSource({
    required http.Client? apiClient,
    required serverConfiguration,
  })  : _apiClient = apiClient,
        _serverConfiguration = serverConfiguration;

  final http.Client? _apiClient;
  final IApiServerConfigure? _serverConfiguration;
  final Set<int> _successfulResponse = {200};
  final Set<int> _invalidSessionCode = {401, 403};

  @override
  Future<AppStateModel> update({required QuizRequestEntity? quiz}) async {
    final httpHeader = await _setupHttpHeader();

    final Map<String, String> queryParameters = {
      'session_id': '${quiz!.sessionId}',
    };
    queryParameters.addAll(quiz.options);

    final httpRequest =
        await _setupHttpRequest(queryParameters: queryParameters);

    final response = await _apiClient!.post(httpRequest, headers: httpHeader);
    if (_successfulResponse.contains(response.statusCode)) {
      return AppStateModel.fromJson(json.decode(response.body));
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
    required Map<String, String> queryParameters,
  }) async {
    return _serverConfiguration!.baseUri.replace(
      path: '/me/quiz',
      queryParameters: queryParameters,
    );
  }
}
