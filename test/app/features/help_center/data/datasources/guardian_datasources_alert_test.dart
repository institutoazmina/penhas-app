import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/help_center/data/datasources/guardian_data_source.dart';
import 'package:penhas/app/features/help_center/data/models/alert_model.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

void main() {
  late final MockHttpClient apiClient = MockHttpClient();
  late final MockIApiServerConfigure serverConfigure =
      MockIApiServerConfigure();
  late IGuardianDataSource dataSource;
  final Uri serverEndpoint = Uri.https('api.anyserver.io', '/');
  const String sessionToken = 'my_really.long.JWT';

  setUp(() {
    dataSource = GuardianDataSource(
      apiClient: apiClient,
      serverConfiguration: serverConfigure,
    );

    // MockApiServerConfigure configuration
    when(serverConfigure.baseUri).thenAnswer((_) => serverEndpoint);
    when(serverConfigure.apiToken)
        .thenAnswer((_) => Future.value(sessionToken));
    when(serverConfigure.userAgent)
        .thenAnswer((_) => Future.value('iOS 11.4/Simulator/1.0.0'));
  });

  Future<Map<String, String>> _setUpHttpHeader() async {
    final userAgent = await serverConfigure.userAgent;
    return {
      'X-Api-Key': sessionToken,
      'User-Agent': userAgent,
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
    };
  }

  Uri _setuHttpRequest(String path, Map<String, String> queryParameters) {
    return Uri(
      scheme: serverEndpoint.scheme,
      host: serverEndpoint.host,
      path: path,
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    );
  }

  PostExpectation<Future<http.Response>> _mockPostRequest() {
    return when(
      apiClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      ),
    );
  }

  void _setUpMockPostHttpClientSuccess200(String? bodyContent) {
    _mockPostRequest().thenAnswer(
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
    _mockPostRequest().thenAnswer(
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
    'GuardianDataSource',
    () {
      String? bodyContent;
      UserLocationEntity? userLocation;

      setUp(() {
        userLocation = const UserLocationEntity(latitude: 1.0, longitude: -1.0);
        bodyContent = JsonUtil.getStringSync(
          from: 'help_center/guardian_alert_warning.json',
        );
      });

      group('alert()', () {
        test(
          'should perform a POST with X-API-Key',
          () async {
            // arrange
            const endPointPath = '/me/guardioes/alert';
            final headers = await _setUpHttpHeader();
            final request = _setuHttpRequest(endPointPath, {
              'gps_lat': '${userLocation!.latitude}',
              'gps_long': '${userLocation!.longitude}'
            });
            _setUpMockPostHttpClientSuccess200(bodyContent);
            // act
            await dataSource.alert(userLocation);
            // assert
            verify(apiClient.post(request, headers: headers));
          },
        );
        test(
          'should get a valid session for a successful request',
          () async {
            // arrange
            _setUpMockPostHttpClientSuccess200(bodyContent);
            const expected = AlertModel(
              title: 'Alerta enviado!',
              message:
                  'N??o h?? guardi??es cadastrado! Nenhum alerta foi enviado.',
            );
            // act
            final received = await dataSource.alert(userLocation);
            // assert
            expect(received, expected);
          },
        );

        test(
          'should get a GuardianAlertGpsFailure for a invalid gps data on the request',
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
