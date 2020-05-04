import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/authentication/data/datasources/change_password_data_source.dart';
import 'package:penhas/app/features/authentication/data/models/password_reset_response_model.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';

import '../../../../../utils/json_util.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockApiServerConfigure extends Mock implements IApiServerConfigure {}

void main() {
  IChangePasswordDataSource dataSource;
  MockHttpClient mockHttpClient;
  MockApiServerConfigure mockApiServerConfigure;
  EmailAddress emailAddress;
  Uri serverEndpoint;
  String userAgent;
  Map<String, String> httpHeader;

  setUp(() async {
    mockHttpClient = MockHttpClient();
    mockApiServerConfigure = MockApiServerConfigure();
    dataSource = ChangePasswordDataSource(
      apiClient: mockHttpClient,
      serverConfiguration: mockApiServerConfigure,
    );
    emailAddress = EmailAddress('valid@email.com');
    serverEndpoint = Uri.https('api.anyserver.io', '/');

    // MockApiServerConfigure configuration
    when(mockApiServerConfigure.baseUri).thenAnswer((_) => serverEndpoint);
    when(mockApiServerConfigure.userAgent())
        .thenAnswer((_) => Future.value("iOS 11.4/Simulator/1.0.0"));

    userAgent = await mockApiServerConfigure.userAgent();
    httpHeader = {
      'User-Agent': userAgent,
      'Content-Type': 'application/x-www-form-urlencoded'
    };
  });

  group('ChangePasswordDataSource', () {
    Uri httpResquest;
    Map<String, String> queryParameters;
    group('request', () {
      setUp(() {
        queryParameters = {
          'app_version': userAgent,
          'email': emailAddress.rawValue,
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
            from: 'authentication/request_reset_password.json');
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
            from: 'authentication/request_reset_password.json');
        final bodyContent = JsonUtil.getStringSync(
            from: 'authentication/request_reset_password.json');
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
            () async => await sut(emailAddress: emailAddress),
            throwsA(isA<ApiProviderException>()
                .having((e) => e.bodyContent, 'Got bodyContent', bodyContent)));
      });
    });
  });
}
