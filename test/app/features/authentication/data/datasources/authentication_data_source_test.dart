import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/authentication/data/datasources/authentication_data_source.dart';
import 'package:penhas/app/features/authentication/data/models/session_model.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';

import '../../../../../utils/json_util.dart';

void main() {
  late http.Client mockHttpClient;
  late IApiServerConfigure mockApiServerConfigure;

  late final EmailAddress emailAddress = EmailAddress('valid@email.com');
  late final SignInPassword password =
      SignInPassword('_veryStr0ngP4ssw@rd', PasswordValidator());
  final Uri serverEndpoint = Uri.https('api.anyserver.io', '/');

  const userAgent = 'iOS 11.4/Simulator/1.0.0';

  late IAuthenticationDataSource dataSource;

  setUp(() {
    // MockApiServerConfigure configuration
    mockHttpClient = _HttpClientMock();
    mockApiServerConfigure = _ApiServerConfigureMock();
    dataSource = AuthenticationDataSource(
      apiClient: mockHttpClient,
      serverConfiguration: mockApiServerConfigure,
    );

    registerFallbackValue(Uri());

    when(() => mockApiServerConfigure.baseUri).thenReturn(serverEndpoint);
    when(() => mockApiServerConfigure.userAgent)
        .thenAnswer((_) async => userAgent);
  });

  Map<String, String> setUpHttpHeader() => {
        'User-Agent': userAgent,
        'Content-Type': 'application/x-www-form-urlencoded'
      };

  Map<String, dynamic> setUpQueryParameters() => {
        'app_version': userAgent,
      };

  Map<String, dynamic> setUpBody() => {
        'email': emailAddress.rawValue,
        'senha': password.rawValue,
      };

  Uri setuHttpRequest() => Uri(
        scheme: serverEndpoint.scheme,
        host: serverEndpoint.host,
        path: '/login',
        queryParameters: setUpQueryParameters(),
      );

  void setUpMockHttpClientSuccess200() {
    final bodyContent =
        JsonUtil.getStringSync(from: 'authentication/login_success.json');
    when(
      () => mockHttpClient.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) async => http.Response(bodyContent, 200));
  }

  void setUpMockHttpClientError400() {
    final bodyContent =
        JsonUtil.getStringSync(from: 'authentication/login_failure.json');
    // arrange
    when(
      () => mockHttpClient.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) async => http.Response(bodyContent, 400));
  }

  group('AuthenticationDataSource', () {
    test(
        'should perform a POST with parameters and application/x-www-form-urlencoded header',
        () async {
      // arrange
      setUpMockHttpClientSuccess200();
      final headers = setUpHttpHeader();
      final loginUri = setuHttpRequest();
      final body = setUpBody();

      // act
      await dataSource.signInWithEmailAndPassword(
        emailAddress: emailAddress,
        password: password,
      );

      // assert
      verify(
        () => mockHttpClient.post(loginUri, headers: headers, body: body),
      ).called(1);
    });

    test('should return SessionModel when the response code is 200 (success)',
        () async {
      // arrange
      final jsonData =
          await JsonUtil.getJson(from: 'authentication/login_success.json');
      final sessionModel = SessionModel.fromJson(jsonData);
      setUpMockHttpClientSuccess200();

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
      // arrange
      final bodyContent =
          await JsonUtil.getJson(from: 'authentication/login_failure.json');
      setUpMockHttpClientError400();

      // act
      final result = dataSource.signInWithEmailAndPassword(
        emailAddress: emailAddress,
        password: password,
      );

      // assert
      expectLater(
        result,
        throwsA(
          isA<ApiProviderException>()
              .having((e) => e.bodyContent, 'Got bodyContent', bodyContent),
        ),
      );
    });

    test('should return SessionModel when sign in with offline hash', () async {
      // arrange
      final jsonData =
          await JsonUtil.getJson(from: 'authentication/login_success.json');
      final sessionModel = SessionModel.fromJson(jsonData);

      // act
      final result = await dataSource.signInWithOfflineHash(
        sessionToken: jsonData['session'],
      );

      // assert
      expect(result, sessionModel);
    });
  });
}

class _HttpClientMock extends Mock implements http.Client {}

class _ApiServerConfigureMock extends Mock implements IApiServerConfigure {}
