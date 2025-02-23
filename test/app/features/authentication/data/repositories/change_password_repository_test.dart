import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/authentication/data/models/password_reset_response_model.dart';
import 'package:penhas/app/features/authentication/data/repositories/change_password_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_up_password.dart';

import '../../../../../utils/api_provider_mock.dart';
import '../../../../../utils/json_util.dart';

class MockIApiServerConfigure extends Mock implements IApiServerConfigure {}

void main() {
  late ChangePasswordRepository sut;
  late IApiServerConfigure serverConfigure;

  late EmailAddress emailAddress;
  late SignUpPassword password;
  late String resetToken;

  const contentType = 'application/x-www-form-urlencoded; charset=utf-8';

  setUp(() {
    ApiProviderMock.init();

    serverConfigure = MockIApiServerConfigure();
    sut = ChangePasswordRepository(
      apiProvider: ApiProviderMock.apiProvider,
      serverConfiguration: serverConfigure,
    );

    emailAddress = EmailAddress('valid@email.com');
    password = SignUpPassword('my_new_str0ng_P4ssw0rd', PasswordValidator());
    resetToken = '666242';

    when(() => serverConfigure.userAgent).thenAnswer((_) async => '1.0.0');
  });

  void _setUpMockHttpClientResponse(String body, {int? statusCode}) {
    ApiProviderMock.apiClientResponse(body, statusCode ?? 200);
  }

  group(ChangePasswordRepository, () {
    group('reset()', () {
      test(
        'return ValidField when password is successfully changed',
        () async {
          // arrange
          final jsonScript = '{"continue": 1}';
          _setUpMockHttpClientResponse(jsonScript);
          final actualResult = ValidField.fromJson(jsonDecode(jsonScript));
          // act
          final result = await sut.reset(
            emailAddress: emailAddress,
            password: password,
            resetToken: resetToken,
          );
          // assert
          final request = verify(
            () => ApiProviderMock.httpClient.send(captureAny()),
          ).captured.single;

          expect(request.url.path, '/reset-password/write-new');
          expect(request.method, 'POST');
          expect(request.headers['Content-Type'], contentType);
          expect(request.url.queryParameters, {
            'app_version': '1.0.0',
            'dry': '0',
            'email': emailAddress.rawValue,
            'senha': password.rawValue,
            'token': resetToken,
          });
          expect(result.fold(id, id), actualResult);
        },
      );
      test(
        'return ServerSideFormFieldValidationFailure when reset password request fails',
        () async {
          // arrange
          final jsonFile = 'authentication/invalid_token_error.json';
          final jsonData = await JsonUtil.getJson(from: jsonFile);
          final jsonString = JsonUtil.getStringSync(from: jsonFile);
          final actualResult = ServerSideFormFieldValidationFailure(
            error: jsonData['error'],
            field: jsonData['field'],
            message: jsonData['message'],
            reason: jsonData['reason'],
          );
          _setUpMockHttpClientResponse(jsonString, statusCode: 400);
          // act
          final result = await sut.reset(
            emailAddress: emailAddress,
            password: password,
            resetToken: resetToken,
          );
          // assert
          expect(result.fold(id, id), actualResult);
        },
      );
    });
    group('request()', () {
      test(
        'return ResetPasswordResponseEntity when request is successful',
        () async {
          // arrange
          final jsonFile = 'authentication/request_reset_password.json';
          final jsonData = await JsonUtil.getJson(from: jsonFile);
          final jsonString = JsonUtil.getStringSync(from: jsonFile);
          final actualResult = PasswordResetResponseModel.fromJson(jsonData);
          _setUpMockHttpClientResponse(jsonString);
          // act
          final result = await sut.request(emailAddress: emailAddress);
          // assert
          final request = verify(
            () => ApiProviderMock.httpClient.send(captureAny()),
          ).captured.single;

          expect(request.url.path, '/reset-password/request-new');
          expect(request.method, 'POST');
          expect(request.headers['Content-Type'], contentType);
          expect(request.url.queryParameters, {
            'app_version': '1.0.0',
            'email': emailAddress.rawValue,
          });

          expect(result.fold(id, id), actualResult);
        },
      );
      test(
        'ServerSideFormFieldValidationFailure when email is not found',
        () async {
          // arrange
          final jsonFile = 'authentication/email_not_found.json';
          final jsonData = await JsonUtil.getJson(from: jsonFile);
          final jsonString = JsonUtil.getStringSync(from: jsonFile);
          final actualResult = ServerSideFormFieldValidationFailure(
            error: jsonData['error'],
            field: jsonData['field'],
            message: jsonData['message'],
            reason: jsonData['reason'],
          );
          _setUpMockHttpClientResponse(jsonString, statusCode: 400);
          // act
          final result = await sut.request(emailAddress: emailAddress);
          // assert
          expect(result.fold(id, id), actualResult);
        },
      );
    });

    group('validToken()', () {
      test(
        'return ValidField when token validation is successful',
        () async {
          // arrange
          final jsonString = '{"continue": 1}';
          _setUpMockHttpClientResponse(jsonString);
          final actualResult = ValidField.fromJson(jsonDecode(jsonString));
          // act
          final result = await sut.validToken(
            emailAddress: emailAddress,
            resetToken: resetToken,
          );
          // assert
          final request = verify(
            () => ApiProviderMock.httpClient.send(captureAny()),
          ).captured.single;

          expect(request.url.path, '/reset-password/write-new');
          expect(request.method, 'POST');
          expect(request.headers['Content-Type'], contentType);
          expect(request.url.queryParameters, {
            'app_version': '1.0.0',
            'dry': '1',
            'email': emailAddress.rawValue,
            'token': resetToken,
          });
          expect(result.fold(id, id), actualResult);
        },
      );
      test(
        'return ServerSideFormFieldValidationFailure for non successful token validation',
        () async {
          // arrange
          final jsonFile = 'authentication/invalid_token_error.json';
          final jsonData = await JsonUtil.getJson(from: jsonFile);
          final jsonString = JsonUtil.getStringSync(from: jsonFile);
          final actualResult = ServerSideFormFieldValidationFailure(
            error: jsonData['error'],
            field: jsonData['field'],
            message: jsonData['message'],
            reason: jsonData['reason'],
          );
          _setUpMockHttpClientResponse(jsonString, statusCode: 400);
          // act
          final result = await sut.validToken(
            emailAddress: emailAddress,
            resetToken: resetToken,
          );
          // assert
          expect(result.fold(id, id), actualResult);
        },
      );
    });
  });
}
