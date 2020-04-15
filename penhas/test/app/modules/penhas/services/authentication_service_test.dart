import 'dart:io' show File;
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';

import 'package:penhas/app/modules/penhas/services/authentication_service.dart';

void main() {
  PenhasAuthenticationService sut;
  _HttpClientSpy httpClient;

  setUp(() {
    httpClient = _HttpClientSpy();
    sut = PenhasAuthenticationService(apiClient: httpClient);
  });

  group('AuthenticationService Test', () {
    test("do not call request on initialization", () async {
      expect(sut, isInstanceOf<PenhasAuthenticationService>());
      expect(httpClient.requestMessages, []);
    });

    test("success login with valid parameters", () async {
      var response =
          await sut.login(email: "user@valid.com", password: 'strong_password');
      expect(response, isInstanceOf<AuthenticationModel>());
      expect(response.fakePassword, false);
      expect(response.sessionToken, 'my_strong_password');
    });
  });
}

class _HttpClientSpy extends IApiProvider {
  var requestMessages = [];

  @override
  Future<Map<String, dynamic>> request(IRequestBuilder requestBuilder) async {
    final file = File('test/assets/json/penhas_login_success.json');
    final content = await file.readAsString();
    final data = JsonDecoder().convert(content);
    return data;
  }
}
