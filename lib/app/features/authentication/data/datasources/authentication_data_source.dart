import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_server_configure.dart';
import '../../../../shared/logger/log.dart';
import '../../domain/usecases/email_address.dart';
import '../../domain/usecases/sign_in_password.dart';
import '../models/session_model.dart';

abstract class IAuthenticationDataSource {
  /// Calls the http://server.api/login? endpoint
  ///
  /// Throws a [ServerException] for all error codes
  Future<SessionModel> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required SignInPassword password,
  });
}

class AuthenticationDataSource implements IAuthenticationDataSource {
  AuthenticationDataSource({
    required this.apiClient,
    required this.serverConfiguration,
  });

  final http.Client apiClient;
  final IApiServerConfigure serverConfiguration;

  @override
  Future<SessionModel> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required SignInPassword password,
  }) async {
    final userAgent = await serverConfiguration.userAgent;
    final body = {
      'email': emailAddress.rawValue,
      'senha': password.rawValue,
    };

    final headers = {
      'User-Agent': userAgent,
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    final loginUri = serverConfiguration.baseUri.replace(
      path: '/login',
      queryParameters: {
        'app_version': userAgent,
      },
    );

    final response = await apiClient.post(
      loginUri,
      headers: headers,
      body: body,
    );

    if (response.statusCode == HttpStatus.ok) {
      return SessionModel.fromJson(json.decode(response.body));
    } else {
      logError(response.body);
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }
}
