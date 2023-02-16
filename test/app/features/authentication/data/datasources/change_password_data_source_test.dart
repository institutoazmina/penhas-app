import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/authentication/data/datasources/change_password_data_source.dart';
import 'package:penhas/app/features/authentication/data/models/password_reset_response_model.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_up_password.dart';

import '../../../../../utils/json_util.dart';

void main() {
  late final MockHttpClient mockHttpClient = MockHttpClient();
  late final MockIApiServerConfigure mockApiServerConfigure =
      MockIApiServerConfigure();

  late IChangePasswordDataSource dataSource;
  EmailAddress? emailAddress;
  SignUpPassword? password;
  String? validToken;
  final Uri serverEndpoint = Uri.https('api.anyserver.io', '/');
  const String userAgent = 'iOS 11.4/Simulator/1.0.0';
  late Map<String, String> httpHeader;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    dataSource = ChangePasswordDataSource(
      apiClient: mockHttpClient,
      serverConfiguration: mockApiServerConfigure,
    );
    emailAddress = EmailAddress('valid@email.com');
    password = SignUpPassword('my_str0ng_P4ssw@rd', PasswordValidator());
    validToken = '666242';

    // MockApiServerConfigure configuration
    when(() => mockApiServerConfigure.baseUri).thenReturn(serverEndpoint);
    when(() => mockApiServerConfigure.userAgent)
        .thenAnswer((_) async => userAgent);

    httpHeader = {
      'User-Agent': userAgent,
      'Content-Type': 'application/x-www-form-urlencoded'
    };
  });

  group(ChangePasswordDataSource, () {
    late Uri httpRequest;
    late Map<String, String?> queryParameters;
    group('request()', () {
      setUp(() {
        queryParameters = {
          'app_version': userAgent,
          'email': emailAddress!.rawValue,
        };
        httpRequest = Uri(
          scheme: serverEndpoint.scheme,
          host: serverEndpoint.host,
          path: '/reset-password/request-new',
          queryParameters: queryParameters,
        );
      });

      test(
        'must performance POST with user-agent and header configured',
        () async {
          // arrange
          final bodyContent = JsonUtil.getStringSync(
            from: 'authentication/request_reset_password.json',
          );
          when(() => mockHttpClient.post(any(), headers: any(named: 'headers')))
              .thenAnswer(
                  (_) async => http.Response(bodyContent, HttpStatus.ok));
          // act
          await dataSource.request(emailAddress: emailAddress);
          // assert
          verify(() => mockHttpClient.post(httpRequest, headers: httpHeader))
              .called(1);
        },
      );
      test(
        'return SessionModel when the response code is 200 (success)',
        () async {
          // arrange
          final jsonData = await JsonUtil.getJson(
            from: 'authentication/request_reset_password.json',
          );
          final bodyContent = JsonUtil.getStringSync(
            from: 'authentication/request_reset_password.json',
          );
          final expectedModel = PasswordResetResponseModel.fromJson(jsonData);
          when(() => mockHttpClient.post(any(), headers: any(named: 'headers')))
              .thenAnswer(
                  (_) async => http.Response(bodyContent, HttpStatus.ok));
          // act
          final result = await dataSource.request(emailAddress: emailAddress);
          // assert
          expect(result, expectedModel);
        },
      );
      test(
          'throw ApiProviderException when the response code is nonsuccess (non 200)',
          () async {
        // arrange
        final jsonData =
            JsonUtil.getStringSync(from: 'authentication/email_not_found.json');
        final bodyContent =
            await JsonUtil.getJson(from: 'authentication/email_not_found.json');
        when(() => mockHttpClient.post(any(), headers: any(named: 'headers')))
            .thenAnswer(
                (_) async => http.Response(jsonData, HttpStatus.notFound));
        // act
        final sut = dataSource.request;
        // assert
        expect(
          () => sut(emailAddress: emailAddress),
          throwsA(
            isA<ApiProviderException>()
                .having((e) => e.bodyContent, 'Got bodyContent', bodyContent),
          ),
        );
      });
    });

    group('reset()', () {
      setUp(() {
        queryParameters = {
          'dry': '0',
          'app_version': userAgent,
          'email': emailAddress!.rawValue,
          'senha': password!.rawValue,
          'token': validToken,
        };
        httpRequest = Uri(
          scheme: serverEndpoint.scheme,
          host: serverEndpoint.host,
          path: '/reset-password/write-new',
          queryParameters: queryParameters,
        );
      });

      test(
        'must performance POST with user-agent and header configured',
        () async {
          // arrange
          final bodyContent = JsonUtil.getStringSync(
            from: 'authentication/request_reset_password.json',
          );
          when(() => mockHttpClient.post(any(), headers: any(named: 'headers')))
              .thenAnswer(
                  (_) async => http.Response(bodyContent, HttpStatus.ok));
          // act
          await dataSource.reset(
            emailAddress: emailAddress,
            password: password,
            resetToken: validToken,
          );
          // assert
          verify(() => mockHttpClient.post(
                httpRequest,
                headers: httpHeader,
              )).called(1);
        },
      );
      test(
        'return ValidField when the response code is 200 (success)',
        () async {
          // arrange
          final bodyContent = JsonUtil.getStringSync(
            from: 'authentication/request_reset_password.json',
          );
          when(() => mockHttpClient.post(any(), headers: any(named: 'headers')))
              .thenAnswer(
                  (_) async => http.Response(bodyContent, HttpStatus.ok));
          // act
          final result = await dataSource.reset(
            emailAddress: emailAddress,
            password: password,
            resetToken: validToken,
          );
          // assert
          expect(result, const ValidField());
        },
      );
      test(
        'throw ApiProviderException when the response code is nonsuccess (non 200)',
        () async {
          // arrange
          final jsonData = JsonUtil.getStringSync(
              from: 'authentication/email_not_found.json');
          final bodyContent = await JsonUtil.getJson(
              from: 'authentication/email_not_found.json');
          when(() => mockHttpClient.post(any(), headers: any(named: 'headers')))
              .thenAnswer(
                  (_) async => http.Response(jsonData, HttpStatus.notFound));
          // act
          final sut = dataSource.reset;
          // assert
          expect(
            () => sut(
              emailAddress: emailAddress,
              password: password,
              resetToken: validToken,
            ),
            throwsA(
              isA<ApiProviderException>()
                  .having((e) => e.bodyContent, 'Got bodyContent', bodyContent),
            ),
          );
        },
      );
    });

    group('validToken()', () {
      setUp(() {
        queryParameters = {
          'dry': '1',
          'app_version': userAgent,
          'email': emailAddress!.rawValue,
          'token': validToken,
        };
        httpRequest = Uri(
          scheme: serverEndpoint.scheme,
          host: serverEndpoint.host,
          path: '/reset-password/write-new',
          queryParameters: queryParameters,
        );
      });

      test(
        'must performance POST with user-agent and header configured',
        () async {
          // arrange
          final response = http.Response('{}', HttpStatus.ok);
          when(() => mockHttpClient.post(any(), headers: any(named: 'headers')))
              .thenAnswer((_) async => response);
          // act
          await dataSource.validToken(
            emailAddress: emailAddress,
            resetToken: validToken,
          );
          // assert
          verify(() => mockHttpClient.post(httpRequest, headers: httpHeader))
              .called(1);
        },
      );

      test(
        'returns ValidField when response is ok',
        () async {
          // arrange
          final response = http.Response('{}', HttpStatus.ok);
          when(() => mockHttpClient.post(
                any(),
                headers: any(named: 'headers'),
              )).thenAnswer((_) async => response);
          // arrange
          final result = await dataSource.validToken(
            emailAddress: emailAddress,
            resetToken: validToken,
          );
          // act
          expect(result, const ValidField());
        },
      );

      test('throws ApiProviderException when response is not ok', () async {
        // arrange

        final response = http.Response(
          '{"error": "test error"}',
          HttpStatus.badRequest,
        );
        when(() => mockHttpClient.post(
              any(),
              headers: any(named: 'headers'),
            )).thenAnswer((_) async => response);
        // act
        final sut = dataSource.validToken;
        // assert
        expect(
          () => sut(
            emailAddress: emailAddress,
            resetToken: validToken,
          ),
          throwsA(
            isA<ApiProviderException>().having(
              (e) => e.bodyContent,
              'Got bodyContent',
              {'error': 'test error'},
            ),
          ),
        );
      });
    });
  });
}

class MockIApiServerConfigure extends Mock implements IApiServerConfigure {}

class MockHttpClient extends Mock implements http.Client {}
