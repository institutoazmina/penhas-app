import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/shared/logger/log.dart';

import 'api_server_configure.dart';
import 'network_info.dart';

abstract class IApiProvider {
  Future<String> get({
    required String path,
    Map<String, String>? headers,
    Map<String, String?>? parameters,
  });

  Future<String> post({
    required String path,
    Map<String, String>? headers,
    Map<String?, String?>? parameters,
    String? body,
  });

  Future<String> delete({
    required String path,
    Map<String, String?>? parameters,
  });

  Future<String> upload({
    required String path,
    required MultipartFile file,
    Map<String, String>? headers,
    Map<String, String>? fields,
  });

  Future<String> download({
    required String path,
    required File file,
    Map<String, String>? headers,
    Map<String, String>? fields,
  });
}

class ApiProvider implements IApiProvider {
  ApiProvider({
    required IApiServerConfigure serverConfiguration,
    required INetworkInfo networkInfo,
  })  : _serverConfiguration = serverConfiguration,
        _networkInfo = networkInfo;

  final INetworkInfo _networkInfo;
  final IApiServerConfigure _serverConfiguration;

  ApiProvider({
    required IApiServerConfigure serverConfiguration,
    required INetworkInfo networkInfo,
  })  : this._serverConfiguration = serverConfiguration,
        this._networkInfo = networkInfo;

  @override
  Future<String> get({
    required String path,
    Map<String, String>? headers,
    Map<String, String?>? parameters,
  }) async {
    final Uri uriRequest = setupHttpRequest(
      path: path,
      queryParameters: parameters,
    );
    final header = await setupHttpHeader(headers);
    return Client()
        .get(uriRequest, headers: header)
        .parseError(_networkInfo)
        .then((response) => response.body);
  }

  @override
  Future<String> post({
    required String path,
    Map<String, String>? headers,
    Map<String?, String?>? parameters,
    String? body,
  }) async {
    final Uri uriRequest = setupHttpRequest(
      path: path,
      queryParameters: parameters,
    );
    final header = await setupHttpHeader(headers);
    return Client()
        .post(uriRequest, headers: header, body: body)
        .parseError(_networkInfo)
        .then((response) => response.body);
  }

  @override
  Future<String> delete({String? path, Map<String, String?>? parameters}) async {
    final Uri uriRequest = setupHttpRequest(
      path: path,
      queryParameters: parameters,
    );
    final header = await setupHttpHeader({});
    return Client()
        .delete(uriRequest, headers: header)
        .parseError(_networkInfo)
        .then((response) => response.body);
  }

  @override
  Future<String> upload({
    required String path,
    required MultipartFile file,
    Map<String, String>? headers,
    Map<String, String>? fields,
  }) async {
    final Uri uriRequest = setupHttpRequest(
      path: path,
      queryParameters: {},
    );
    final header = await setupHttpHeader(headers);
    final MultipartRequest request = MultipartRequest('POST', uriRequest);
    final cleanedField = fields ?? <String, String>{};
    request
      ..headers.addAll(header)
      ..fields.addAll(cleanedField)
      ..files.add(file);

    return request
        .send()
        .parseError(_networkInfo)
        .then((response) => response.stream.bytesToString());
  }

  @override
  Future<String> download({
    required String path,
    required File file,
    Map<String, String>? headers,
    Map<String, String>? fields,
  }) async {
    final Uri uriRequest = setupHttpRequest(
      path: path,
      queryParameters: fields,
    );

    final header = await setupHttpHeader(headers);
    return Client()
        .get(uriRequest, headers: header)
        .parseError(_networkInfo)
        .then((response) => file.writeAsBytesSync(response.bodyBytes))
        .then((value) => '{"message": "Ok"}');
  }
}

extension _ApiProvider on ApiProvider {
  Future<Map<String, String>> setupHttpHeader(
      Map<String, String>? headers) async {
    headers ??= {};
    headers.addAll(
      {
        'X-Api-Key': await _serverConfiguration.apiToken ?? "",
        'User-Agent': await _serverConfiguration.userAgent,
      },
    );

    if (!headers.containsKey('Content-Type')) {
      headers['Content-Type'] =
          'application/x-www-form-urlencoded; charset=utf-8';
    }

    return httpHeaders;
  }

  Uri setupHttpRequest({
    required String? path,
    required Map<String?, String?>? queryParameters,
  }) {
    queryParameters ??= {};
    queryParameters.removeWhere((k, v) => v == null);
    return _serverConfiguration.baseUri.replace(
      path: path,
      queryParameters: queryParameters.isEmpty ? null : queryParameters as Map<String, dynamic>?,
    );
  }
}

extension _FutureExtension<T extends BaseResponse> on Future<T> {
  Future<T> parseError(INetworkInfo networkInfo) async {
    final Set<int> successfulResponse = {200, 204};
    final Set<int> invalidSessionCode = {401, 403};
    final Set<int> serverExceptions = {500, 501, 502, 503, 504, 505};

    return then(
      (value) async {
        final statusCode = value.statusCode;

        if (successfulResponse.contains(statusCode)) {
          return Future.value(value);
        } else if (invalidSessionCode.contains(statusCode)) {
          throw ApiProviderSessionError();
        } else if (serverExceptions.contains(statusCode)) {
          throw NetworkServerException();
        } else {
          if (await networkInfo.isConnected == false) {
            throw InternetConnectionException();
          }

          late String jsonData;
          if (value is StreamedResponse) {
            jsonData = await value.stream.bytesToString();
          } else if (value is Response) {
            jsonData = value.body;
          }

          Map<String, dynamic>? bodyContent = Map<String, dynamic>();
          try {
            bodyContent = jsonDecode(jsonData);
          } catch (e, stack) {
            logError(e, stack);
            bodyContent = {'parserError': e.toString()};
          }

          throw ApiProviderException(bodyContent: bodyContent);
        }
      },
    );
  }
}
