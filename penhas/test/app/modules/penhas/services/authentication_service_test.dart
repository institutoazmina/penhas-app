import 'package:flutter_test/flutter_test.dart';

import 'package:penhas/app/modules/penhas/services/authentication_service.dart';

import '../../../../utils/json_util.dart';

void main() {
  group('AuthenticationService Test', () {
    test("do not call request on initialization", () async {
      final data =
          await JsonUtil.getJson(from: 'authentication/login_success.json');
      final httpClient = _HttpClientSpy(response: [data]);
      final sut = PenhasAuthenticationService(apiClient: httpClient);

      expect(sut, isInstanceOf<PenhasAuthenticationService>());
      expect(httpClient.requestMessages, []);
    });

    test("success login with valid parameters", () async {
      final data =
          await JsonUtil.getJson(from: 'authentication/login_success.json');
      final httpClient = _HttpClientSpy(response: [data]);
      final sut = PenhasAuthenticationService(apiClient: httpClient);

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
  List<Map<String, dynamic>> _stubResponse;

  _HttpClientSpy({List<Map<String, dynamic>> response}) {
    if (response == null || response.isEmpty) {
      throw ArgumentError.notNull("response");
    }

    this._stubResponse = response;
  }

  @override
  Future<Map<String, dynamic>> request(IRequestBuilder requestBuilder) async {
    return _stubResponse.removeAt(0);
  }
}
