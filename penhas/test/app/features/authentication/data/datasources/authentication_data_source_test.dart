import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/features/authentication/data/datasources/authentication_data_source.dart';
import 'package:penhas/app/features/authentication/data/models/session_model.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';
import 'package:penhas/app/shared/logger/log.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

void main() {
  late final MockHttpClient mockHttpClient = MockHttpClient();
  late final MockIApiServerConfigure mockApiServerConfigure =
      MockIApiServerConfigure();
  late final EmailAddress emailAddress = EmailAddress('valid@email.com');
  late final SignInPassword password =
      SignInPassword('_veryStr0ngP4ssw@rd', PasswordValidator());
  final Uri serverEndpoint = Uri.https('api.anyserver.io', '/');

  late final IAuthenticationDataSource dataSource = AuthenticationDataSource(
    apiClient: mockHttpClient,
    serverConfiguration: mockApiServerConfigure,
  );

  setUp(() {
    // MockApiServerConfigure configuration
    when(mockApiServerConfigure.baseUri).thenAnswer((_) => serverEndpoint);
    when(mockApiServerConfigure.userAgent)
        .thenAnswer((_) => Future.value('iOS 11.4/Simulator/1.0.0'));
  });

  Future<Map<String, String>> setUpHttpHeader() async {
    final userAgent = await mockApiServerConfigure.userAgent;
    return {
      'User-Agent': userAgent,
      'Content-Type': 'application/x-www-form-urlencoded'
    };
  }

  Future<Map<String, dynamic>> setUpQueryParameters() async {
    final userAgent = await mockApiServerConfigure.userAgent;
    return {
      'app_version': userAgent,
      'email': emailAddress.rawValue,
      'senha': password.rawValue,
    };
  }

  Future<Uri> setuHttpRequest() async {
    final queryParameters = await setUpQueryParameters();
    return Uri(
      scheme: serverEndpoint.scheme,
      host: serverEndpoint.host,
      path: '/login',
      queryParameters: queryParameters,
    );
  }

  void setUpMockHttpClientSuccess200() {
    final bodyContent =
        JsonUtil.getStringSync(from: 'authentication/login_success.json');
    when(mockHttpClient.post(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(bodyContent, 200));
  }

  void setUpMockHttpClientError400() {
    final bodyContent =
        JsonUtil.getStringSync(from: 'authentication/login_failure.json');
    // arrange
    when(mockHttpClient.post(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(bodyContent, 400));
  }

  group('AuthenticationDataSource', () {
    test(
        'should perform a POST with parameters and application/x-www-form-urlencoded header',
        () async {
      // arrange
      setUpMockHttpClientSuccess200();
      final headers = await setUpHttpHeader();
      final loginUri = await setuHttpRequest();
      // act
      await dataSource.signInWithEmailAndPassword(
        emailAddress: emailAddress,
        password: password,
      );
      // assert
      verify(mockHttpClient.post(loginUri, headers: headers));
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
      final sut = dataSource.signInWithEmailAndPassword;
      // assert
      expect(
        () => sut(emailAddress: emailAddress, password: password),
        throwsA(
          isA<ApiProviderException>()
              .having((e) => e.bodyContent, 'Got bodyContent', bodyContent),
        ),
      );
    });
  });
}
