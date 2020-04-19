import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/error/exceptions.dart';

class PenhasAuthenticationService extends Disposable {
  final IApiProvider apiClient;

  PenhasAuthenticationService({this.apiClient});

  Future<AuthenticationModel> login({String email, String password}) async {
    return apiClient
        .request(_LoginRequest())
        .then(_mapLoginModel)
        .catchError(_handleError);
  }

  Future<AuthenticationModel> _mapLoginModel(Map<String, dynamic> data) async {
    var fakePassword = data['senha_falsa'] > 0;
    return AuthenticationModel(
        fakePassword: fakePassword, sessionToken: data['session']);
  }

  Future<AuthenticationModel> _handleError(Object error) {
    if (error is ApiProviderException) {
      if (error.bodyContent['error'] == 'wrongpassword') {
        throw LoginFormException();
      }
    }

    throw Exception();
  }

  @override
  void dispose() {}
}

class _LoginRequest extends IRequestBuilder {}

class AuthenticationModel {
  final bool fakePassword;
  final String sessionToken;

  AuthenticationModel({this.fakePassword, this.sessionToken});
}

abstract class IApiProvider {
  Future<Map<String, dynamic>> request(IRequestBuilder requestBuilder);
}

abstract class IRequestBuilder {}

class LoginFormException implements Exception {}
