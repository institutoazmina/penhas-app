import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:penhas/app/features/help_center/data/datasources/guardian_data_source.dart';
import 'package:penhas/app/features/help_center/data/models/guardian_session_model.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

void main() {
  late final MockHttpClient apiClient = MockHttpClient();
  late final MockIApiServerConfigure serverConfigure =
      MockIApiServerConfigure();
  final Uri serverEndpoint = Uri.https('api.anyserver.io', '/');
  late final IGuardianDataSource dataSource = GuardianDataSource(
    apiClient: apiClient,
    serverConfiguration: serverConfigure,
  );
  const String sessionToken = 'my_really.long.JWT';

  setUp(() {
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

  PostExpectation<Future<http.Response>> _mockGetRequest() {
    return when(
      apiClient.get(
        any,
        headers: anyNamed('headers'),
      ),
    );
  }

  void _setUpMockGetHttpClientSuccess200(String? bodyContent) {
    _mockGetRequest().thenAnswer(
      (_) async => http.Response(
        bodyContent!,
        200,
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

      setUp(() {
        bodyContent =
            JsonUtil.getStringSync(from: 'help_center/guardian_list.json');
      });

      group('fetch()', () {
        test(
          'should perform a GET with X-API-Key',
          () async {
            // arrange
            const endPointPath = '/me/guardioes';
            final headers = await _setUpHttpHeader();
            final request = _setuHttpRequest(endPointPath, {});
            _setUpMockGetHttpClientSuccess200(bodyContent);
            // act
            await dataSource.fetch();
            // assert
            verify(apiClient.get(request, headers: headers));
          },
        );
        test(
          'should get a valid GuardianSession for a successful request',
          () async {
            // arrange
            _setUpMockGetHttpClientSuccess200(bodyContent);
            final jsonData =
                await JsonUtil.getJson(from: 'help_center/guardian_list.json');
            final expected = GuardianSessionModel.fromJson(jsonData);
            // act
            final received = await dataSource.fetch();
            // assert
            expect(expected, received);
          },
        );
      });
    },
  );
}
