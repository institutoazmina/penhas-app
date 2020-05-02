import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/authentication/data/models/session_model.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';

abstract class IAuthenticationDataSource {
  /// Calls the http://server.api/login? endpoint
  ///
  /// Throws a [ServerException] for all error codes
  Future<SessionModel> signInWithEmailAndPassword({
    @required EmailAddress emailAddress,
    @required Password password,
  });
}

class AuthenticationDataSource implements IAuthenticationDataSource {
  final http.Client apiClient;
  final IApiServerConfigure serverConfiguration;

  AuthenticationDataSource({
    @required this.apiClient,
    @required this.serverConfiguration,
  });

  @override
  Future<SessionModel> signInWithEmailAndPassword({
    EmailAddress emailAddress,
    Password password,
  }) async {
    final _baseUri = serverConfiguration.baseUri;
    final userAgent = await serverConfiguration.userAgent();
    final queryParameters = {
      'app_version': userAgent,
      'email': emailAddress.rawValue,
      'senha': password.rawValue,
    };
    final headers = {
      'User-Agent': userAgent,
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    final loginUri = Uri(
      scheme: _baseUri.scheme,
      host: _baseUri.host,
      path: '/login',
      queryParameters: queryParameters,
    );

    final response = await apiClient.post(loginUri, headers: headers);

    if (response.statusCode == HttpStatus.ok) {
      return SessionModel.fromJson(json.decode(response.body));
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }
}
