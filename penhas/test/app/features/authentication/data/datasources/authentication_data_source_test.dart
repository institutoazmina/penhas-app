import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/authentication/data/datasources/authentication_data_source.dart';
import 'package:penhas/app/features/authentication/data/models/session_model.dart';
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

    test('should return SessionModel when the response code is 200 (success)',
        () async {
      // arrange
      final jsonData =
          await JsonUtil.getJson(from: 'authentication/login_success.json');
      final sessionModel = SessionModel.fromJson(jsonData);
      when(mockHttpClient.post(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(
            JsonUtil.getStringSync(from: 'authentication/login_success.json'),
            200),
      );

      // act
      final result = await dataSource.signInWithEmailAndPassword(
        emailAddress: emailAddress,
        password: password,
      );
      // assert
      expect(result, sessionModel);
    });

    test(
        'should throw ApiProviderException when the response code is nonsuccess (non 200)',
        () async {
      final bodyContent =
          JsonUtil.getStringSync(from: 'authentication/login_failure.json');
      // arrange
      when(mockHttpClient.post(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(bodyContent, 400));

      // act
      final sut = dataSource.signInWithEmailAndPassword;
      // assert
      expect(
          () async => await sut(emailAddress: emailAddress, password: password),
          throwsA(isA<ApiProviderException>().having((e) => e.bodyContent,
              'Got bodyContent', json.decode(bodyContent))));
    });
  });
}
