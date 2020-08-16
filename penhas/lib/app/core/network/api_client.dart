import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart';
import 'package:penhas/app/core/error/exceptions.dart';

import 'api_server_configure.dart';
import 'network_info.dart';

abstract class IApiProvider {
  Future<String> upload({
    @required String path,
    Map<String, String> headers,
    Map<String, String> fields,
    @required MultipartFile file,
  });

  Future<String> get({
    @required String path,
    Map<String, String> headers,
    Map<String, String> parameters,
  });

  Future<String> post({
    @required String path,
    Map<String, String> headers,
    Map<String, String> parameters,
  });

  Future<String> delete({
    @required String path,
    Map<String, String> parameters,
  });
}

class ApiProvider implements IApiProvider {
  final INetworkInfo _networkInfo;
  final IApiServerConfigure _serverConfiguration;

  ApiProvider({
    @required IApiServerConfigure serverConfiguration,
    @required INetworkInfo networkInfo,
  })  : this._serverConfiguration = serverConfiguration,
        this._networkInfo = networkInfo;

  @override
  Future<String> upload({
    @required String path,
    Map<String, String> headers,
    Map<String, String> fields,
    @required MultipartFile file,
  }) async {
    final Uri uriRequest = setupHttpRequest(
      path: path,
      queryParameters: {},
    );
    final header = await setupHttpHeader(headers);
    final MultipartRequest request = MultipartRequest('POST', uriRequest);
    final cleanedField = fields == null ? Map<String, String>() : fields;
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
  Future<String> get({
    @required String path,
    Map<String, String> headers,
    Map<String, String> parameters,
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
    @required String path,
    Map<String, String> headers,
    Map<String, String> parameters,
  }) async {
    final Uri uriRequest = setupHttpRequest(
      path: path,
      queryParameters: parameters,
    );
    final header = await setupHttpHeader(headers);
    return Client()
        .post(uriRequest, headers: header)
        .parseError(_networkInfo)
        .then((response) => response.body);
  }

  @override
  Future<String> delete({String path, Map<String, String> parameters}) async {
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
}

extension _ApiProvider on ApiProvider {
  Future<Map<String, String>> setupHttpHeader(
      Map<String, String> headers) async {
    Map<String, String> localHeader =
        headers == null ? Map<String, String>() : headers;

    localHeader.addAll(
      {
        'X-Api-Key': await _serverConfiguration.apiToken,
        'User-Agent': await _serverConfiguration.userAgent,
      },
    );

    return localHeader;
  }

  Uri setupHttpRequest({
    @required String path,
    @required Map<String, String> queryParameters,
  }) {
    queryParameters.removeWhere((k, v) => v == null);
    return _serverConfiguration.baseUri.replace(
      path: path,
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    );
  }
}

extension _FutureExtension<T extends BaseResponse> on Future<T> {
  Future<T> parseError(INetworkInfo networkInfo) async {
    final Set<int> successfulResponse = {200, 204};
    final Set<int> invalidSessionCode = {401, 403};
    final Set<int> serverExceptions = {500, 501, 502, 503, 504, 505};

    return this.then(
      (value) async {
        final statusCode = value.statusCode;

        if (successfulResponse.contains(statusCode)) {
          return Future.value(value);
        } else if (invalidSessionCode.contains(statusCode)) {
          throw ApiProviderSessionExpection();
        } else if (serverExceptions.contains(statusCode)) {
          throw NetworkServerException();
        } else {
          if (await networkInfo.isConnected == false) {
            throw InternetConnectionException();
          }

          String jsonData;
          if (value is StreamedResponse) {
            jsonData = await value.stream.bytesToString();
          } else if (value is Response) {
            jsonData = value.body;
          }

          Map<String, dynamic> bodyContent = Map<String, dynamic>();
          try {
            bodyContent = jsonDecode(jsonData);
          } catch (e) {
            bodyContent = {'parserError': e.toString()};
          }

          throw ApiProviderException(bodyContent: bodyContent);
        }
      },
    );
  }
}
