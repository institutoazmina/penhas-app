import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/features/authentication/data/datasources/change_password_data_source.dart';
import 'package:penhas/app/features/authentication/data/models/password_reset_response_model.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_up_password.dart';

import '../../../../../utils/helper.mocks.dart';
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

  setUp(() {
    dataSource = ChangePasswordDataSource(
      apiClient: mockHttpClient,
      serverConfiguration: mockApiServerConfigure,
    );
    emailAddress = EmailAddress('valid@email.com');
    password = SignUpPassword('my_str0ng_P4ssw@rd', PasswordValidator());
    validToken = '666242';

    // MockApiServerConfigure configuration
    when(mockApiServerConfigure.baseUri).thenAnswer((_) => serverEndpoint);
    when(mockApiServerConfigure.userAgent)
        .thenAnswer((_) => Future.value(userAgent));

    httpHeader = {
      'User-Agent': userAgent,
      'Content-Type': 'application/x-www-form-urlencoded'
    };
  });

  group('ChangePasswordDataSource', () {
    Uri? httpResquest;
    Map<String, String?> queryParameters;
    group('request', () {
      setUp(() {
        queryParameters = {
          'app_version': userAgent,
          'email': emailAddress!.rawValue,
        };
        httpResquest = Uri(
          scheme: serverEndpoint.scheme,
          host: serverEndpoint.host,
          path: '/reset-password/request-new',
          queryParameters: queryParameters,
        );
      });

      test(
          'should perform a POST with parameters and application/x-www-form-urlencoded header',
          () async {
        // arrange
        final bodyContent = JsonUtil.getStringSync(
          from: 'authentication/request_reset_password.json',
        );
        when(mockHttpClient.post(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(bodyContent, 200));
        // act
        await dataSource.request(emailAddress: emailAddress);
        // assert
        verify(mockHttpClient.post(httpResquest, headers: httpHeader));
      });
      test('should return SessionModel when the response code is 200 (success)',
          () async {
        // arrange
        final jsonData = await JsonUtil.getJson(
          from: 'authentication/request_reset_password.json',
        );
        final bodyContent = JsonUtil.getStringSync(
          from: 'authentication/request_reset_password.json',
        );
        final expectedModel = PasswordResetResponseModel.fromJson(jsonData);
        when(mockHttpClient.post(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(bodyContent, 200));
        // act
        final result = await dataSource.request(emailAddress: emailAddress);
        // assert
        expect(result, expectedModel);
      });
      test(
          'should throw ApiProviderException when the response code is nonsuccess (non 200)',
          () async {
        // arrange
        final jsonData =
            JsonUtil.getStringSync(from: 'authentication/email_not_found.json');
        final bodyContent =
            await JsonUtil.getJson(from: 'authentication/email_not_found.json');
        when(mockHttpClient.post(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(jsonData, 400));
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

    group('reset', () {
      setUp(() {
        queryParameters = {
          'dry': '0',
          'app_version': userAgent,
          'email': emailAddress!.rawValue,
          'senha': password!.rawValue,
          'token': validToken,
        };
        httpResquest = Uri(
          scheme: serverEndpoint.scheme,
          host: serverEndpoint.host,
          path: '/reset-password/write-new',
          queryParameters: queryParameters,
        );
      });

      test(
          'should perform a POST with parameters and application/x-www-form-urlencoded header',
          () async {
        // arrange
        final bodyContent = JsonUtil.getStringSync(
          from: 'authentication/request_reset_password.json',
        );
        when(mockHttpClient.post(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(bodyContent, 200));
        // act
        await dataSource.reset(
          emailAddress: emailAddress,
          password: password,
          resetToken: validToken,
        );
        // assert
        verify(
          mockHttpClient.post(
            httpResquest,
            headers: httpHeader,
          ),
        );
      });
      test('should return ValidField when the response code is 200 (success)',
          () async {
        // arrange
        final bodyContent = JsonUtil.getStringSync(
          from: 'authentication/request_reset_password.json',
        );
        when(mockHttpClient.post(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(bodyContent, 200));
        // act
        final result = await dataSource.reset(
          emailAddress: emailAddress,
          password: password,
          resetToken: validToken,
        );
        // assert
        expect(result, const ValidField());
      });
      test(
          'should throw ApiProviderException when the response code is nonsuccess (non 200)',
          () async {
        // arrange
        final jsonData =
            JsonUtil.getStringSync(from: 'authentication/email_not_found.json');
        final bodyContent =
            await JsonUtil.getJson(from: 'authentication/email_not_found.json');
        when(mockHttpClient.post(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(jsonData, 400));
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
      });
    });
  });
}
