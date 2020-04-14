import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:penhas/app/modules/penhas/services/authentication_service.dart';

void main() {
  PenhasAuthenticationService sut;
  _HttpClientSpy httpClient;

  setUp(() {
    httpClient = _HttpClientSpy();
    sut = PenhasAuthenticationService();
  });

  group('AuthenticationService Test', () {
    test("Initialization do not call request", () {
      expect(sut, isInstanceOf<PenhasAuthenticationService>());
      expect(httpClient.requestMessages, []);
    });
  });
}

class _HttpClientSpy {
  var requestMessages = [];
}
