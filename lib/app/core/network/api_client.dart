import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../shared/logger/log.dart';
import '../error/exceptions.dart';
import 'api_server_configure.dart';
import 'interfaces/api_content_type.dart';
import 'interfaces/api_http_request_method.dart';

export 'package:http/http.dart' show Response;

abstract class IApiProvider {
  Future<Response> request({
    required String method,
    required String path,
    Map<String, String> headers,
    Map<String, String?> parameters,
    String body,
  });

  Future<String> get({
    required String path,
    Map<String, String> headers,
    Map<String, String?> parameters,
    ApiContentType? contentType,
  });

  Future<String> post({
    required String path,
    Map<String, String> headers,
    Map<String, String?> parameters,
    ApiContentType? contentType,
    String? body,
  });

  Future<String> put({
    required String path,
    Map<String, String> headers,
    Map<String, String?> parameters,
    ApiContentType? contentType,
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
    Client? apiClient,
  })  : _httpClient = apiClient ?? Client(),
        _serverConfiguration = serverConfiguration;

  final Client _httpClient;
  final IApiServerConfigure _serverConfiguration;

  static const _successfulResponse = {200, 204};
  static const _serverExceptions = {500, 501, 505};
  static const _serverTimeout = {502, 503, 504};
  static const _invalidSession = {401, 403};
  static const _badRequest = 400;
  static const _notFound = 404;

  @override
  Future<Response> request({
    required String method,
    required String path,
    Map<String, String> headers = const {},
    Map<String, String?> parameters = const {},
    String body = '',
  }) async {
    final Uri uriRequest = _setupHttpRequest(
      path: path,
      queryParameters: parameters,
    );
    final header = await _setupHttpHeader(headers);

    final response = await _httpClient.send(
      Request(method, uriRequest)
        ..body = body
        ..headers.addAll(header),
    );

    return await _parseResponse(response);
  }

  @override
  Future<String> get({
    required String path,
    Map<String, String> headers = const {},
    Map<String, String?> parameters = const {},
    ApiContentType? contentType,
  }) async {
    final streamedResponse = await _execute(
      method: ApiHttpRequestMethod.get,
      path: path,
      body: '',
      headers: headers,
      parameters: parameters,
      contentType: contentType,
    );

    final response = await _parseResponse(streamedResponse);
    return response.body;
  }

  @override
  Future<String> post({
    required String path,
    Map<String, String> headers = const {},
    Map<String, String?> parameters = const {},
    ApiContentType? contentType,
    String? body,
  }) async {
    final streamedResponse = await _execute(
      method: ApiHttpRequestMethod.post,
      path: path,
      body: body ?? '',
      headers: headers,
      parameters: parameters,
      contentType: contentType,
    );

    final response = await _parseResponse(streamedResponse);
    return response.body;
  }

  @override
  Future<String> put({
    required String path,
    Map<String, String> headers = const {},
    Map<String, String?> parameters = const {},
    ApiContentType? contentType,
    String? body,
  }) async {
    final streamedResponse = await _execute(
      method: ApiHttpRequestMethod.put,
      path: path,
      body: body ?? '',
      headers: headers,
      parameters: parameters,
      contentType: contentType,
    );

    final response = await _parseResponse(streamedResponse);
    return response.body;
  }

  @override
  Future<String> delete({
    required String path,
    Map<String, String?> parameters = const {},
  }) async {
    final streamedResponse = await _execute(
      method: ApiHttpRequestMethod.delete,
      path: path,
      body: '',
      headers: const {},
      parameters: parameters,
      contentType: null,
    );

    final response = await _parseResponse(streamedResponse);
    return response.body;
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

    final response = await _httpClient.upload(request);
    final parsed = await _parseResponse(response);

    return parsed.body;
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

    final response = await _httpClient.get(uriRequest, headers: header);
    final parsed = await _parseResponse(response);
    file.writeAsBytesSync(parsed.bodyBytes);

    return '{"message": "Ok"}';
  }
}

extension _ApiProvider on ApiProvider {
  Future<StreamedResponse> _execute({
    required ApiHttpRequestMethod method,
    required ApiContentType? contentType,
    required String path,
    required String body,
    Map<String, String> headers = const {},
    Map<String, String?> parameters = const {},
  }) async {
    final header = await _setupHttpHeader(headers, contentType);
    final uriRequest = _setupHttpRequest(
      path: path,
      queryParameters: parameters,
    );
    final myRequest = Request(method.stringify, uriRequest)
      ..headers.addAll(header)
      ..body = body;

    try {
      final client = _httpClient;
      final response = await client.send(myRequest);
      return response;
    } on SocketException catch (e, stack) {
      logError(e, stack);
      throw InternetConnectionException();
    } catch (e, stack) {
      logError(e, stack);
      throw ApiProviderException(bodyContent: {'parserError': e.toString()});
    }
  }

  Future<Map<String, String>> _setupHttpHeader([
    Map<String, String> headers = const {},
    ApiContentType? contentType,
  ]) async {
    final Map<String, String> httpHeaders = {
      'X-Api-Key': await _serverConfiguration.apiToken ?? '',
      'User-Agent': await _serverConfiguration.userAgent,
      'Content-Type': contentType?.value ?? ApiContentType.formUrlEncoded.value,
      ...headers,
    };

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

  Future<Response> _parseResponse(BaseResponse baseResponse) async {
    final response = (baseResponse is StreamedResponse)
        ? await Response.fromStream(baseResponse)
        : baseResponse as Response;
    final httpStatusCode = response.statusCode;

    if (ApiProvider._successfulResponse.contains(httpStatusCode)) {
      return response;
    } else if (httpStatusCode == ApiProvider._badRequest) {
      throw ApiProviderException(bodyContent: _parseBody(response.body));
    } else if (ApiProvider._invalidSession.contains(httpStatusCode)) {
      throw ApiProviderSessionError();
    } else if (httpStatusCode == ApiProvider._notFound) {
      throw ApiProviderException(bodyContent: _parseBody(response.body));
    } else if (ApiProvider._serverExceptions.contains(httpStatusCode)) {
      throw NetworkServerException();
    } else if (ApiProvider._serverTimeout.contains(httpStatusCode)) {
      throw NetworkServerException();
    } else {
      throw ApiProviderException(bodyContent: _parseBody(response.body));
    }
  }

  Map<String, dynamic> _parseBody(String body) {
    try {
      return jsonDecode(body);
    } catch (e, stack) {
      logError(e, stack);
      return {'parserError': e.toString()};
    }
  }
}

extension _HttpClientX on Client {
  Future<StreamedResponse> upload(MultipartRequest request) =>
      runWithClient(() => request.send(), () => this);
}

extension _ApiHttpRequestMethodStringify on ApiHttpRequestMethod {
  String get stringify {
    switch (this) {
      case ApiHttpRequestMethod.get:
        return 'GET';
      case ApiHttpRequestMethod.post:
        return 'POST';
      case ApiHttpRequestMethod.put:
        return 'PUT';
      case ApiHttpRequestMethod.delete:
        return 'DELETE';
    }
  }
}
