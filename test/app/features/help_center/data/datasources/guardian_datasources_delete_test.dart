import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/help_center/data/datasources/guardian_data_source.dart';
import 'package:penhas/app/features/help_center/domain/entities/guardian_session_entity.dart';

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
    when(() => serverConfigure.apiToken)
        .thenAnswer((_) => Future.value(sessionToken));
    when(() => serverConfigure.userAgent)
        .thenAnswer((_) => Future.value('iOS 11.4/Simulator/1.0.0'));
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

  void _setUpMockPostHttpClientSuccess204() {
    when(
      () => apiClient.delete(
        any(),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        '',
        204,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'
        },
      ),
    );
  }

  group(
    GuardianDataSource,
    () {
      late GuardianContactEntity guardian;

      setUp(() {
        guardian = const GuardianContactEntity(
          id: 1,
          name: 'Maria',
          mobile: '1191910101',
          status: 'pending',
        );
      });

      group('delete()', () {
        test(
          'perform a DELETE with X-API-Key',
          () async {
            // arrange
            final endPointPath = '/me/guardioes/${guardian.id}';
            final headers = await _setUpHttpHeader();
            final request = _setUpHttpRequest(endPointPath, {});
            _setUpMockPostHttpClientSuccess204();
            // act
            await dataSource.delete(guardian);
            // assert
            verify(() => apiClient.delete(request, headers: headers)).called(1);
          },
        );
        test(
          'get a valid ValidField for a successful delete',
          () async {
            // arrange
            _setUpMockPostHttpClientSuccess204();
            const actual = ValidField();
            // act
            final received = await dataSource.delete(guardian);
            // assert
            expect(actual, received);
          },
        );
      });
    },
  );
}
