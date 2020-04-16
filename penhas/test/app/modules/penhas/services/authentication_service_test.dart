import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

import 'package:penhas/app/modules/penhas/services/authentication_service.dart';

import '../../../../utils/json_util.dart';

void main() {
  group('AuthenticationService Test', () {
    test("do not call request on initialization", () async {
      final data =
          await JsonUtil.getString(from: 'authentication/login_success.json');
      final bodyResponse = Response(data, 200);
      final httpClient = _HttpClientSpy(response: [bodyResponse]);
      final sut = PenhasAuthenticationService(apiClient: httpClient);

      expect(sut, isInstanceOf<PenhasAuthenticationService>());
      expect(httpClient.requestMessages, []);
    });

    test("success login with valid parameters", () async {
      final data =
          await JsonUtil.getString(from: 'authentication/login_success.json');
      final bodyResponse = Response(data, 200);
      final httpClient = _HttpClientSpy(response: [bodyResponse]);
      final sut = PenhasAuthenticationService(apiClient: httpClient);

      var response =
          await sut.login(email: "user@valid.com", password: 'strong_password');
      expect(response, isInstanceOf<AuthenticationModel>());
      expect(response.fakePassword, false);
      expect(response.sessionToken, 'my_strong_password');
    });

    test("failed login with invalid parameters", () async {
      final data =
          await JsonUtil.getJson(from: 'authentication/login_failure.json');
      final bodyResponse = ApiProviderException(data);
      final httpClient = _HttpClientSpy(response: [bodyResponse]);
      final sut = PenhasAuthenticationService(apiClient: httpClient);

      expect(
          () async => await sut.login(
              email: "user@valid.com", password: 'invalid_password'),
          throwsA(isA<ApiProviderException>().having(
            (error) => error.bodyContent,
            'body content',
            data,
          )));
    });
  });
}

class MockClient extends Mock implements HttpClient {}

class _HttpClientSpy extends IApiProvider {
  var requestMessages = [];
  List<dynamic> _stubResponse;

  _HttpClientSpy({List<dynamic> response}) {
    if (response == null || response.isEmpty) {
      throw ArgumentError.notNull("response");
    }

    this._stubResponse = response;
  }

  @override
  Future<Map<String, dynamic>> request(IRequestBuilder requestBuilder) async {
    final bodyResponse = _stubResponse.removeAt(0);

    if (bodyResponse is Exception) {
      throw bodyResponse;
    }

    if (bodyResponse is Response) {
      return JsonDecoder().convert(bodyResponse.body);
    }

    throw ArgumentError.value(bodyResponse,
        "Invalid argument from _stubResponse, neither Response or Exception");
  }
}
