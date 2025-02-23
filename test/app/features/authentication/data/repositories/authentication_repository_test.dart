import 'package:crypt/crypt.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/authentication/data/models/session_model.dart';
import 'package:penhas/app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';

import '../../../../../utils/api_provider_mock.dart';
import '../../../../../utils/json_util.dart';

void main() {
  late EmailAddress email;
  late SignInPassword password;
  late IAppConfiguration appConfiguration;
  late IApiServerConfigure serverConfiguration;
  late IAuthenticationRepository repository;
  late Crypt hash;

  const contentType = 'application/x-www-form-urlencoded; charset=utf-8';

  setUp(() {
    ApiProviderMock.init();

    email = EmailAddress('test@g.com');
    password = SignInPassword('_myStrongP4ss@rd', PasswordValidator());
    appConfiguration = MockAppConfiguration();
    serverConfiguration = MockIApiServerConfigure();
    hash = Crypt.sha256(password.rawValue!, salt: email.rawValue);

    repository = AuthenticationRepository(
      appConfiguration: appConfiguration,
      apiProvider: ApiProviderMock.apiProvider,
      serverConfiguration: serverConfiguration,
    );

    when(() => serverConfiguration.userAgent).thenAnswer((_) async => '1.0.0');

    when(() => appConfiguration.saveApiToken(token: any(named: 'token')))
        .thenAnswer((_) => Future.value());

    when(() => appConfiguration.saveHash(hash: any(named: 'hash')))
        .thenAnswer((_) => Future.value());
  });

  void _setUpMockHttpClientResponse(String body, {int? statusCode}) {
    ApiProviderMock.apiClientResponse(body, statusCode ?? 200);
  }

  group(AuthenticationRepository, () {
    test(
      'signInWithEmailAndPassword() successfully authenticate and save credentials when valid email and password are provided',
      () async {
        // arrange
        final jsonFile = 'authentication/login_success.json';
        final jsonData = await JsonUtil.getJson(from: jsonFile);
        final jsonString = JsonUtil.getStringSync(from: jsonFile);
        final sessionModel = SessionModel.fromJson(jsonData);
        _setUpMockHttpClientResponse(jsonString);

        // act
        final result = await repository.signInWithEmailAndPassword(
          emailAddress: email,
          password: password,
        );
        // assert
        final request = verify(
          () => ApiProviderMock.httpClient.send(captureAny()),
        ).captured.single;

        expect(request.url.path, '/login');
        expect(request.method, 'POST');
        expect(request.url.queryParameters, {
          'app_version': '1.0.0',
        });
        expect(
            request.body, 'email%3Dtest%40g.com%26senha%3D_myStrongP4ss%40rd');
        expect(request.headers['Content-Type'], contentType);
        expect(result.fold(id, id), sessionModel);
      },
    );

    test(
      'signInWithEmailAndPassword() successfully authenticate but do not save credentials when user has scheduled deletion',
      () async {
        // arrange
        final jsonFile = 'authentication/login_success_deleted_scheduled.json';
        final jsonData = await JsonUtil.getJson(from: jsonFile);
        final jsonString = JsonUtil.getStringSync(from: jsonFile);
        final sessionModel = SessionModel.fromJson(jsonData);
        _setUpMockHttpClientResponse(jsonString);

        // act
        final result = await repository.signInWithEmailAndPassword(
          emailAddress: email,
          password: password,
        );
        // assert
        expect(result.fold(id, id), sessionModel);
        verifyNever(
            () => appConfiguration.saveApiToken(token: any(named: 'token')));
        verifyNever(() => appConfiguration.saveHash(hash: any(named: 'hash')));
      },
    );

    test(
      'signInWithEmailAndPassword() returns ServerSideFormFieldValidationFailure when invalid credentials are provided',
      () async {
        // arrange
        final jsonFile = 'authentication/login_failure.json';
        final jsonData = await JsonUtil.getJson(from: jsonFile);
        final jsonString = JsonUtil.getStringSync(from: jsonFile);
        final sessionModel = ServerSideFormFieldValidationFailure(
          error: jsonData['error'],
          field: jsonData['field'],
          reason: jsonData['reason'],
          message: jsonData['message'],
        );
        _setUpMockHttpClientResponse(jsonString, statusCode: 400);

        // act
        final result = await repository.signInWithEmailAndPassword(
          emailAddress: email,
          password: password,
        );
        // assert
        expect(result.fold(id, id), sessionModel);
      },
    );

    test(
      'signInOffline() successfully authenticate when valid credentials are provided and device is online',
      () async {
        // arrange
        final jsonFile = 'authentication/login_success.json';
        final jsonData = await JsonUtil.getJson(from: jsonFile);
        final jsonString = JsonUtil.getStringSync(from: jsonFile);
        final sessionModel = SessionModel.fromJson(jsonData);
        _setUpMockHttpClientResponse(jsonString);

        // act
        final result = await repository.signInOffline(
          emailAddress: email,
          password: password,
        );
        // assert
        final request = verify(
          () => ApiProviderMock.httpClient.send(captureAny()),
        ).captured.single;

        expect(request.url.path, '/login');
        expect(request.method, 'POST');
        expect(request.url.queryParameters, {
          'app_version': '1.0.0',
        });
        expect(
            request.body, 'email%3Dtest%40g.com%26senha%3D_myStrongP4ss%40rd');
        expect(request.headers['Content-Type'], contentType);
        expect(result.fold(id, id), sessionModel);
      },
    );

    test(
      'signInOffline() return Failure when device is offline and no previous credentials are stored',
      () async {
        // arrange
        _setUpMockHttpClientResponse('{}', statusCode: 503);
        when(() => appConfiguration.offlineHash).thenAnswer((_) async => '');
        when(() => appConfiguration.apiToken).thenAnswer((_) async => '');

        // act
        final result = await repository.signInOffline(
          emailAddress: email,
          password: password,
        );
        // assert
        expect(result.fold(id, id), InternetConnectionFailure());
      },
    );

    test(
      'signInOffline() successfully authenticate when valid credentials are provided and device is offline',
      () async {
        // arrange
        final jsonFile = 'authentication/login_success.json';
        final jsonData = await JsonUtil.getJson(from: jsonFile);
        final sessionModel = SessionModel.fromJson(jsonData);
        _setUpMockHttpClientResponse('{}', statusCode: 503);
        when(() => appConfiguration.offlineHash)
            .thenAnswer((_) async => hash.toString());
        when(() => appConfiguration.apiToken)
            .thenAnswer((_) async => sessionModel.sessionToken!);
        // act
        final result = await repository.signInOffline(
          emailAddress: email,
          password: password,
        );
        // assert
        expect(result.fold(id, id), sessionModel);
      },
    );
  });
}

class MockAppConfiguration extends Mock implements IAppConfiguration {}

class MockIApiServerConfigure extends Mock implements IApiServerConfigure {}
