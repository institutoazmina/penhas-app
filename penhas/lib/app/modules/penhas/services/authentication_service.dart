import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';

class PenhasAuthenticationService extends Disposable {
  final IApiProvider apiClient;

  PenhasAuthenticationService({this.apiClient});

  Future<AuthenticationModel> login({String email, String password}) async {
    return apiClient.request(_LoginRequest()).then(_mapLoginModel);
  }

  Future<AuthenticationModel> _mapLoginModel(Map<String, dynamic> data) async {
    var fakePassword = data['senha_falsa'] > 0;
    return AuthenticationModel(
        fakePassword: fakePassword, sessionToken: data['session']);
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

class ApiProviderError implements Exception {
  final Map<String, dynamic> bodyContent;

  ApiProviderError(this.bodyContent);
}
