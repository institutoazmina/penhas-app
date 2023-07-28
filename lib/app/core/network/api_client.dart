import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../shared/logger/log.dart';
import '../error/exceptions.dart';
import 'api_server_configure.dart';
import 'network_info.dart';

abstract class IApiProvider {
  Future<String> get({
    required String path,
    Map<String, String> headers,
    Map<String, String?> parameters,
  });

  Future<String> post({
    required String path,
    Map<String, String> headers,
    Map<String, String?> parameters,
    String? body,
  });

  Future<String> delete({
    required String path,
    Map<String, String?> parameters,
  });

  Future<String> upload({
    required String path,
    required MultipartFile file,
    Map<String, String> headers,
    Map<String, String> fields,
  });

  Future<String> download({
    required String path,
    required File file,
    Map<String, String> headers,
    Map<String, String> fields,
  });
}

class ApiProvider implements IApiProvider {
  ApiProvider({
    required IApiServerConfigure serverConfiguration,
    required INetworkInfo networkInfo,
    Client? apiClient,
  })  : _networkInfo = networkInfo,
        _apiClient = apiClient ?? Client(),
        _serverConfiguration = serverConfiguration;

  final Client _apiClient;
  final INetworkInfo _networkInfo;
  final IApiServerConfigure _serverConfiguration;

  @override
  Future<String> get({
    required String path,
    Map<String, String> headers = const {},
    Map<String, String?> parameters = const {},
  }) async {
    final Uri uriRequest = _setupHttpRequest(
      path: path,
      queryParameters: parameters,
    );
    final header = await _setupHttpHeader(headers);
    final response = await _apiClient.get(uriRequest, headers: header);
    final parsed = await _parseResponse(response);

    return parsed.body;
  }

  @override
  Future<String> post({
    required String path,
    Map<String, String> headers = const {},
    Map<String, String?> parameters = const {},
    String? body,
  }) async {
    final Uri uriRequest = _setupHttpRequest(
      path: path,
      queryParameters: parameters,
    );
    final header = await _setupHttpHeader(headers);
    final response =
        await _apiClient.post(uriRequest, headers: header, body: body);
    final parsed = await _parseResponse(response);

    return parsed.body;
  }

  @override
  Future<String> delete({
    String? path,
    Map<String, String?> parameters = const {},
  }) async {
    final Uri uriRequest = _setupHttpRequest(
      path: path,
      queryParameters: parameters,
    );
    final header = await _setupHttpHeader({});
    final response = await _apiClient.delete(uriRequest, headers: header);
    final parsed = await _parseResponse(response);

    return parsed.body;
  }

  @override
  Future<String> upload({
    required String path,
    required MultipartFile file,
    Map<String, String> headers = const {},
    Map<String, String> fields = const {},
  }) async {
    final Uri uriRequest = _setupHttpRequest(
      path: path,
      queryParameters: {},
    );
    final header = await _setupHttpHeader(headers);
    final request = MultipartRequest('POST', uriRequest);
    request
      ..headers.addAll(header)
      ..fields.addAll(fields)
      ..files.add(file);

    final response = await request.send();
    await _parseResponse(response);
    return response.stream.bytesToString();
  }

  @override
  Future<String> download({
    required String path,
    required File file,
    Map<String, String> headers = const {},
    Map<String, String> fields = const {},
  }) async {
    final Uri uriRequest = _setupHttpRequest(
      path: path,
      queryParameters: fields,
    );

    final header = await _setupHttpHeader(headers);

    final response = await _apiClient.get(uriRequest, headers: header);
    final parsed = await _parseResponse(response);
    file.writeAsBytesSync(parsed.bodyBytes);

    return '{"message": "Ok"}';
  }
}

extension _ApiProvider on ApiProvider {
  Future<Map<String, String>> _setupHttpHeader([
    Map<String, String> headers = const {},
  ]) async {
    final Map<String, String> httpHeaders = {
      'X-Api-Key': await _serverConfiguration.apiToken ?? '',
      'User-Agent': await _serverConfiguration.userAgent,
      ...headers,
    };

    if (!httpHeaders.containsKey('Content-Type')) {
      httpHeaders['Content-Type'] =
          'application/x-www-form-urlencoded; charset=utf-8';
    }

    return httpHeaders;
  }

  Uri _setupHttpRequest({
    required String? path,
    Map<String, String?> queryParameters = const {},
  }) {
    final query = {...queryParameters};
    query.removeWhere((k, v) => v == null);
    return _serverConfiguration.baseUri.replace(
      path: path,
      queryParameters: query,
    );
  }

  Future<Response> _parseResponse(BaseResponse response) async {
    final Set<int> successfulResponse = {200, 204};
    final Set<int> invalidSessionCode = {401, 403};
    final Set<int> serverExceptions = {500, 501, 502, 503, 504, 505};

    final statusCode = response.statusCode;
    if (successfulResponse.contains(statusCode)) {
      if (response is StreamedResponse) {
        return Response.fromStream(response);
      } else {
        return response as Response;
      }
    }

    // Tratamento dos códigos com erro
    if (invalidSessionCode.contains(statusCode)) {
      throw ApiProviderSessionError();
    } else if (serverExceptions.contains(statusCode)) {
      throw NetworkServerException();
    } else {
      if (await _networkInfo.isConnected == false) {
        throw InternetConnectionException();
      }

      late String jsonData;
      if (response is StreamedResponse) {
        jsonData = await response.stream.bytesToString();
      } else if (response is Response) {
        jsonData = response.body;
      }

      Map<String, dynamic> bodyContent = <String, dynamic>{};
      try {
        bodyContent = jsonDecode(jsonData);
      } catch (e, stack) {
        logError(e, stack);
        bodyContent = {'parserError': e.toString()};
      }

      throw ApiProviderException(bodyContent: bodyContent);
    }
  }
}
