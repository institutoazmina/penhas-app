import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/authentication/data/datasources/authentication_data_source.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';

import '../../../../../utils/json_util.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockApiServerConfigure extends Mock implements IApiServerConfigure {}

void main() {
  IAuthenticationDataSource dataSource;
  MockHttpClient mockHttpClient;
  MockApiServerConfigure mockApiServerConfigure;
  EmailAddress emailAddress;
  Password password;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockApiServerConfigure = MockApiServerConfigure();
    dataSource = AuthenticationDataSource(
      apiClient: mockHttpClient,
      serverConfiguration: mockApiServerConfigure,
    );
    emailAddress = EmailAddress('valid@email.com');
    password = Password('_veryStr0ngP4ssw@rd');

    // MockApiServerConfigure configuration
    when(mockApiServerConfigure.baseUri)
        .thenAnswer((_) => Uri.https('api.anyserver.io', '/'));
    when(mockApiServerConfigure.userAgent())
        .thenAnswer((_) => Future.value("iOS 11.4/Simulator/1.0.0"));
  });

  group('AuthenticationDataSource', () {
    test(
        'should perform a POST with parameters and application/x-www-form-urlencoded header',
        () async {
      // arrange
      when(mockHttpClient.post(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(
            JsonUtil.getStringSync(from: 'authentication/login_success.json'),
            200),
      );

      final userAgent = await mockApiServerConfigure.userAgent();
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
        scheme: 'https',
        host: 'api.anyserver.io',
        path: '/login',
        queryParameters: queryParameters,
      );
      // act
      await dataSource.signInWithEmailAndPassword(
          emailAddress: emailAddress, password: password);
      // assert
      verify(mockHttpClient.post(loginUri, headers: headers));
    });
  });
}
