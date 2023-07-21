// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/help_center/data/datasources/guardian_data_source.dart';
import 'package:penhas/app/features/help_center/data/models/alert_model.dart';

import '../../../../../utils/json_util.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockApiServerConfigure extends Mock implements IApiServerConfigure {}

void main() {
  late Uri serverEndpoint;
  late http.Client apiClient;
  late IApiServerConfigure serverConfigure;
  late IGuardianDataSource dataSource;
  const sessionToken = 'my_really.long.JWT';

  setUp(() {
    apiClient = MockHttpClient();
    serverConfigure = MockApiServerConfigure();
    serverEndpoint = Uri.https('api.anyserver.io', '/');
    dataSource = GuardianDataSource(
      apiClient: apiClient,
      serverConfiguration: serverConfigure,
    );

    // MockApiServerConfigure configuration
    when(() => serverConfigure.baseUri).thenAnswer((_) => serverEndpoint);
    when(() => serverConfigure.apiToken).thenAnswer((_) async => sessionToken);
    when(() => serverConfigure.userAgent)
        .thenAnswer((_) async => 'iOS 11.4/Simulator/1.0.0');
  });

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  Future<Map<String, String>> _setUpHttpHeader() async {
    final userAgent = await serverConfigure.userAgent;
    return {
      'X-Api-Key': sessionToken,
      'User-Agent': userAgent,
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
    };
  }

  Uri _setUpHttpRequest(String path, Map<String, String> queryParameters) {
    return Uri(
      scheme: serverEndpoint.scheme,
      host: serverEndpoint.host,
      path: path,
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    );
  }

  void _setUpMockPostHttpClientSuccess200(String? bodyContent) {
    when(
      () => apiClient.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        bodyContent!,
        200,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'
        },
      ),
    );
  }

  void _setUpMockPostHttpClientSuccess400(String bodyContent) {
    when(
      () => apiClient.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        bodyContent,
        400,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'
        },
      ),
    );
  }

  group(
    GuardianDataSource,
    () {
      late String bodyContent;
      late UserLocationEntity userLocation;

      setUp(() {
        userLocation = UserLocationEntity(latitude: 1.0, longitude: -1.0);
        bodyContent = JsonUtil.getStringSync(
          from: 'help_center/guardian_alert_warning.json',
        );
      });

      group('alert()', () {
        test(
          'perform a POST with X-API-Key',
          () async {
            // arrange
            const endPointPath = '/me/guardioes/alert';
            final headers = await _setUpHttpHeader();
            final request = _setUpHttpRequest(endPointPath, {
              'gps_lat': '${userLocation.latitude}',
              'gps_long': '${userLocation.longitude}'
            });
            _setUpMockPostHttpClientSuccess200(bodyContent);
            // act
            await dataSource.alert(userLocation);
            // assert
            verify(() => apiClient.post(request, headers: headers)).called(1);
          },
        );
        test(
          'get a valid session for a successful request',
          () async {
            // arrange
            _setUpMockPostHttpClientSuccess200(bodyContent);
            const expected = AlertModel(
              title: 'Alerta enviado!',
              message:
                  'Não há guardiões cadastrados! Nenhum alerta foi enviado.',
            );
            // act
            final actual = await dataSource.alert(userLocation);
            // assert
            expect(actual, expected);
          },
        );

        test(
          'get a GuardianAlertGpsFailure for a invalid gps data on the request',
          () async {
            // arrange
            final bodyWithError = JsonUtil.getStringSync(
              from: 'help_center/guardian_alert_gps_error.json',
            );
            _setUpMockPostHttpClientSuccess400(bodyWithError);
            // assert
            expect(
              () => dataSource.alert(userLocation),
              throwsA(isA<GuardianAlertGpsFailure>()),
            );
          },
        );
      });
    },
  );
}
